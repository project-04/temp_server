class axi_slv_sequencer extends uvm_sequencer #(axi_xtn);
	`uvm_component_utils(axi_slv_sequencer)

	// Methods
	extern function new(string name ="axi_slv_sequencer", uvm_component parent);
endclass

function axi_slv_sequencer :: new(string name="axi_slv_sequencer", uvm_component parent);
	super.new(name, parent);
endfunction
