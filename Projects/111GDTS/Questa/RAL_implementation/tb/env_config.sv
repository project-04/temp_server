class env_config extends uvm_object;

	`uvm_object_utils(env_config)

	bit has_sb=1;
	bit has_magt=1;
	bit has_sagt=1;
	int no_magt=1;
	int no_sagt=1;
	m_agent_config magt_cfg[];
	s_agent_config sagt_cfg[];
     reg_block regh;

	function new(string name="env_config");
		super.new(name);
	endfunction

endclass

