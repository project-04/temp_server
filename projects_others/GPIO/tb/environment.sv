


class environment extends uvm_env;

	`uvm_component_utils(environment)
	
	function new (string name = "environment",uvm_component parent);
		super.new(name,parent);
	endfunction 

		