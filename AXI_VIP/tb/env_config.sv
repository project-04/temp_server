class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	master_config	master_cfg[];
	slave_config	slave_cfg[];
	
	int no_of_transations;
	int no_of_master_agents;
	int no_of_slave_agents;

	function new(string name="env_config");
		super.new(name);
	endfunction
endclass
