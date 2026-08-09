class env extends uvm_env;

        `uvm_component_utils(env)

	apb_agent_top apb_agt_toph;
	aux_agent_top aux_agt_toph;
	io_agent_top io_agt_toph;

	scoreboard sb;
	env_cfg e_cfg;
	v_sequencer vseqrh;
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
	vseqrh = v_sequencer::type_id::create("v_seqrh",this);

endfunction

function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
           apb_agt_toph.agnth.monitor.monitor_port.connect(sb.apb_fifo.analysis_export);
           aux_agt_toph.agnth.monitor.monitor_port.connect(sb.aux_fifo.analysis_export);
           io_agt_toph.agnth.monitor.monitor_port.connect(sb.io_fifo.analysis_export);

	vseqrh.apb_seqrh = apb_agt_toph.agnth.seqr;
	vseqrh.aux_seqrh = aux_agt_toph.agnth.seqr;
	vseqrh.io_seqrh = io_agt_toph.agnth.seqr;

endfunction

