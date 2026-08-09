


class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	function new(string name = "env_config");
		super.new(name);
	endfunction 
	
	int no_of_wr_agent;
	int no_of_rd_agent;
	
	wr_agent_config w_cfg[];
	rd_agent_config r_cfg[];



endclass		