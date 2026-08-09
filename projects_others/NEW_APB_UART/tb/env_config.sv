

class env_config extends uvm_object;

	`uvm_object_utils(env_config)

	function new(string name = "env_config");
		super.new(name);
	endfunction 

	int no_of_apb_agents;
	int no_of_uart_agents;

	apb_config apb_cfg[];
	uart_config uart_cfg[];

endclass	
