class env extends uvm_env;
	`uvm_component_utils(env)

	master_agent_top master_agt_top;
	slave_agent_top slave_agt_top;
	sb sb_h;

	env_config env_cfg;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		sb_h = sb::type_id::create("sb_h",this);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_type_name,"Have you set the config?")
		$display("-------------------------------",env_cfg);
		if(env_cfg.no_of_master_agents !== 0)
			master_agt_top = master_agent_top::type_id::create("master_agt_top",this);

		if(env_cfg.no_of_slave_agents !== 0)
			slave_agt_top = slave_agent_top::type_id::create("slave_agt_top",this);

	endfunction

	function void connect_phase(uvm_phase phase);			
		foreach(master_agt_top.master_agt[i])
		begin
	master_agt_top.master_agt[i].master_monh.mst_monitor_port_w.connect(sb_h.mst_fifo_w[i].analysis_export);
	master_agt_top.master_agt[i].master_monh.mst_monitor_port_r.connect(sb_h.mst_fifo_r[i].analysis_export);
		end
		foreach(slave_agt_top.slave_agt[i])
		begin
	slave_agt_top.slave_agt[i].slave_monh.slv_monitor_port_w.connect(sb_h.slv_fifo_w[i].analysis_export);
	slave_agt_top.slave_agt[i].slave_monh.slv_monitor_port_r.connect(sb_h.slv_fifo_r[i].analysis_export);
		end	
	endfunction
	
endclass

