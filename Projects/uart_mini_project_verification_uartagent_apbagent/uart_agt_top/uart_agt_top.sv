class uart_agent_top extends uvm_env;
	`uvm_component_utils(uart_agent_top)

	env_config env_cfg;
	uart_agent uart_agt[];

	function new(string name="uart_agent_top", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(! uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		uart_agt = new[env_cfg.no_of_uart_agents];

		foreach(uart_agt[i])begin
			uart_agt[i] = uart_agent::type_id::create($sformatf("uart_agt[%0d]",i),this);

			uvm_config_db #(uart_config)::set(this,$sformatf("uart_agt[%0d]*",i),"uart_config",env_cfg.uart_cfg[i]);
		end

	endfunction

	
		
endclass
