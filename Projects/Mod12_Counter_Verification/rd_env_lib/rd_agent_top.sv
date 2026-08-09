class rd_agent_config extends uvm_object;
	`uvm_object_utils(rd_agent_config)

	virtual counter_if vif;
    	
    	uvm_active_passive_enum is_active = UVM_ACTIVE;
    	
	function new(string name="rd_agent_config");
		super.new(name);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class rd_trans extends uvm_sequence_item;
	`uvm_object_utils(rd_trans)
     
/*	rand 	logic up;
	rand	logic reset_n;
	rand 	logic load;
	rand 	logic [3:0] data_in;*/
	
		logic [3:0] data_out;
 
	function new(string name = "rd_trans");
		super.new(name);
	endfunction
	
/*	constraint CON1 {data_in inside {[0:11]};}
	constraint CON2 {load dist {1:=10, 0:=50};}
	constraint CON3 {up dist {0:=50,1:=50};}
	constraint CON4 {reset_n dist {0:=90,1:=3};}*/
 
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
  /*       	printer.print_field("time",	$time,  	$bits($time),	UVM_DEC);
	    	printer.print_field("up",	this.up,  	$bits(up), 	UVM_DEC);
	    	printer.print_field("reset_n",	this.reset_n,  	$bits(reset_n), UVM_DEC);
	    	printer.print_field("load",	this.load, 	$bits(load), 	UVM_DEC);
	    	printer.print_field("data_in", 	this.data_in,  	$bits(data_in),	UVM_DEC);*/
	    	
		printer.print_field("data_out", this.data_out, $bits(data_out),	UVM_DEC);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class rd_sequencer extends uvm_sequencer #(rd_trans);
	`uvm_component_utils(rd_sequencer)

	function new(string name="rd_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class rd_monitor extends uvm_monitor;
	`uvm_component_utils(rd_monitor)

	virtual counter_if.MON_MP vif;
 	
 	rd_trans xtn;
 
   	uvm_analysis_port #(rd_trans) monitor_port;
	
	
	function new(string name ="rd_monitor",uvm_component parent);
		super.new(name,parent);
		
     		monitor_port = new("monitor_port", this);
	endfunction
	
	task collect_data();
 		//`uvm_info("AGENT_MONITOR_COLLECT_DATA_START", "START", UVM_LOW)
           
		xtn = rd_trans::type_id::create("xtn");
		
		@(vif.mon_cb);
    	@(vif.mon_cb);
		begin
			
		/*		xtn.up 		= vif.mon_cb.up;
				xtn.reset_n  	= vif.mon_cb.reset_n;
				xtn.load  	= vif.mon_cb.load;
				xtn.data_in     = vif.mon_cb.data_in;*/
				
				xtn.data_out 	= vif.mon_cb.data_out;
				
				`uvm_info("READ_MONITOR", $sformatf("%s", xtn.sprint()), UVM_LOW)
				monitor_port.write(xtn);
        
        			//`uvm_info("RD_AGENT_MONITOR_COLLECT_DATA_END", "END", UVM_LOW)
		end
   
   	@(vif.mon_cb);
	endtask

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
	//	`uvm_info("rd_AGENT_MONITOR_RUN_PHASE_START", "START", UVM_LOW)
		
   		@(vif.mon_cb);
   	@(vif.mon_cb);
		forever
		begin
			collect_data();
		end
   		
   		//`uvm_info("rd_AGENT_MONITOR_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass

//--------------------------------------------------------------------------------------------------------------
/*
class rd_driver extends uvm_driver #(rd_trans);
	`uvm_component_utils(rd_driver)

	virtual counter_if.DRV_MP vif;
	
	function new(string name ="rd_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	task send_to_dut(rd_trans xtn);
    		//`uvm_info("AGENT_DRIVER_SEND_TO_DUT_STRAT", "START", UVM_LOW)
    		
		@(vif.drv_cb);

		vif.drv_cb.up   	<= xtn.up;
		vif.drv_cb.reset_n  	<= xtn.reset_n;
		vif.drv_cb.load  	<= xtn.load;
		vif.drv_cb.data_in	<= xtn.data_in;
		
		xtn.print();
   
   		`uvm_info("rd_AGENT_DRIVER_SEND_TO_DUT_END", "END", UVM_LOW)
	endtask
		
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
      	//	`uvm_info("rd_AGENT_DRIVER_RUN_PHASE_START", "START", UVM_LOW)
		
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
   
       		//`uvm_info("rd_AGENT_DRIVER_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass


//--------------------------------------------------------------------------------------------------------------

class rd_seqs extends uvm_sequence #(rd_trans);
	`uvm_object_utils(rd_seqs)

	function new(string name="rd_seqs");
		super.new(name);
	endfunction
endclass

class sequence_xtns extends rd_seqs;
	`uvm_object_utils(sequence_xtns)

	function new(string name = "sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(50)
		begin
			req=rd_trans::type_id::create("req");
	   		
	   		start_item(req);
	   		assert(req.randomize());
	   		finish_item(req);	
      		end
      //  repeat(3)
		begin
      	req=rd_trans::type_id::create("req");
     	start_item(req);
	   	assert(req.randomize() with {load==1; data_in==9;});
	 		finish_item(req);	
    end
  	endtask
endclass
*/

//--------------------------------------------------------------------------------------------------------------

class rd_agent extends uvm_agent;
	`uvm_component_utils(rd_agent)
	
	rd_monitor rd_monh;
//	rd_sequencer rd_seqrh;
//	rd_driver rd_drvh;
	rd_agent_config rd_agent_configh;
		
	function new(string name = "rd_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
//	      uvm_config_db #(rd_agent_config)::set(this,$sformatf("envh.rd_agent_top.rd_agenth[%0d]",i),"rd_agent_config",rd_agent_configh[i]);
		if(!uvm_config_db #(rd_agent_config)::get(this, "", "rd_agent_config", rd_agent_configh))
		begin
			`uvm_fatal("rd_agent", "cannot get the rd_agent_configh form rd_agent_config");
		end
		
		rd_monh = rd_monitor::type_id::create("rd_monh", this);
		
	/*	if(rd_agent_configh.is_active == UVM_ACTIVE)
		begin
			rd_seqrh = rd_sequencer::type_id::create("rd_seqrh", this); 
			rd_drvh  = rd_driver::type_id::create("rd_drvh", this);
		end*/
	endfunction
  
	function void connect_phase(uvm_phase phase);
 	  rd_monh.vif = rd_agent_configh.vif;
	/*	if(rd_agent_configh.is_active==UVM_ACTIVE)
		begin
			rd_drvh.seq_item_port.connect(rd_seqrh.seq_item_export);
   		rd_drvh.vif = rd_agent_configh.vif;
	  	end*/
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------


class rd_agent_top extends uvm_agent;
	`uvm_component_utils(rd_agent_top)
 
 	env_config env_configh;
	rd_agent rd_agenth[];
		
	function new(string name = "rd_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
   
   if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
			`uvm_fatal("env", "cannot get the env_configh form env_config");
        
     		rd_agenth = new[env_configh.no_of_agents];
            	
		foreach(rd_agenth[i])
		begin
			rd_agenth[i] =  rd_agent::type_id::create($sformatf("rd_agenth[%0d]",i), this);
		end


	endfunction
endclass
