class env extends uvm_env;

        `uvm_component_utils(env)

	apb_agent_top apb_agt_toph;
	aux_agent_top aux_agt_toph;
	io_agent_top io_agt_toph;

	scoreboard sb;
	env_cfg e_cfg;

	extern function new(string name = "env",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
	 extern function void connect_phase(uvm_phase phase);

endclass

function env::new(string name = "env",uvm_component parent);
		super.new(name,parent);
endfunction

function void env::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",e_cfg))
		`uvm_fatal("ENV","config not able get in env")

	if(e_cfg.has_apb_agt_top)
	   apb_agt_toph=apb_agent_top::type_id::create("apb_agt_toph",this);

	if(e_cfg.has_aux_agt_top)
	   aux_agt_toph=aux_agent_top::type_id::create("aux_agt_toph",this);

	if(e_cfg.has_io_agt_top)
	   io_agt_toph=io_agent_top::type_id::create("io_agt_toph",this);

	if(e_cfg.has_scoreboard)
	   sb = scoreboard::type_id::create("sb",this);


endfunction

function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
        //    wr_agt__toph.agnth.monitor.monitor_port.connect(sb.m_fifo.analysis_export);
          //  rd_agt__toph.agnth.monitor.monitor_port.connect(sb.s_fifo.analysis_export);

endfunction

