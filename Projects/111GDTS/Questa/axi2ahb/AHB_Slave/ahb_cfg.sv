class ahb_cfg extends uvm_object;

	`uvm_object_utils(ahb_cfg)


	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual ahb_if vif;
	extern function new(string name = "ahb_cfg");

endclass

function ahb_cfg::new(string name = "ahb_cfg");
  super.new(name);
endfunction
