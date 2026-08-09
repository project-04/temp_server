class io_sequencer extends uvm_sequencer#(io_xtn);

	`uvm_component_utils(io_sequencer)

	function new(string name="io_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

endclass

