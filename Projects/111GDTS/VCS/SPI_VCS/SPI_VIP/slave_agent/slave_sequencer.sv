class slave_sequencer extends uvm_sequencer#(slave_xtn);

//FACTORY 
	`uvm_component_utils(slave_sequencer)
//METHODS
	extern function new(string name = "slave_sequencer",uvm_component parent);
endclass

//CONSTRUNCTOR
	function slave_sequencer::new(string name = "slave_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
