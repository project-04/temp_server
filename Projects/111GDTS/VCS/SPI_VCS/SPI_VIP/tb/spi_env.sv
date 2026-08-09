 

  class spi_env extends uvm_env;

//FACTORY
	`uvm_component_utils(spi_env)

//CONFIG HANDEL
	spi_env_config m_cfg;

//MEMBERS
	master_agent m_agnt;
	slave_agent  s_agnt;
	spi_vseqr    vseqr;
	spi_scoreboard sb;
//METHODS
	extern function new(string name = "spi_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

endclass
//CONSTRUCTOR
	function spi_env::new(string name = "spi_env",uvm_component parent);
		super.new(name,parent);
	endfunction
//BUILD PHASE
	function void spi_env::build_phase(uvm_phase phase);
		if(!uvm_config_db#(spi_env_config)::get(this,"","spi_env_config",m_cfg))
			`uvm_fatal("SPI_ENV","UNABLE TO GET CONFIG")
			
		if(m_cfg.has_master_agent)
			begin
				m_agnt=master_agent::type_id::create("m_agnt",this);
				uvm_config_db #(master_agent_config)::set(this,"m_agnt*","master_agent_config",m_cfg.master_cfg);
			end
		if(m_cfg.has_slave_agent)
			begin
				s_agnt=slave_agent::type_id::create("s_agnt",this);
				uvm_config_db #(slave_agent_config)::set(this,"s_agnt*","slave_agent_config",m_cfg.slave_cfg);
			end
		if(m_cfg.has_virtual_seq)
			vseqr=spi_vseqr::type_id::create("vseqr",this);

		if(m_cfg.has_scoreboard)
			sb=spi_scoreboard::type_id::create("sb",this);

			
	endfunction
//CONNECT PHASE
	function void spi_env::connect_phase(uvm_phase phase);
		
		if(m_cfg.has_virtual_seq)
			begin
				vseqr.m_seqr=m_agnt.seqh;
				vseqr.s_seqr=s_agnt.seqh;
			end
		if(m_cfg.has_scoreboard)
		begin
			if(m_cfg.has_master_agent)
				m_agnt.monh.monitor_port.connect(sb.master_fifo.analysis_export);
			if(m_cfg.has_slave_agent)
				s_agnt.monh.monitor_port.connect(sb.slave_fifo.analysis_export);
		end

	endfunction
