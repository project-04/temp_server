module top;

	import uvm_pkg::*; 

	`include "uvm_macros.svh"
 
  	class config_cls extends uvm_object;
   		`uvm_object_utils(config_cls)
    		int no_of_agents = 2;
    		uvm_active_passive_enum is_active = UVM_ACTIVE;
  	endclass

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
	endclass

	class wr_monitor extends uvm_monitor;
		`uvm_component_utils(wr_monitor)
		function new(string name ="wr_monitor",uvm_component parent);
			super.new(name,parent);
		endfunction
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
		config_cls cfg_agent;
		//bit is_active;
		function new(string name = "wr_agent", uvm_component parent);
			super.new(name, parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(config_cls)::get(this, "", "config_cls", cfg_agent))
			begin
				`uvm_fatal("is_active", "cannot get the cfg_agent form config_cls");
			end
			monh = wr_monitor::type_id::create("monh", this);
			if(cfg_agent.is_active == UVM_ACTIVE)
			begin
				seqrh = wr_sequencer::type_id::create("seqrh", this); 
				drvh  = wr_driver::type_id::create("drvh", this);
			end
		endfunction
	endclass

	class wr_agt_top extends uvm_env;
		`uvm_component_utils(wr_agt_top)
    		wr_agent agenth[];
		config_cls cfg_env;
		config_cls cfg_wr_agenth[];
		function new(string name = "wr_agt_top" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(config_cls)::get(this, "", "config_cls", cfg_env))
				`uvm_fatal("cfg_env", "cannot get the cfg_env form config_cfgf");
      			agenth=new[cfg_env.no_of_agents];
            		cfg_wr_agenth = new[cfg_env.no_of_agents];
			foreach(agenth[i])
			begin
				agenth[i] = wr_agent::type_id::create($sformatf("agenth[%0d]",i), this);
				cfg_wr_agenth[i] = config_cls::type_id::create($sformatf("cfg_wr_agenth[%d]",i), this);
			end
      			foreach(agenth[i])
            		begin
        			if(i==0 || i==1)
        				begin
        					cfg_wr_agenth[i].is_active = UVM_ACTIVE;
        			    		uvm_config_db #(config_cls)::set(this,$sformatf("agenth[%0d]",i),"config_cls",cfg_wr_agenth[i]);
        				end
                			else
        				begin
        					cfg_wr_agenth[i].is_active = UVM_PASSIVE;
                  				uvm_config_db #(config_cls)::set(this,$sformatf("agenth[%0d]",i),"config_cls",cfg_wr_agenth[i]);
        				end
            		end
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
    		config_cls cfg_env;
    		int no_of_agents = 3;
		function new(string name = "base_test" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
 	    		super.build_phase(phase);
      			envh = env::type_id::create("envh", this);
      			cfg_env = config_cls::type_id::create("cfg_env", this);
      			cfg_env.no_of_agents = no_of_agents;
      			uvm_config_db #(config_cls)::set(this,"envh.agent_top_h","config_cls",cfg_env);
		endfunction
	endclass
	
	initial
	begin
		run_test("base_test");
	end
endmodule
