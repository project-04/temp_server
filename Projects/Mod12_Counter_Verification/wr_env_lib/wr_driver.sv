class wr_driver extends uvm_driver #(wr_trans);
	`uvm_component_utils(wr_driver)

	virtual counter_if.DRV_MP vif;
 
  	agent_config agent_configh;
	
	function new(string name ="wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	task send_to_dut(wr_trans xtn);
    		//`uvm_info("AGENT_DRIVER_SEND_TO_DUT_STRAT", "START", UVM_LOW)
    		
		@(vif.drv_cb);

		vif.drv_cb.up   	<= xtn.up;
		vif.drv_cb.reset_n  	<= xtn.reset_n;
		vif.drv_cb.load  	<= xtn.load;
		vif.drv_cb.data_in	<= xtn.data_in;
		
		//xtn.print();
   
   		`uvm_info("WR_AGENT_DRIVER_SEND_TO_DUT_END", "END", UVM_LOW)
	endtask
		
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
      	//	`uvm_info("WR_AGENT_DRIVER_RUN_PHASE_START", "START", UVM_LOW)
		
		@(vif.drv_cb);
		vif.drv_cb.reset_n <= 1'b1;
		
		@(vif.drv_cb);
		vif.drv_cb.reset_n <= 1'b0;
		
		forever
		begin
			seq_item_port.get_next_item(req);
		//	send_to_dut(req);
			seq_item_port.item_done();
		end
   
       		//`uvm_info("WR_AGENT_DRIVER_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass
