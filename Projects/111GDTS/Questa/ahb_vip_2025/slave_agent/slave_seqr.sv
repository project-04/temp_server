class s_sequencer extends uvm_sequencer#(trans);

	`uvm_component_utils(s_sequencer)

	function new(string name="m_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

