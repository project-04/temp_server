class ma_sequencer extends uvm_sequencer#(trans);

	`uvm_component_utils(ma_sequencer)

	function new(string name="ma_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass
