class slave_base_seqs extends uvm_sequence #(slave_xtn);

	`uvm_object_utils(slave_base_seqs)
	
	extern function new(string name ="slave_base_seqs");
endclass

//-----------------  constructor new method  -------------------//
function slave_base_seqs::new(string name ="slave_base_seqs");
        super.new(name);
endfunction


/************************   Sequence-1  ***********************/


class sseq1 extends slave_base_seqs;

    `uvm_object_utils(sseq1)

function new(string name = "sseq1");
    super.new(name);
endfunction


task body();


    req = slave_xtn::type_id::create("req");

    start_item(req);
    assert(req.randomize());
    finish_item(req);

endtask
endclass
