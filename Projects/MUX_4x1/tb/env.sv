class sb extends uvm_scoreboard;
		`uvm_component_utils(sb)
		uvm_tlm_analysis_fifo #(trans) fifo0;
		uvm_tlm_analysis_fifo #(trans) fifo1;
		
		trans data0, data1, cov_data_h;
		
		covergroup covergroup_name;
			c0 : coverpoint cov_data_h.i0;
			c1 : coverpoint cov_data_h.i1;
			c2 : coverpoint cov_data_h.i2;
			c3 : coverpoint cov_data_h.i3;
			
			c4 : coverpoint cov_data_h.s0;
			c5 : coverpoint cov_data_h.s1;
			
			c6 : coverpoint cov_data_h.d_out;
		endgroup
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
			fifo0 = new("fifo0", this);
			fifo1 = new("fifo1", this);
			covergroup_name = new();
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			forever
			begin
				fifo0.get(data0);
				fifo1.get(data1);
				
				cov_data_h = data1;
				
				//cov_data_h.print();
				
				covergroup_name.sample();
			end
		endtask
		
		function void report_phase(uvm_phase phase);
			super.report_phase(phase);
			
			$display("\n\n\ncovergroup_name = %f\n\n\n", covergroup_name.get_coverage());
		endfunction
	endclass
	
	class agent_top extends uvm_env;
		`uvm_component_utils(agent_top)
		env_cfg env_cfgh;
		agent agenth[];
				
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", env_cfgh))
   	 			`uvm_fatal("agent_top", "Failed to get env_cfg from config_db")
			
			agenth = new[env_cfgh.no_of_agents];
			foreach(agenth[i])
				agenth[i] = agent::type_id::create($sformatf("agenth[%0d]", i), this);
		endfunction
	endclass
	
	class env extends uvm_env;
		`uvm_component_utils(env)
		env_cfg env_cfgh;
		agent_top agent_toph;
		sb sbh;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", env_cfgh))
   	 			`uvm_fatal("agent_top", "Failed to get env_cfg from config_db")
   	 			
			agent_toph = agent_top::type_id::create("agent_toph", this);
			sbh = sb::type_id::create("sbh", this);
		endfunction
		
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			
			for(int i=0; i<env_cfgh.no_of_agents; i++)
			begin
				if(i == 0)
					agent_toph.agenth[i].monh.mon_port.connect(sbh.fifo0.analysis_export);
				else
					agent_toph.agenth[i].monh.mon_port.connect(sbh.fifo1.analysis_export);
			end
			
		endfunction
	endclass
