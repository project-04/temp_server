class io_config extends uvm_object;

	`uvm_object_utils(io_config)

	function new(string name="io_config");
		super.new(name);
	endfunction

	uvm_active_passive_enum is_active;

	virtual  io_if vif;

endclass
