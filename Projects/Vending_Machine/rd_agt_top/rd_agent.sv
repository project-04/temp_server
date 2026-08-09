class read_agent extends uvm_agent;
	`uvm_component_utils(read_agent)
	
	rd_agt_cfg rd_agt_cfg_h;
	rd_mon mon;
	
	function new(string name = "read_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(rd_agt_cfg)::get(this, "", "rd_agt_cfg", rd_agt_cfg_h))
			`uvm_fatal("rd_agent", "can't get rd_agt_cfg_h")
		
		mon = rd_mon::type_id::create("mon", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		mon.vif = rd_agt_cfg_h.vif;
	endfunction
endclass
