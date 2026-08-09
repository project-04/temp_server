class apb_cfg extends uvm_object;

	`uvm_object_utils(apb_cfg)


	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual apb_if vif;
	extern function new(string name = "apb_cfg");

endclass

function apb_cfg::new(string name = "apb_cfg");
  super.new(name);
endfunction
