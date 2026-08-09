class wr_monitor extends uvm_monitor;
	`uvm_component_utils(wr_monitor)

	virtual counter_if.MON_MP vif;
 
 	agent_config agent_configh;
 	
 	wr_trans xtn;
 
   	uvm_analysis_port #(wr_trans) monitor_port;
	
	
	function new(string name ="wr_monitor",uvm_component parent);
		super.new(name,parent);
		
     		monitor_port = new("monitor_port", this);
	endfunction
	
	task collect_data();
 		//`uvm_info("AGENT_MONITOR_COLLECT_DATA_START", "START", UVM_LOW)
           
		xtn = wr_trans::type_id::create("xtn");
   xtn.agent_number 		= agent_configh.agent_number;
		
		@(vif.mon_cb);
		begin
			
				xtn.up 		= vif.mon_cb.up;
				xtn.reset_n  	= vif.mon_cb.reset_n;
				xtn.load  	= vif.mon_cb.load;
				xtn.data_in     = vif.mon_cb.data_in;
				
			//	xtn.data_out 	= vif.mon_cb.data_out;
				
				//xtn.print();
				monitor_port.write(xtn);
        
        			`uvm_info("WR_AGENT_MONITOR_COLLECT_DATA_END", "END", UVM_LOW)
		end
	endtask

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
	//	`uvm_info("WR_AGENT_MONITOR_RUN_PHASE_START", "START", UVM_LOW)
		
		forever
		begin
			collect_data();
		end
   		
   		//`uvm_info("WR_AGENT_MONITOR_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass
