class test extends uvm_test;
		`uvm_component_utils(test)
		env envh;
		env_cfg env_cfgh;
		agent_cfg agent_cfgh[];
		virtual mux_if vif;
		seq seqh;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			envh = env::type_id::create("envh", this);
			
			env_cfgh = env_cfg::type_id::create("env_cfgh");
			env_cfgh.no_of_agents = 2;
			uvm_config_db #(env_cfg)::set(this, "*", "env_cfg", env_cfgh);
			
			uvm_config_db #(virtual mux_if)::get(this, "", "mux_if", vif);
			
			agent_cfgh = new[env_cfgh.no_of_agents];
			foreach(agent_cfgh[i])
			begin
				agent_cfgh[i] = agent_cfg::type_id::create($sformatf("agent_cfgh[%0d]", i));
				agent_cfgh[i].vif = vif;
				if(i==0) 
					agent_cfgh[i].is_active = UVM_ACTIVE;
				else
					agent_cfgh[i].is_active = UVM_PASSIVE;
				uvm_config_db #(agent_cfg)::set(this, $sformatf("envh.agent_toph.agenth[%0d]*", i), "agent_cfg", agent_cfgh[i]);
			end
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			
			uvm_top.print_topology();
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			seqh = seq::type_id::create("seqh");
			
			phase.raise_objection(this);
			seqh.start(envh.agent_toph.agenth[0].seqsh);
			phase.drop_objection(this);
		endtask
	endclass
