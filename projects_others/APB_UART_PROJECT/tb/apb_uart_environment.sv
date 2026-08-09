class apb_uart_environment extends uvm_env;
	

	`uvm_component_utils(apb_uart_environment)

	function new (string name = "apb_uart_environment",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_scoreboard apb_uart_sb;
	apb_uart_agent_top apb_uart_agt_top;

	apb_uart_env_config  apb_uart_env_cfg;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(apb_uart_env_config)::get(this,"","apb_uart_env_config",apb_uart_env_cfg))
			`uvm_fatal("apb_uart_agent_top","failed to get config");
	

				apb_uart_agt_top = apb_uart_agent_top::type_id::create("apb_uart_agt_top",this); 

		if(apb_uart_env_cfg.has_sb == 1)
			begin 
				apb_uart_sb =  apb_uart_scoreboard::type_id::create("apb_uart_sb",this);
			end

		`uvm_info("apb_uart_environment","build phase is done",UVM_HIGH);
	endfunction 


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);


		apb_uart_agt_top.apb_uart_agt[0].apb_uart_mon.mon2sb.connect(apb_uart_sb.fifo0.analysis_export);
		apb_uart_agt_top.apb_uart_agt[1].apb_uart_mon.mon2sb.connect(apb_uart_sb.fifo1.analysis_export);





		`uvm_info("apb_uart_environment","connect phase is over",UVM_HIGH);
	endfunction 

endclass
		
		

