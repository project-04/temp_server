
class v_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
   // Factory Registration
	 `uvm_component_utils(v_sequencer)


   apb_sequencer apb_seqrh;
   aux_sequencer aux_seqrh;
   io_sequencer io_seqrh;


   // Standard Methods:
 	 extern function new(string name = "v_sequencer",uvm_component parent);
	 extern function void build_phase(uvm_phase phase);
endclass

// Define Constructor new() function
function v_sequencer::new(string name="v_sequencer",uvm_component parent);
	 super.new(name,parent);
endfunction

// function void build_phase

function void v_sequencer::build_phase(uvm_phase phase);
	 super.build_phase(phase);
endfunction
