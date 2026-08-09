class dest_agent extends uvm_agent;
	`uvm_component_utils(dest_agent)

	dest_mon dest_monh;
	dest_drv dest_drvh;
	dest_seqr m_sequencer;//dest_seqrh;

	dest_agt_config dest_cfg;

	function new(string name = "dest_agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction
		
	virtual function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",dest_cfg))
			`uvm_fatal("DEST_AGENT","not able to get")

		dest_monh = dest_mon::type_id::create("dest_monh",this);
		if(dest_cfg.is_active==UVM_ACTIVE)
			begin 
				dest_drvh = dest_drv::type_id::create("dest_drvh",this);
				//dest_seqrh= dest_seqr::type_id::create("dest_seqrh",this);
				m_sequencer= dest_seqr::type_id::create("dest_seqrh",this);
			end
	endfunction 
	
	virtual function void connect_phase(uvm_phase phase);
		//dest_drvh.seq_item_port.connect(dest_seqrh.seq_item_export);
		dest_drvh.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
endclass

