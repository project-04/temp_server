class aux_agent_top extends uvm_env;

	`uvm_component_utils(aux_agent_top)

	env_config env_cfg;
	aux_agent  aux_agt[];

	function new(string name="aux_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_full_name(),"have you set it or not?")

		aux_agt=new[env_cfg.no_of_aux_agt];
		foreach(aux_agt[i])
			begin
			     uvm_config_db#(aux_config)::set(this,$sformatf("aux_agt[%0d]*",i),"aux_config",env_cfg.aux_cfg[i]);
			     aux_agt[i]=aux_agent::type_id::create($sformatf("aux_agt[%0d]",i),this);
			end
	endfunction

endclass

