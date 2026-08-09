class wr_agent_config extends uvm_object;
	`uvm_object_utils(wr_agent_config)

	virtual counter_if vif;
    	
    	uvm_active_passive_enum is_active = UVM_ACTIVE;
    	
	function new(string name="wr_agent_config");
		super.new(name);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class wr_trans extends uvm_sequence_item;
	`uvm_object_utils(wr_trans)
     
	rand 	logic up;
	rand	logic reset_n;
	rand 	logic load;
	rand 	logic [3:0] data_in;
	
		logic [3:0] data_out;
 
	function new(string name = "wr_trans");
		super.new(name);
	endfunction
	
	constraint CON1 {data_in inside {[0:11]};}
	constraint CON2 {load dist {1:=10, 0:=50};}
	constraint CON3 {up dist {0:=50,1:=50};}
	constraint CON4 {reset_n dist {0:=90,1:=3};}
 
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
         	printer.print_field("time",	$time,  	$bits($time),	UVM_DEC);
	    	printer.print_field("up",	this.up,  	$bits(up), 	UVM_DEC);
	    	printer.print_field("reset_n",	this.reset_n,  	$bits(reset_n), UVM_DEC);
	    	printer.print_field("load",	this.load, 	$bits(load), 	UVM_DEC);
	    	printer.print_field("data_in", 	this.data_in,  	$bits(data_in),	UVM_DEC);
	    	
	//	printer.print_field("data_out", this.data_out, $bits(data_out),	UVM_DEC);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class wr_sequencer extends uvm_sequencer #(wr_trans);
	`uvm_component_utils(wr_sequencer)

	function new(string name="wr_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------

class wr_monitor extends uvm_monitor;
	`uvm_component_utils(wr_monitor)

	virtual counter_if.MON_MP vif;
 	
 	wr_trans xtn;
 
   	uvm_analysis_port #(wr_trans) monitor_port;
	
	
	function new(string name ="wr_monitor",uvm_component parent);
		super.new(name,parent);
		
     		monitor_port = new("monitor_port", this);
	endfunction
	
	task collect_data();
 		//`uvm_info("AGENT_MONITOR_COLLECT_DATA_START", "START", UVM_LOW)
           
		xtn = wr_trans::type_id::create("xtn");
		
		@(vif.mon_cb);
    	@(vif.mon_cb);
		begin
			
				xtn.up 		= vif.mon_cb.up;
				xtn.reset_n  	= vif.mon_cb.reset_n;
				xtn.load  	= vif.mon_cb.load;
				xtn.data_in     = vif.mon_cb.data_in;
				
			//	xtn.data_out 	= vif.mon_cb.data_out;
				
				`uvm_info("WRITE_MONITOR", $sformatf("%s", xtn.sprint()), UVM_LOW)
				monitor_port.write(xtn);
        
        			//`uvm_info("WR_AGENT_MONITOR_COLLECT_DATA_END", "END", UVM_LOW)
		end
   	@(vif.mon_cb);
	endtask

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
	//	`uvm_info("WR_AGENT_MONITOR_RUN_PHASE_START", "START", UVM_LOW)
			@(vif.mon_cb);
   	@(vif.mon_cb);
		forever
		begin
			collect_data();
		end
   		
   		//`uvm_info("WR_AGENT_MONITOR_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass

//--------------------------------------------------------------------------------------------------------------

class wr_driver extends uvm_driver #(wr_trans);
	`uvm_component_utils(wr_driver)

	virtual counter_if.DRV_MP vif;
	
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
		`uvm_info("WRITE_DRIVER", $sformatf("%s", xtn.sprint()), UVM_LOW)
   		//`uvm_info("WR_AGENT_DRIVER_SEND_TO_DUT_END", "END", UVM_LOW)
      	@(vif.drv_cb);
		@(vif.drv_cb);
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
			send_to_dut(req);
			seq_item_port.item_done();
		end
   
       		//`uvm_info("WR_AGENT_DRIVER_RUN_PHASE_END", "END", UVM_LOW)
	endtask
endclass


//--------------------------------------------------------------------------------------------------------------

class wr_seqs extends uvm_sequence #(wr_trans);
	`uvm_object_utils(wr_seqs)

	function new(string name="wr_seqs");
		super.new(name);
	endfunction
endclass

class sequence_xtns extends wr_seqs;
	`uvm_object_utils(sequence_xtns)

	function new(string name = "sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(50)
		begin
			req=wr_trans::type_id::create("req");
	   		
	   		start_item(req);
	   		assert(req.randomize());
	   		finish_item(req);	
      		end
      /*  repeat(3)
		begin
      	req=wr_trans::type_id::create("req");
     	start_item(req);
	   	assert(req.randomize() with {load==1; data_in==9;});
	 		finish_item(req);	
    end */   
  	endtask
endclass


//--------------------------------------------------------------------------------------------------------------

class wr_agent extends uvm_agent;
	`uvm_component_utils(wr_agent)
	
	wr_monitor wr_monh;
	wr_sequencer wr_seqrh;
	wr_driver wr_drvh;
	wr_agent_config wr_agent_configh;
		
	function new(string name = "wr_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
//	      uvm_config_db #(wr_agent_config)::set(this,$sformatf("envh.wr_agent_top.wr_agenth[%0d]",i),"wr_agent_config",wr_agent_configh[i]);
		if(!uvm_config_db #(wr_agent_config)::get(this, "", "wr_agent_config", wr_agent_configh))
		begin
			`uvm_fatal("wr_agent", "cannot get the wr_agent_configh form wr_agent_config");
		end
		
		wr_monh = wr_monitor::type_id::create("wr_monh", this);
		
		if(wr_agent_configh.is_active == UVM_ACTIVE)
		begin
			wr_seqrh = wr_sequencer::type_id::create("wr_seqrh", this); 
			wr_drvh  = wr_driver::type_id::create("wr_drvh", this);
		end
	endfunction
  
	function void connect_phase(uvm_phase phase);
 	  wr_monh.vif = wr_agent_configh.vif;
		if(wr_agent_configh.is_active==UVM_ACTIVE)
		begin
			wr_drvh.seq_item_port.connect(wr_seqrh.seq_item_export);
   		wr_drvh.vif = wr_agent_configh.vif;
	  	end
	endfunction
endclass

//--------------------------------------------------------------------------------------------------------------


class wr_agent_top extends uvm_agent;
	`uvm_component_utils(wr_agent_top)
	wr_agent wr_agenth[];
 	env_config env_configh;
		
	function new(string name = "wr_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
   
   if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
			`uvm_fatal("env", "cannot get the env_configh form env_config");
        
     		wr_agenth = new[env_configh.no_of_agents];
            	
		foreach(wr_agenth[i])
		begin
			wr_agenth[i] =  wr_agent::type_id::create($sformatf("wr_agenth[%0d]",i), this);
		end

	endfunction
endclass
