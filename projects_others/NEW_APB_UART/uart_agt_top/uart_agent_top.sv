

class uart_agent_top extends uvm_env;

	`uvm_component_utils(uart_agent_top)

	function new (string name = "uart_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction 


	uart_agent uart_agt[];
	env_config en_cfg;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(env_config)::get(this,"","env_config",en_cfg))
			`uvm_fatal(get_type_name(),"FAILED TO GET ENV CONFIG")

		uart_agt = new[en_cfg.no_of_uart_agents];
			
		foreach(uart_agt[i])
			begin 
				uart_agt[i] = uart_agent::type_id::create($sformatf("uart_agt[%0d]",i),this);
			end 	
	
	endfunction 

endclass	
