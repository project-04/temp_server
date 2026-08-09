

class ahb_agent_top extends uvm_env;

	`uvm_component_utils(ahb_agent_top)

	function new (string name = "ahb_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction 

	ahb_agent ahb_agt[];

	env_config env_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("AHB_AGENT_TOP","failed to get config");

		
		ahb_agt = new [env_cfg.no_of_ahb_agents];

		foreach(ahb_agt[i])
			begin 
				ahb_agt[i] = ahb_agent::type_id::create($sformatf("ahb_agt[%0d]",i),this);
			end

	endfunction 

endclass
			
