class aux_driver extends uvm_driver#(aux_xtn);

	`uvm_component_utils(aux_driver)

	function new(string name="aux_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

endclass

