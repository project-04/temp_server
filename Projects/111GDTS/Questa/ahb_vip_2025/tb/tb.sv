class env extends uvm_env;

	`uvm_component_utils(env)

	m_agent m_agt[];
	s_agent s_agt[];
     ahb_rst_agent rst_agt;
	env_config e_cfg;
	scoreboard sbh;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
			`uvm_fatal("ENV","cannot get env config in env")

		if(e_cfg.has_magt)
			m_agt=new[e_cfg.no_magt];
			foreach(m_agt[i])
				begin
					uvm_config_db#(m_agent_config)::set(this,$sformatf("m_agt[%0d]*",i),"m_agent_config",e_cfg.magt_cfg[i]);
					m_agt[i]=m_agent::type_id::create($sformatf("m_agt[%0d]",i),this);
				end 
			
		if(e_cfg.has_sagt)
			s_agt=new[e_cfg.no_sagt];
			foreach(s_agt[i])
				begin
					uvm_config_db#(s_agent_config)::set(this,$sformatf("s_agt[%0d]*",i),"s_agent_config",e_cfg.sagt_cfg[i]);
					s_agt[i]=s_agent::type_id::create($sformatf("s_agt[%0d]",i),this);
				end
               rst_agt=ahb_rst_agent::type_id::create("rst_agt",this);
			uvm_config_db#(ahb_rst_agent_config)::set(this,"*","ahb_rst_agent_config",e_cfg.rst_cfg);
			sbh=scoreboard::type_id::create("sbh",this);
	endfunction

  function void connect_phase(uvm_phase phase);

	foreach(m_agt[i])
	m_agt[i].m_mon.monitor_port.connect(sbh.mst_fifo.analysis_export);

	foreach(s_agt[i])
	s_agt[i].s_mon.monitor_port.connect(sbh.slv_fifo[i].analysis_export);
  endfunction


endclass

