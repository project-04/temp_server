class ram_config extends uvm_object;
	`uvm_object_utils(ram_config)
	//virtual ram_if vif;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit has_function_coverage = 0;
	bit has_scroeboard = 1;
	bit has_write_agent = 1;
	bit has_read_agent = 1;
	static int mon_rcvd_xtn_cnt = 0;
	int ram_verbosity;

	function new(string name = "ram_config");
		super.new(name);
	endfunction
endclass
