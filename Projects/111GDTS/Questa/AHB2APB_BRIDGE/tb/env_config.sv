class env_config extends uvm_object;

	`uvm_object_utils(env_config)
         uvm_active_passive_enum is_active = UVM_ACTIVE;	
	ahb_agent_config wcfg[];
	apb_agent_config apb_cfg[];

	bit has_ahb_agent = 1;
	bit has_apb_agent = 1;
	bit has_virtual_sequencer = 1;
	bit has_scoreboard = 1;
	bit has_functional_coverage = 1;

	int no_of_ahb_agent = 1;
	int no_of_apb_agent = 1;
	
	extern function new(string name = "env_config");		
endclass

	function env_config::new(string name = "env_config");
		super.new(name);
	endfunction


