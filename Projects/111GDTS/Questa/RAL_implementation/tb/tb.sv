class env extends uvm_env;

	`uvm_component_utils(env)

	m_agent m_agt[];
	s_agent s_agt[];
	env_config e_cfg;
	scoreboard sbh;
     adapter adpt;

   uvm_reg_predictor #(trans) predictor;

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
					uvm_config_db#(s_agent_config)::set(this,"*","s_agent_config",e_cfg.sagt_cfg[i]);
					s_agt[i]=s_agent::type_id::create($sformatf("s_agt[%0d]",i),this);
				end
			sbh=scoreboard::type_id::create("sbh",this);

       predictor = uvm_reg_predictor#(trans) :: type_id :: create("predictor", this);
      adpt = adapter :: type_id :: create("adpt");

	endfunction

  function void connect_phase(uvm_phase phase);

	foreach(m_agt[i])
	m_agt[i].m_mon.monitor_port.connect(sbh.mst_fifo.analysis_export);

	foreach(s_agt[i])
	s_agt[i].s_mon.monitor_port.connect(sbh.slv_fifo.analysis_export);


     begin
       e_cfg.regh.map1.set_sequencer(m_agt[0].m_seqr,adpt);
     end

   predictor.map = e_cfg.regh.map1;
   predictor.adapter= adpt;
   e_cfg.regh.map1.set_auto_predict(1);
   m_agt[0].m_mon.monitor_port.connect(predictor.bus_in);

  endfunction


endclass

