class aux_config extends uvm_object;

	`uvm_object_utils(aux_config)

	function new(string name="aux_config");
		super.new(name);
	endfunction

	uvm_active_passive_enum is_active;

	virtual  aux_if vif;

endclass
