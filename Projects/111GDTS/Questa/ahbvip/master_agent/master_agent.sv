class m_agent extends uvm_agent;

	`uvm_component_utils(m_agent)

	ma_sequencer m_seqr;
	m_driver m_drv;
	m_monitor m_mon;
	m_agent_config m_cfg;

	function new(string name="m_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(m_agent_config)::get(this,"","m_agent_config",m_cfg))
			`uvm_fatal("M_AGENT","Cannot get m_cfg in m_agent")
		m_mon=m_monitor::type_id::create("m_mon",this);

		if(UVM_ACTIVE==is_active)
			begin
				m_seqr=ma_sequencer::type_id::create("m_seqr",this);
				m_drv=m_driver::type_id::create("m_drv",this);
			end

	//	uvm_config_db#(
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_drv.seq_item_port.connect(m_seqr.seq_item_export);
	endfunction

endclass

