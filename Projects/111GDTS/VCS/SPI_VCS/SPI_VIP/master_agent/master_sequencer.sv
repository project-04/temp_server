class master_sequencer extends uvm_sequencer#(master_xtn);

//FACTORY 
	`uvm_component_utils(master_sequencer)
//METHODS
	extern function new(string name = "master_sequencer",uvm_component parent);
endclass

//CONSTRUNCTOR
	function master_sequencer::new(string name = "master_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
