class uart_agent extends uvm_agent;
	`uvm_component_utils(uart_agent)

	uart_monitor uart_monh;
	uart_driver uart_drvh;
	uart_seqr uart_seqrh;

	uart_config uart_cfg;

	function new(string name="uart_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		uart_monh = uart_monitor::type_id::create("uart_monh",this);

		if(!uvm_config_db #(uart_config)::get(this,"","uart_config",uart_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		if(uart_cfg.is_active == UVM_ACTIVE)begin
			uart_drvh = uart_driver::type_id::create("uart_drvh",this);
			uart_seqrh = uart_seqr::type_id::create("uart_seqrh",this);
		end
			
	endfunction

	function void connect_phase(uvm_phase phase);
		if(uart_cfg.is_active == UVM_ACTIVE)begin
			uart_drvh.seq_item_port.connect(uart_seqrh.seq_item_export);
		end
	
	endfunction

endclass
