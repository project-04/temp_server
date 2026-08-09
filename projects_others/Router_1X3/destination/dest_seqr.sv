class dest_seqr extends uvm_sequencer #(read_xtn);
	`uvm_component_utils(dest_seqr)
	
	function new(string name = "dest_seqr",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
endclass


