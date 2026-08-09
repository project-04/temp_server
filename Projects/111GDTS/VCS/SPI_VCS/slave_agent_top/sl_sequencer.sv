class sl_sequencer extends uvm_sequencer #(sl_xtn);
	
	`uvm_component_utils(sl_sequencer)

extern function new(string name ="sl_sequencer", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function sl_sequencer::new(string name ="sl_sequencer", uvm_component parent);
	super.new(name,parent);
endfunction 

function void sl_sequencer::build_phase(uvm_phase phase);
	super.build_phase(phase);
`uvm_info("sl_sequencer","This is in Slave_Sequencer",UVM_LOW)
//uvm_top.print_topology();
endfunction
