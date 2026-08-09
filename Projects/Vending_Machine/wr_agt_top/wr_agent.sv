class write_agent extends uvm_agent;
	`uvm_component_utils(write_agent)
	
	wr_agt_cfg wr_agt_cfg_h;
	wr_seqr seqr;
	wr_drv drv;
	wr_mon mon;
	
	function new(string name = "write_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(wr_agt_cfg)::get(this, "", "wr_agt_cfg", wr_agt_cfg_h))
			`uvm_fatal("wr_agent", "can't get wr_agt_cfg_h")
		
		mon = wr_mon::type_id::create("mon", this);
		if(wr_agt_cfg_h.is_active == UVM_ACTIVE)
		begin
			drv = wr_drv::type_id::create("drv", this);
			seqr = wr_seqr::type_id::create("seqr", this);
		end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		mon.vif = wr_agt_cfg_h.vif;
		if(wr_agt_cfg_h.is_active == UVM_ACTIVE)
		begin
			drv.vif = wr_agt_cfg_h.vif;
			drv.seq_item_port.connect(seqr.seq_item_export);
		end
	endfunction
endclass
