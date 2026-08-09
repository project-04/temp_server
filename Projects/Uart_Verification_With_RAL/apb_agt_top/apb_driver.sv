class apb_driver extends uvm_driver #(apb_trans);
      `uvm_component_utils(apb_driver)
   
      virtual apb_if.DRV_MP vif;  
      apb_config apb_cfg;
 
  function new(string name="apb_driver",uvm_component parent);
           super.new(name,parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
                if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
	         `uvm_fatal("CONFIG","cannot get() apb_cfg from uvm_config_db. Have you set() it?") 
  endfunction

  function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                vif = apb_cfg.vif;
                $display("DRIVER: %p",vif);
  endfunction

  task send_to_dut(apb_trans xtn);

        @(vif.drv_cb);

         vif.drv_cb.psel<=1'b1;
         vif.drv_cb.penable<=1'b0; 

	 vif.drv_cb.paddr<=xtn.PADDR;
         vif.drv_cb.pwdata<=xtn.PWDATA;
         vif.drv_cb.pwrite<=xtn.PWRITE;

       @(vif.drv_cb);
       vif.drv_cb.psel<=1'b1;
       vif.drv_cb.penable<=1'b1;

       while(vif.drv_cb.pready!==1) 
		@(vif.drv_cb);
        
       if(xtn.PADDR==8'h8 && xtn.PWRITE==0)
         begin
          while(vif.drv_cb.irq!==1)
        	@(vif.drv_cb);

          xtn.IIR = vif.drv_cb.prdata; //Why are we writing to IIR even when it is a Read-only register?
          seq_item_port.put_response(xtn);
          $display("IIR in DRIVER----------%0b",xtn.IIR);
         end
	//	@(vif.drv_cb);
             	//`uvm_info("APB AGENT DRIVER",$sformatf("Send to DUT apb_transaction:"),UVM_LOW)
         	//xtn.print();

         vif.drv_cb.psel<=1'b0;
         vif.drv_cb.penable<=1'b0;
  endtask
    
  task run_phase(uvm_phase phase);
       super.run_phase(phase);

       `uvm_info("APB AGENT DRIVER","Run phase",UVM_HIGH)

       @(vif.drv_cb);      
         vif.drv_cb.presetn<=1'b0;

       @(vif.drv_cb);      
         vif.drv_cb.presetn<=1'b1;
 
               	forever
                  begin
		    seq_item_port.get_next_item(req);
		    send_to_dut(req);
		    seq_item_port.item_done();
		  end
  endtask

endclass

