class axi_env_config extends uvm_object;
	`uvm_object_utils(axi_env_config)

	// Properties
	bit has_functional_coverage = 0;
	bit has_virtual_sequencer = 1;
	bit has_scoreboard =1;

	bit has_mast_agt;
	bit has_slv_agt;
	
	int no_of_mast_agt;
	int no_of_slv_agt;

	axi_mast_agt_cfg mast_cfg[];
	axi_slv_agt_cfg slv_cfg[];

	// Methods
	extern function new(string name ="axi_env_config");
endclass

function axi_env_config :: new(string name="axi_env_config");
	super.new(name);
endfunction
