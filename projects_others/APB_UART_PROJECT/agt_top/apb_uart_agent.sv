class apb_uart_agent extends uvm_agent;

	`uvm_component_utils(apb_uart_agent)
	
	function new (string name = "apb_uart_agent",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_agt_config apb_uart_agt_cfg;

	apb_uart_driver apb_uart_drv;
	apb_uart_monitor apb_uart_mon;
	apb_uart_sequencer apb_uart_seqr;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db#(apb_uart_agt_config)::get(this,"","apb_uart_agt_config",apb_uart_agt_cfg))
			`uvm_fatal("apb_uart_agent","failed to get config");

				apb_uart_mon = apb_uart_monitor::type_id::create("apb_uart_mon",this);

		if(apb_uart_agt_cfg.is_active == UVM_ACTIVE)
			begin 
				apb_uart_drv = apb_uart_driver::type_id::create("apb_uart_drv",this);
				apb_uart_seqr = apb_uart_sequencer::type_id::create("apb_uart_seqr",this);
			end



		`uvm_info("apb_uart_agent","build phase is over",UVM_HIGH);
	endfunction 
	

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(apb_uart_agt_cfg.is_active == UVM_ACTIVE)
			begin 
				apb_uart_drv.seq_item_port.connect(apb_uart_seqr.seq_item_export);
			end



		`uvm_info("apb_uart_monitor","connect phase is over",UVM_HIGH);
	endfunction 


endclass
	
