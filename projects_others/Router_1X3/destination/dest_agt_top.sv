class dest_agt_top extends uvm_env;
	`uvm_component_utils(dest_agt_top);
	
	env_config env_cfg;
	dest_agent dest_agth[];

	function new(string name = "dest_agt_top",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_cfg",env_cfg))
			`uvm_fatal("DEST_AGT_TOP","not able to get")
		
		dest_agth = new[env_cfg.no_of_dest_agt];
		
		foreach(dest_agth[i])
			begin 
				uvm_config_db #(dest_agt_config)::set(this,$sformatf("dest_agth[%0d]*",i),"dest_agt_config",env_cfg.dest_cfg[i]);
				dest_agth[i] = dest_agent::type_id::create($sformatf("dest_agth[%0d]",i),this);
			end
	endfunction
endclass
	

