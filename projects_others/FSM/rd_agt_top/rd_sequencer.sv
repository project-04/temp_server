


class rd_sequencer extends uvm_sequencer#(trans);

	`uvm_component_utils(rd_sequencer)
	
	function new (string name = "rd_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction 

endclass	