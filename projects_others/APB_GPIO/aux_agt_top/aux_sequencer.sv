class aux_sequencer extends uvm_sequencer#(aux_xtn);

	`uvm_component_utils(aux_sequencer)

	function new(string name="aux_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

endclass
