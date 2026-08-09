class aux_sequence extends uvm_sequence#(aux_xtn);

	`uvm_object_utils(aux_sequence)

	extern function new(string name="aux_sequence");
	extern task body();

endclass

function aux_sequence:: new(string name="aux_sequence");
	super.new(name);
endfunction

task aux_sequence::body();

	req=aux_xtn::type_id::create("req");
		begin



		end

endtask

