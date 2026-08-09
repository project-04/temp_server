class dest_agt_config extends uvm_object;
	`uvm_object_utils(dest_agt_config)
	
	virtual router_if vif;
	uvm_active_passive_enum is_active;
	function new(string name = "dest_agt_config");
		super.new(name);
	endfunction 

endclass
