class wb_Vsequence extends uvm_sequence#(uvm_sequence_item);

	`uvm_object_utils(wb_Vsequence)

// WB sequencer Handle
wb_sequencer wb_seqh;

// Virtual Sequencer handle
wb_Vsequencer wb_seqrh;

// WB_xtn handle

wb_xtn wb_xtnh;

	extern function new(string name = "wb_Vsequence");
	extern task body();

endclass 

function ram_vbase_seq::new(string name ="wb_Vsequence");
	super.new(name);
endfunction

task


