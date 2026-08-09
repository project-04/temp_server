class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	function new(string name="env_config");
		super.new(name);
	endfunction

	int no_of_aux_agt;
	int no_of_apb_agt;
	int no_of_io_agt;

	apb_config apb_cfg[];
	aux_config aux_cfg[];
	io_config  io_cfg[];

endclass
