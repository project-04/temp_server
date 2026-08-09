class apb_agent_top extends uvm_env;
	`uvm_component_utils(apb_agent_top)

	env_config env_cfg;
	apb_agent apb_agt[];

	function new(string name="apb_agent_top", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(! uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		apb_agt = new[env_cfg.no_of_apb_agents];

		foreach(apb_agt[i])begin
			apb_agt[i] = apb_agent::type_id::create($sformatf("apb_agt[%0d]",i),this);

			uvm_config_db #(apb_config)::set(this,$sformatf("apb_agt[%0d]*",i),"apb_config",env_cfg.apb_cfg[i]);
		end
	endfunction
endclass

