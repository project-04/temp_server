class io_sequence extends uvm_sequence#(io_xtn);

	`uvm_object_utils(io_sequence)

	extern function new(string name="io_sequence");
	extern task body();

endclass

function io_sequence:: new(string name="io_sequence");
	super.new(name);
endfunction

task io_sequence::body();

	req=io_xtn::type_id::create("req");
		begin



		end

endtask

