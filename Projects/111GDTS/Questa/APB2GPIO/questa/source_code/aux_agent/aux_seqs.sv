class aux_sequence extends uvm_sequence#(aux_xtn);

	`uvm_object_utils(aux_sequence)

	extern function new(string name="aux_sequence");

endclass

function aux_sequence:: new(string name="aux_sequence");
	super.new(name);
endfunction


class aux_seq1 extends aux_sequence;

	`uvm_object_utils(aux_seq1)

	extern function new(string name="aux_seq1");
	extern task body();

endclass

function aux_seq1:: new(string name="aux_seq1");
	super.new(name);
endfunction

task aux_seq1::body();

	req=aux_xtn::type_id::create("req");
   begin

       start_item(req);
       assert(req.randomize());
       finish_item(req);

   end

endtask
