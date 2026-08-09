

class test extends uvm_test;

	`uvm_component_utils(test)
	
	function new (string name = "test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	
	environment env;
	wr_sequence wr_seq;
	
	env_config en_cfg;
	wr_agent_config w_cfg[];
	rd_agent_config r_cfg[];
	
	int no_of_wr_agent = 1;
	int no_of_rd_agent = 1;
	


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		en_cfg = env_config::type_id::create("en_cfg");
		
		w_cfg = new[no_of_wr_agent];
		r_cfg = new[no_of_rd_agent];

		en_cfg.w_cfg = new[no_of_wr_agent];
		en_cfg.r_cfg = new[no_of_rd_agent];

		en_cfg.no_of_wr_agent = this.no_of_wr_agent;
		en_cfg.no_of_rd_agent = this.no_of_rd_agent;
			
		foreach(w_cfg[i])
			begin 
				
				w_cfg[i] = wr_agent_config::type_id::create($sformatf("w_cfg[%0d]",i),this);
				
				if(!uvm_config_db#(virtual fsm_if)::get(this,"","fsm_if",w_cfg[i].v_if))	
					`uvm_fatal(get_type_name(),"failed to get virtual interface")

				w_cfg[i].is_active = UVM_ACTIVE;
					
				uvm_config_db#(wr_agent_config)::set(this,$sformatf("*wr_agt[%0d]*",i),"wr_agent_config",w_cfg[i]);
				
				en_cfg.w_cfg[i] = w_cfg[i];		

			end		
			
		foreach(r_cfg[i])
			begin 
				
				r_cfg[i] = rd_agent_config::type_id::create($sformatf("r_cfg[%0d]",i),this);
				
				if(!uvm_config_db#(virtual fsm_if)::get(this,"","fsm_if",r_cfg[i].v_if))	
					`uvm_fatal(get_type_name(),"failed to get virtual interface")

				r_cfg[i].is_active = UVM_ACTIVE;
					
				uvm_config_db#(rd_agent_config)::set(this,$sformatf("*rd_agt[%0d]*",i),"rd_agent_config",r_cfg[i]);
				
				en_cfg.r_cfg[i] = r_cfg[i];		

			end	
			
		env = environment::type_id::create("env",this);
		
		uvm_config_db#(env_config)::set(this,"*","env_config",en_cfg);		
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
	endfunction 

	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		
		uvm_top.print_topology();

	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		wr_seq = wr_sequence::type_id::create("wr_seq");
	
		phase.raise_objection(this);

		foreach(w_cfg[i])
			if(w_cfg[i].is_active == UVM_ACTIVE)
				wr_seq.start(env.wr_agt_top.wr_agt[i].wr_seqr);

		phase.drop_objection(this);
	
	endtask


endclass	
