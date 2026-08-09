class config extends uvm_object;
	`uvm_object_utils(ram_config)
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	function new(string name = "config");
		super.new(name);
	endfunction
endclass


class ram_wr_driver extends uvm_driver;
	`uvm_component_utils(ram_wr_driver)
	function new(string name ="ram_wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
	   `uvm_info(get_type_name(), "This is Driver run phase", UVM_MEDIUM)
	endtask
endclass


class ram_wr_monitor extends uvm_monitor;
	`uvm_component_utils(ram_wr_monitor)
	function new(string name ="ram_wr_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
	   `uvm_info(get_type_name(), "This is Monitor run phase", UVM_MEDIUM)
	endtask
endclass


class ram_wr_sequencer extends uvm_sequencer;
	`uvm_component_utils(ram_wr_sequencer)
	function new(string name="ram_wr_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
endclass


class ram_wr_agent extends uvm_agent;
	`uvm_component_utils(ram_wr_agent)

	ram_wr_monitor monh;
	ram_wr_sequencer seqrh;
	ram_wr_driver drvh;
	ram_config tb_cfg;


	function new(string name = "ram_wr_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	  
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(bit)::get(this, "", "bit", is_active))
		begin
			`uvm_fatal("is_active", "cannot get the is_active form bit");
		end
		
		monh = ram_wr_monitor::type_id::create("monh", this);

		if(is_active==1)
		begin
			seqrh = ram_wr_sequencer::type_id::create("seqrh", this); 
			drvh  = ram_wr_driver::type_id::create("drvh", this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(is_active==1)
		begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
		end
	endfunction
endclass

class wr_agt_top extends uvm_env;
	`uvm_component_utils(wr_agt_top)

    	int no_of_agents;

   	wr_agent agnth[];

	function new(string name = "wr_agt_top" , uvm_component parent);
	super.new(name,parent);
	endfunction

	    
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(int)::get(this, "", "int", no_of_agents))
			`uvm_fatal("no_of_agents", "cannot get the no_of_agents form int");

		agnth = new[no_of_agents];

		foreach(agnth[i])
			agnth[i] = ram_wr_agent::type_id::create($sformatf("agnth[%0d]",i), this);

		for(int i=0;i<2;i++)
			uvm_config_db #(bit)::set(this,$sformatf("agnth[%0d]",i),"bit",1);
		uvm_config_db #(bit)::set(this,"agnth[2]","bit",0);
		
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
		agent_top_h = ram_wr_agt_top::type_id::create("agent_top_h", this);
	endfunction
endclass
	
class base_test extends uvm_test;
	`uvm_component_utils(base_test)
   	env envh;
	config tb_cfg;

    	int no_of_agents = 2;

	function new(string name = "base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	    	uvm_config_db #(int)::set(this, "envh.agent_top_h", "int", no_of_agents);
		
	    	super.build_phase(phase);
		envh = ram_env::type_id::create("envh", this);
	endfunction
endclass

module top;
	import uvm_pkg::*; 

	`include "uvm_macros.svh"
 
	initial
	begin
		run_test();
	end
endmodule
