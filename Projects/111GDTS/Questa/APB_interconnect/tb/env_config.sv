class env_config extends uvm_object;

	`uvm_object_utils(env_config)
         uvm_active_passive_enum is_active = UVM_ACTIVE;	
	master_config mcfg[];
	slave_config scfg[];

	bit has_master_agent = 1;
	bit has_slave_agent = 1;
	bit has_virtual_sequencer = 1;
	bit has_scoreboard = 1;

	int no_of_master_agent = 1;
	int no_of_slave_agent = 4;
	
	extern function new(string name = "env_config");		
endclass

	function env_config::new(string name = "env_config");
		super.new(name);
	endfunction



