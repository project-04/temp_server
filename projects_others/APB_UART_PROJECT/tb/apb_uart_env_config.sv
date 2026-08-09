class apb_uart_env_config extends uvm_object;

	`uvm_object_utils(apb_uart_env_config)

	function new (string name = "apb_uart_env_config");
		super.new(name);
	endfunction 

	apb_uart_agt_config apb_uart_agt_cfg[];

	int no_of_agent;
	int has_sb;
	reg_block rg_bl;


endclass
	

