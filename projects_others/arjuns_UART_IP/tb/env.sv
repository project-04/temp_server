class env extends uvm_env;
	`uvm_component_utils(env)

	apb_agent_top apb_agt_top;
	uart_agent_top uart_agt_top;
	sb sbh;
	virtual_seqr virtual_seqrh;

	env_config env_cfg;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		sbh = sb::type_id::create("sbh",this);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_type_name,"Have you set the config?")

		if(env_cfg.no_of_apb_agents !== 0)
			apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);

		if(env_cfg.no_of_uart_agents !== 0)
			uart_agt_top = uart_agent_top::type_id::create("uart_agt_top",this);

		if(env_cfg.has_virtual_sequencer == 1)
			virtual_seqrh = virtual_seqr::type_id::create("virtual_seqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		if(env_cfg.has_virtual_sequencer == 1)
		   	begin
				foreach(virtual_seqrh.apb_seqrh[i])
					virtual_seqrh.apb_seqrh[i] = apb_agt_top.apb_agt[i].apb_seqrh;

				foreach(virtual_seqrh.uart_seqrh[i])
					virtual_seqrh.uart_seqrh[i] = uart_agt_top.uart_agt[i].uart_seqrh;
		   	end
			
		foreach(apb_agt_top.apb_agt[i])
			apb_agt_top.apb_agt[i].apb_monh.monitor_port.connect(sbh.fifo_apb[i].analysis_export);

		foreach(uart_agt_top.uart_agt[i])
			uart_agt_top.uart_agt[i].uart_monh.monitor_port.connect(sbh.fifo_uart[i].analysis_export);
	endfunction
endclass
