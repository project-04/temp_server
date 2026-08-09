class io_cfg extends uvm_object;

	`uvm_object_utils(io_cfg)


	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual io_pad_if vif;
	extern function new(string name = "io_cfg");

endclass

function io_cfg::new(string name = "io_cfg");
  super.new(name);
endfunction
