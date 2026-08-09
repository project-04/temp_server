class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)

	virtual counter_if.MON_MP vif;
 
 	agent_config agent_configh;
 	
 	trans xtn;
 
   	uvm_analysis_port #(trans) monitor_port;
	
	
	function new(string name ="monitor",uvm_component parent);
		super.new(name,parent);
		
     		monitor_port = new("monitor_port", this);
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
	
	task collect_data();
 		//`uvm_info("AGENT_MONITOR_COLLECT_DATA_START", "START", UVM_LOW)
           
		xtn = trans::type_id::create("xtn");
   xtn.agent_number 		= agent_configh.agent_number;
		
		@(vif.mon_cb);
		begin
			
				xtn.up 		= vif.mon_cb.up;
				xtn.reset_n  	= vif.mon_cb.reset_n;
				xtn.load  	= vif.mon_cb.load;
				xtn.data_in     = vif.mon_cb.data_in;
				
				xtn.data_out 	= vif.mon_cb.data_out;
				
				//xtn.print();
				monitor_port.write(xtn);
        
        			`uvm_info("AGENT_MONITOR_COLLECT_DATA_END", "END", UVM_LOW)
		end
	endtask

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		`uvm_info("AGENT_MONITOR_RUN_PHASE_START", "START", UVM_LOW)
		
		forever
		begin
			collect_data();
		end
   		
   		//`uvm_info("AGENT_MONITOR_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass
