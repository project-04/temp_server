class apb_driver extends uvm_driver #(apb_xtn);
   `uvm_component_utils(apb_driver)
	
   virtual apb_intf.APB_DRV_MP apb_if;
   apb_agent_config apb_cfg;

   extern function new(string name ="apb_driver", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task send_to_dut(apb_xtn xtn);
   extern function void report_phase(uvm_phase phase);
 endclass

 function apb_driver :: new(string name="apb_driver", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void apb_driver :: build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db #(apb_agent_config)::get(this, "", "apb_agent_config", apb_cfg))
     `uvm_fatal(get_type_name(), "Cannot get the cfg inside master driver")
 endfunction 

 function void apb_driver :: connect_phase(uvm_phase phase);
  	 apb_if=apb_cfg.apb_if;
 endfunction

 task apb_driver :: run_phase(uvm_phase phase);
  @(apb_if.apb_drv_cb);
   apb_if.apb_drv_cb.PRESETn <= 1'b0;

   repeat(3)
   @(apb_if.apb_drv_cb);
   apb_if.apb_drv_cb.PRESETn<=1'b1;

   forever 
     begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       seq_item_port.item_done();
     end
 endtask

 task apb_driver :: send_to_dut(apb_xtn xtn);
   @(apb_if.apb_drv_cb);
   apb_if.apb_drv_cb.PRESETn <= 1'b1;
   apb_if.apb_drv_cb.PADDR <= xtn.PADDR;
   apb_if.apb_drv_cb.PWRITE <= xtn.PWRITE;
   apb_if.apb_drv_cb.PSEL <= 1'b1;
   apb_if.apb_drv_cb.PENABLE <=1'b0;
   if(xtn.PWRITE)
     apb_if.apb_drv_cb.PWDATA <= xtn.PWDATA;
   
   @(apb_if.apb_drv_cb);
   apb_if.apb_drv_cb.PENABLE<=1'b1;
   wait(apb_if.apb_drv_cb.PREADY)
   if(xtn.PWRITE == 1'b0)
     xtn.PRDATA = apb_if.apb_drv_cb.PRDATA;
   `uvm_info(get_type_name(), $sformatf("The Transaction sent to the DUT is from spi master driver is  \n %s", xtn.sprint()), UVM_LOW)
   apb_cfg.apb_drv_sent_xtn_cnt++;

   apb_if.apb_drv_cb.PSEL <=1'b0;
   apb_if.apb_drv_cb.PENABLE<=1'b0;
 endtask


 function void apb_driver :: report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("APB DRIVER: No of data sent from APB DRIVER are : %0d", apb_cfg.apb_drv_sent_xtn_cnt), UVM_LOW)
 endfunction
