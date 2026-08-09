class apb_uart_agt_config extends uvm_object;

	`uvm_object_utils(apb_uart_agt_config)

	function new (string name = "apb_uart_agt_config");
		super.new(name);
	endfunction 

	uvm_active_passive_enum is_active;
	virtual uart_if vif;
	
endclass
