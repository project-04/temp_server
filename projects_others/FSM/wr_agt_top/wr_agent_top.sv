

class wr_agent_top extends uvm_env;

	`uvm_component_utils(wr_agent_top)
	
	function new (string name = "wr_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wr_agent wr_agt[];
	env_config en_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",en_cfg))
			`uvm_fatal(get_full_name(),"failed getting config")

		wr_agt = new[en_cfg.no_of_wr_agent];		
		
		foreach(wr_agt[i])		
		wr_agt[i] = wr_agent::type_id::create($sformatf("wr_agt[%0d]",i),this);

	endfunction 


endclass	
