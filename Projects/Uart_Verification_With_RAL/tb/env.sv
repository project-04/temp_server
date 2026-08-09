class env extends uvm_env;
	`uvm_component_utils(env)

	apb_agent_top apb_agt_top;
	uart_agent_top uart_agt_top;
	scoreboard sbh;
	virtual_seqr virtual_seqrh;

	env_config env_cfg;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		sbh = scoreboard::type_id::create("sbh",this);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_type_name,"Have you set the config?")

		if(env_cfg.no_of_apb_agents != 0)
			apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);

		if(env_cfg.no_of_uart_agents != 0)
			uart_agt_top = uart_agent_top::type_id::create("uart_agt_top",this);

		virtual_seqrh = virtual_seqr::type_id::create("virtual_seqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);			
		foreach(apb_agt_top.apb_agt[i])
		begin
			apb_agt_top.apb_agt[i].apb_monh.monitor_port.connect(sbh.fifo_apb.analysis_export);
			
			virtual_seqrh.apb_seqrh[i] = apb_agt_top.apb_agt[i].apb_seqrh;
		end
		
		foreach(uart_agt_top.uart_agt[i])
		begin
			uart_agt_top.uart_agt[i].uart_monh.monitor_port.connect(sbh.fifo_uart.analysis_export);
			
			virtual_seqrh.uart_seqrh[i] = uart_agt_top.uart_agt[i].uart_seqrh;
		end
	endfunction
endclass
