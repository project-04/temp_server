

class aux_sequencer extends uvm_sequencer#(aux_trans);

	`uvm_component_utils(aux_sequencer)
	
	function new(string name = "aux_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction 

endclass	