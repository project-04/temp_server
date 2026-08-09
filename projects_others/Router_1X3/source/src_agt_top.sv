class src_agt_top extends uvm_env;
	`uvm_component_utils(src_agt_top);
	env_config env_cfg;
	src_agent src_agth[];

	function new(string name = "src_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_cfg",env_cfg))
			`uvm_fatal("SRC_AGT_TOP","not able to get")
		
		src_agth = new[env_cfg.no_of_src_agt];
		super.build_phase(phase);

		foreach(src_agth[i])
			begin 
				uvm_config_db #(src_agt_config)::set(this,$sformatf("src_agth[%0d]*",i),"src_agt_config",env_cfg.src_cfg[i]);
				src_agth[i] = src_agent::type_id::create($sformatf("src_agth[%0d]",i),this);
			end
		
	endfunction
endclass
	

