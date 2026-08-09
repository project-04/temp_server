class apb_uart_agent_top extends uvm_env;

	`uvm_component_utils(apb_uart_agent_top)

	function new (string name = "apb_uart_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_agent apb_uart_agt[];

	apb_uart_env_config  apb_uart_env_cfg;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(apb_uart_env_config)::get(this,"","apb_uart_env_config",apb_uart_env_cfg))
			`uvm_fatal("apb_uart_agent_top","failed to get config");

		apb_uart_agt = new [apb_uart_env_cfg.no_of_agent];

		foreach(apb_uart_agt[i])
			begin 
				apb_uart_agt[i] = apb_uart_agent::type_id::create($sformatf("apb_uart_agt[%0d]",i),this);
			end	
	
		`uvm_info("apb_uart_agent_top","build phase is done",UVM_HIGH);
	endfunction 

endclass		
