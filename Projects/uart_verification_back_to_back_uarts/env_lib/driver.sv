class driver extends uvm_driver #(trans);
	`uvm_component_utils(driver)

	virtual uart_if.DRV_MP vif;
 
  	agent_config agent_configh;
	
	function new(string name ="driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", agent_configh))
		begin
			`uvm_fatal("apb_agent", "cannot get the agent_configh form agent_config");
		end
        endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		vif = agent_configh.vif;
	endfunction

	task send_to_dut(trans xtn);
    		`uvm_info("APB_AGENT_DRIVER_SEND_TO_DUT_STRAT", "START", UVM_LOW)
    		
    		@(vif.drv_cb);

		//vif.drv_cb.PRESETn <= 1'b1;
		vif.drv_cb.PADDR   <= xtn.PADDR;
		vif.drv_cb.PWDATA  <= xtn.PWDATA;
		vif.drv_cb.PWRITE  <= xtn.PWRITE;
		vif.drv_cb.PSEL    <= 1'b1;
		vif.drv_cb.PENABLE <= 1'b0;
		
		@(vif.drv_cb);
		vif.drv_cb.PENABLE <= 1'b1;
		
		while(!vif.drv_cb.PREADY) @(vif.drv_cb); //for VCS
		
		//wait(vif.drv_cb.PREADY);  @(vif.drv_cb); //for questa
     		
		
		if(xtn.PADDR == 32'h08 && xtn.PWRITE == 0)
		begin
			//while(!vif.drv_cb.IRQ) @(vif.drv_cb); //for VCS
			
			wait(vif.drv_cb.IRQ); @(vif.drv_cb); //for questa
      
			xtn.iir = vif.drv_cb.PRDATA;
			$display(get_full_name()," %0d----------iir in DRIVER----------%0h",$time, xtn.iir); //for time %t, %d is ok.
			seq_item_port.put_response(xtn);
		end
   
		vif.drv_cb.PSEL <= 1'b0;
		vif.drv_cb.PENABLE <= 1'b0;
		//xtn.print();
   
   		`uvm_info("APB_AGENT_DRIVER_SEND_TO_DUT_END", "END", UVM_LOW)
	endtask
		
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
      		`uvm_info("APB_AGENT_DRIVER_RUN_PHASE_START", "START", UVM_LOW)
		
		@(vif.drv_cb);
		vif.drv_cb.PRESETn <= 1'b0;
		
		@(vif.drv_cb);
		vif.drv_cb.PRESETn <= 1'b1;
		
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
   
       		`uvm_info("APB_AGENT_DRIVER_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass
