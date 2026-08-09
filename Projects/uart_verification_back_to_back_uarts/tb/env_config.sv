class env_config extends uvm_object;
   	`uvm_object_utils(env_config)
	
	int no_of_agents;
	
	bit has_virtual_sequencer = 1;
	bit has_functional_coverage = 1;
    	bit has_scoreboard = 1;

endclass
