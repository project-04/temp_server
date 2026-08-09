

class environment extends uvm_env;

	`uvm_component_utils(environment)
	
	function new (string name = "environment",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wr_agent_top wr_agt_top;
	rd_agent_top rd_agt_top;
	env_config en_cfg;
	scoreboard s_b;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db#(env_config)::get(this,"","env_config",en_cfg))
			`uvm_fatal(get_type_name(),"failed to get")

		wr_agt_top = wr_agent_top::type_id::create("wr_agt_top",this);
		rd_agt_top = rd_agent_top::type_id::create("rd_agt_top",this);
	
		s_b = scoreboard::type_id::create("s_b",this);
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		foreach(en_cfg.w_cfg[i])
		wr_agt_top.wr_agt[i].wr_mon.wr_p.connect(s_b.sc_wp.analysis_export);
		
		foreach(en_cfg.r_cfg[i])
		rd_agt_top.rd_agt[i].rd_mon.rd_p.connect(s_b.sc_rp.analysis_export);		
		
	endfunction 


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
	endtask

endclass	
