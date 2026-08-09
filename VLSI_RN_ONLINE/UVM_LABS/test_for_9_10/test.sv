module testing;

	import uvm_pkg::*; 

	`include "uvm_macros.svh"

	class packet extends uvm_sequence_item;
		`uvm_object_utils(packet)
		function new(string name = "packet");
			super.new(name);
		endfunction
	endclass

	class wr_driver extends uvm_driver #(packet); //packet is no need
		`uvm_component_utils(wr_driver)
		function new(string name ="wr_driver",uvm_component parent);
			super.new(name,parent);
		endfunction
		task run_phase(uvm_phase phase);
		   `uvm_info(get_type_name(), "This is Driver run phase", UVM_MEDIUM)
		endtask
	endclass


	class wr_monitor extends uvm_monitor;
		`uvm_component_utils(wr_monitor)
		function new(string name ="wr_monitor",uvm_component parent);
			super.new(name,parent);
		endfunction
		task run_phase(uvm_phase phase);
		   `uvm_info(get_type_name(), "This is Monitor run phase", UVM_MEDIUM)
		endtask
	endclass


	class wr_sequencer extends uvm_sequencer #(packet); //packet is no need
		`uvm_component_utils(wr_sequencer)
		function new(string name="wr_sequencer",uvm_component parent);
			super.new(name,parent);
		endfunction
	endclass


	class wr_agent extends uvm_agent;
		`uvm_component_utils(wr_agent)
		wr_monitor monh;
		wr_sequencer seqrh;
		wr_driver drvh;
		bit is_active;
		function new(string name = "wr_agent", uvm_component parent);
			super.new(name, parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(bit)::get(this, "", "bit", is_active))
			begin
				`uvm_fatal("is_active", "cannot get the is_active form bit");
			end
			monh = wr_monitor::type_id::create("monh", this);
			if(is_active)
			begin
				seqrh = wr_sequencer::type_id::create("seqrh", this); 
				drvh  = wr_driver::type_id::create("drvh", this);
			end
		endfunction
	endclass

	class wr_agt_top extends uvm_env;
		`uvm_component_utils(wr_agt_top)
    		wr_agent agenth1;
    		wr_agent agenth2;
		function new(string name = "wr_agt_top" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agenth1 = wr_agent::type_id::create("agenth1", this);
      			agenth2 = wr_agent::type_id::create("agenth2", this);
			uvm_config_db #(bit)::set(this,"agenth1","bit",0);
			uvm_config_db #(bit)::set(this,"agenth2","bit",1);
		endfunction
		task run_phase(uvm_phase phase);
			uvm_top.print_topology;
		endtask   
	endclass


	class env extends uvm_env;
		`uvm_component_utils(env)
	 	wr_agt_top agent_top_h;
		function new(string name="env",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);	
			super.build_phase(phase);
			agent_top_h = wr_agt_top::type_id::create("agent_top_h", this);
		endfunction
	endclass
		
	class base_test extends uvm_test;
		`uvm_component_utils(base_test)
	   	env envh;
		function new(string name = "base_test" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
		    	super.build_phase(phase);
			envh = env::type_id::create("envh", this);
		endfunction
	endclass
	
	initial
	begin
		run_test("base_test");
	end
endmodule
