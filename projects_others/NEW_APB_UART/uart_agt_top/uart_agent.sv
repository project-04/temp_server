

class uart_agent extends uvm_agent;

	`uvm_component_utils(uart_agent)

	function new (string name = "uart_agent",uvm_component parent);
		super.new(name,parent);
	endfunction 

	uart_monitor u_mon;
	uart_driver u_drv;
	uart_sequencer u_seqr;

	uart_config u_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(uart_config)::get(this,"","uart_config",u_cfg))
			`uvm_fatal(get_type_name(),"FAILED GETTING UART CONFIG")

		u_mon = uart_monitor::type_id::create("u_mon",this);

		if(u_cfg.is_active == UVM_ACTIVE)
			begin 
				u_drv = uart_driver::type_id::create("u_drv",this);
				u_seqr = uart_sequencer::type_id::create("u_seqr",this);
			end	
			
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);


	endtask

endclass
