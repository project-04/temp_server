class env extends uvm_env;
	`uvm_component_utils(env)
	
	env_cfg env_cfg_h;
	write_agent wr_agent[];
	read_agent rd_agent[];
	
	sb sb_h;
	
	function new(string name = "env", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", env_cfg_h))
			`uvm_fatal("env", "can't get env_cfg")
			
		wr_agent = new[env_cfg_h.no_of_wr_agents];
		foreach(wr_agent[i])
		begin
			wr_agent[i] = write_agent::type_id::create($sformatf("wr_agent[%0d]", i), this);
		end
		
		rd_agent = new[env_cfg_h.no_of_rd_agents];
		foreach(rd_agent[i])
		begin
			rd_agent[i] = read_agent::type_id::create($sformatf("rd_agent[%0d]", i), this);
		end
		
		sb_h = sb::type_id::create("sb_h", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		foreach(wr_agent[i])
		begin
			wr_agent[i].mon.mon_port.connect(sb_h.wr_fifo.analysis_export);
		end
		
		foreach(rd_agent[i])
		begin
			rd_agent[i].mon.mon_port.connect(sb_h.rd_fifo.analysis_export);
		end
	endfunction
endclass
