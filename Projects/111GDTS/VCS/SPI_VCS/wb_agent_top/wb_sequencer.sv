class wb_sequencer extends uvm_sequencer#(wb_xtn);
       
	`uvm_component_utils(wb_sequencer)
	extern function new(string name="wb_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass
     
function wb_sequencer:: new(string name= "wb_sequencer",uvm_component parent);
	super.new(name,parent);

endfunction

function void wb_sequencer::build_phase(uvm_phase phase);
	super.build_phase(phase);
`uvm_info("wb_sequencer","This is in WB_SEQUENCER",UVM_LOW)
uvm_top.print_topology();
endfunction

