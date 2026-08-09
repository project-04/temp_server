class env_config extends uvm_object;
	`uvm_object_utils(env_config);
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	int no_of_src_agt;
	int no_of_dest_agt;

	int no_of_src_agt_top;
	int no_of_dest_agt_top;

	src_agt_config src_cfg[];
	dest_agt_config dest_cfg[];
	
	function new(string name = "env_config");
		super.new(name);
	endfunction 

endclass

	
