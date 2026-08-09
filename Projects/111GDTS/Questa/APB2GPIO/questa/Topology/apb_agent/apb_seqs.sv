class apb_sequence extends uvm_sequence#(apb_xtn);

	`uvm_object_utils(apb_sequence)

	extern function new(string name="apb_sequence");
	extern task body();

endclass

function apb_sequence:: new(string name="apb_sequence");
	super.new(name);
endfunction

task apb_sequence::body();

	req=apb_xtn::type_id::create("req");
		begin



		end

endtask

