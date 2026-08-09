

class environment extends uvm_env;

	`uvm_component_utils(environment)

	function new (string name = "environment",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//for scoreboard
	apb_agent_top apb_agt_top;
	spi_agent_top spi_agt_top;

	//env_config env_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	//	if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
	//		`uvm_fatal("ENVIRONMENT","failed to get config");

		
		apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);
		
		spi_agt_top = spi_agent_top::type_id::create("spi_agt_top",this);

		
	endfunction 


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

	endfunction 

endclass

