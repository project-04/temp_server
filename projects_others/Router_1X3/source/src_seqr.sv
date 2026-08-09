class src_seqr extends uvm_sequencer #(write_xtn);
	`uvm_component_utils(src_seqr)
	
	function new(string name = "src_seqr",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
endclass


