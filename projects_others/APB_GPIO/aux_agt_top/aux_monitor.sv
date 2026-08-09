class aux_monitor extends uvm_monitor;

	`uvm_component_utils(aux_monitor)

	function new(string name="aux_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

endclass
