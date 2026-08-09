class axi_mast_sequencer extends uvm_sequencer #(axi_xtn);
	`uvm_component_utils(axi_mast_sequencer)

	//Properties
	// Methods
	extern function new(string name="axi_mast_sequencer", uvm_component parent);

endclass

function axi_mast_sequencer :: new(string name="axi_mast_sequencer", uvm_component parent);
	super.new(name, parent);
endfunction
