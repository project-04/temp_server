class aux_cfg extends uvm_object;

	`uvm_object_utils(aux_cfg)


	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual aux_input_if vif;
	extern function new(string name = "aux_cfg");

endclass

function aux_cfg::new(string name = "aux_cfg");
  super.new(name);
endfunction
