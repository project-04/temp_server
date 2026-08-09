class wr_agt_cfg extends uvm_object;
	`uvm_object_utils(wr_agt_cfg)
	
	virtual ven_if vif;
	uvm_active_passive_enum is_active;
	
	function new(string name = "wr_agt_cfg");
		super.new(name);
	endfunction
endclass
