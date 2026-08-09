class driver extends uvm_driver #(trans);
	`uvm_component_utils(driver)

	virtual counter_if.DRV_MP vif;
 
  	agent_config agent_configh;
	
	function new(string name ="driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", agent_configh))
		begin
			`uvm_fatal("agent", "cannot get the agent_configh form agent_config");
		end
        endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		vif = agent_configh.vif;
	endfunction

	task send_to_dut(trans xtn);
    		//`uvm_info("AGENT_DRIVER_SEND_TO_DUT_STRAT", "START", UVM_LOW)
    		
		@(vif.drv_cb);

		vif.drv_cb.up   	<= xtn.up;
		vif.drv_cb.reset_n  	<= xtn.reset_n;
		vif.drv_cb.load  	<= xtn.load;
		vif.drv_cb.data_in	<= xtn.data_in;
		
		//xtn.print();
   
   		`uvm_info("AGENT_DRIVER_SEND_TO_DUT_END", "END", UVM_LOW)
	endtask
		
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
      		`uvm_info("AGENT_DRIVER_RUN_PHASE_START", "START", UVM_LOW)
		
		@(vif.drv_cb);
		vif.drv_cb.reset_n <= 1'b1;
		
		@(vif.drv_cb);
		vif.drv_cb.reset_n <= 1'b0;
		
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
   
       		//`uvm_info("AGENT_DRIVER_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass
