class env_config extends uvm_object;

	`uvm_object_utils(env_config)

	bit has_sb=1;
	bit has_magt=1;
	bit has_sagt=1;
	int no_magt=1;
	int no_sagt=3;
	m_agent_config magt_cfg[];
	s_agent_config sagt_cfg[];
     bit[31:0]haddr;
     ahb_rst_agent_config rst_cfg;

	function new(string name="env_config");
		super.new(name);
	endfunction

endclass

