class env_cfg extends uvm_object;
	`uvm_object_utils(env_cfg)
	
	int no_of_wr_agents;
	int no_of_rd_agents;
	
	function new(string name = "env_cfg");
		super.new(name);
	endfunction
endclass
