class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	function new(string name="env_config");
		super.new(name);
	endfunction

	apb_config apb_cfg[];
	uart_config uart_cfg[];

	int no_of_agents;
	int no_of_uart_agents;
	int no_of_apb_agents;
	
	bit has_virtual_sequencer;

	uart_reg_block regmodel;

endclass
