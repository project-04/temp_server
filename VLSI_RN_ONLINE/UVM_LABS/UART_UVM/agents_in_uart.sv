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

	class driver extends uvm_driver #(packet); //packet is no need
		`uvm_component_utils(driver)
		function new(string name ="driver",uvm_component parent);
			super.new(name,parent);
		endfunction
	endclass

	class monitor extends uvm_monitor;
		`uvm_component_utils(monitor)
		function new(string name ="monitor",uvm_component parent);
			super.new(name,parent);
		endfunction
	endclass

	class sequencer extends uvm_sequencer #(packet); //packet is no need
		`uvm_component_utils(sequencer)
		function new(string name="sequencer",uvm_component parent);
			super.new(name,parent);
		endfunction
	endclass

	class agent extends uvm_agent;
		`uvm_component_utils(agent)
		monitor monh;
		sequencer seqrh;
		driver drvh;
		config_cls cfg_agent;
		function new(string name = "agent", uvm_component parent);
			super.new(name, parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(config_cls)::get(this, "", "config_cls", cfg_agent))
			begin
				`uvm_fatal("is_active", "cannot get the cfg_agent form config_cls");
			end
			monh = monitor::type_id::create("monh", this);
			if(cfg_agent.is_active == UVM_ACTIVE)
			begin
				seqrh = sequencer::type_id::create("seqrh", this); 
				drvh  = driver::type_id::create("drvh", this);
			end
		endfunction
	endclass

	class wr_agt_top extends uvm_env;
		`uvm_component_utils(wr_agt_top)
		agent wr_agenth[];
		config_cls cfg_env;
		config_cls cfg_wr_agenth[];
		function new(string name = "wr_agt_top" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(config_cls)::get(this, "", "config_cls", cfg_env))
				`uvm_fatal("cfg_env", "cannot get the cfg_env form config_cfgf");
      			wr_agenth = new[cfg_env.no_of_agents];
            		cfg_wr_agenth = new[cfg_env.no_of_agents];
			foreach(wr_agenth[i])
			begin
				wr_agenth[i] = agent::type_id::create($sformatf("wr_agenth[%0d]",i), this);
				cfg_wr_agenth[i] = config_cls::type_id::create($sformatf("cfg_wr_agenth[%d]",i), this);
			end
      			foreach(wr_agenth[i])
            begin
        			if(i==0)
        				begin
        					cfg_wr_agenth[i].is_active = UVM_ACTIVE;
        			    		uvm_config_db #(config_cls)::set(this,$sformatf("wr_agenth[%0d]",i),"config_cls",cfg_wr_agenth[i]);
        				end
                			else
        				begin
        					cfg_wr_agenth[i].is_active = UVM_PASSIVE;
                  				uvm_config_db #(config_cls)::set(this,$sformatf("wr_agenth[%0d]",i),"config_cls",cfg_wr_agenth[i]);
        				end
            end
		endfunction
	endclass
 
 class rd_agt_top extends uvm_env;
		`uvm_component_utils(rd_agt_top)
		agent rd_agenth[];
		config_cls cfg_env;
		config_cls cfg_rd_agenth[];
		function new(string name = "rd_agt_top" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db #(config_cls)::get(this, "", "config_cls", cfg_env))
				`uvm_fatal("cfg_env", "cannot get the cfg_env form config_cfgf");
      			rd_agenth = new[cfg_env.no_of_agents];
            cfg_rd_agenth = new[cfg_env.no_of_agents];
			foreach(rd_agenth[i])
			begin
				rd_agenth[i] = agent::type_id::create($sformatf("rd_agenth[%0d]",i), this);
				cfg_rd_agenth[i] = config_cls::type_id::create($sformatf("cfg_rd_agenth[%d]",i), this);
			end
      			foreach(rd_agenth[i])
            begin
        			if(i==0)
        				begin
        					cfg_rd_agenth[i].is_active = UVM_ACTIVE;
        			    		uvm_config_db #(config_cls)::set(this,$sformatf("rd_agenth[%0d]",i),"config_cls",cfg_rd_agenth[i]);
        				end
                			else
        				begin
        					cfg_rd_agenth[i].is_active = UVM_PASSIVE;
                  				uvm_config_db #(config_cls)::set(this,$sformatf("rd_agenth[%0d]",i),"config_cls",cfg_rd_agenth[i]);
        				end
            end
		endfunction
	endclass

	class env extends uvm_env;
		`uvm_component_utils(env)
	 	wr_agt_top wr_agent_top_h;
    rd_agt_top rd_agent_top_h;
		function new(string name="env",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);	
			super.build_phase(phase);
			wr_agent_top_h = wr_agt_top::type_id::create("wr_agent_top_h", this);
      rd_agent_top_h = rd_agt_top::type_id::create("rd_agent_top_h", this);
		endfunction
	endclass
		
	class base_test extends uvm_test;
		`uvm_component_utils(base_test)
    		env envh;
    		config_cls cfg_env;
    		int no_of_agents = 2;
		function new(string name = "base_test" , uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
 	    		super.build_phase(phase);
      			envh = env::type_id::create("envh", this);
      			cfg_env = config_cls::type_id::create("cfg_env", this);
      			cfg_env.no_of_agents = no_of_agents;
      			uvm_config_db #(config_cls)::set(this,"envh.wr_agent_top_h","config_cls",cfg_env);
            uvm_config_db #(config_cls)::set(this,"envh.rd_agent_top_h","config_cls",cfg_env);
		endfunction
    task run_phase(uvm_phase phase);
		uvm_top.print_topology;
	endtask   
	endclass
	
	initial
	begin
		run_test("base_test");
	end
endmodule
