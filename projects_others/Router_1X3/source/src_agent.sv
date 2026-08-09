class src_agent extends uvm_agent;
	`uvm_component_utils(src_agent)

	src_mon src_monh;
	src_drv src_drvh;
	src_seqr m_sequencer;//src_seqrh;

	src_agt_config src_cfg;

	function new(string name = "src_agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction
		
	virtual function void build_phase(uvm_phase phase);
		src_cfg = src_agt_config::type_id::create("src_cfg");

		if(!uvm_config_db #(src_agt_config)::get(this,"","src_agt_config",src_cfg))
			`uvm_fatal("SRC_AGENT","not able to get")
		super.build_phase(phase);
		src_monh = src_mon::type_id::create("src_monh",this);

		if(src_cfg.is_active==UVM_ACTIVE)
			begin 
				src_drvh = src_drv::type_id::create("src_drvh",this);
				//src_seqrh= src_seqr::type_id::create("src_seqrh",this);
				m_sequencer = src_seqr::type_id::create("m_sequencer",this);
			end
	endfunction 
	
	virtual function void connect_phase(uvm_phase phase);
		//src_drvh.seq_item_port.connect(src_seqrh.seq_item_export);
		src_drvh.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
endclass
