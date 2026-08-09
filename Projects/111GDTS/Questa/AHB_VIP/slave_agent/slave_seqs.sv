class s_sequence extends uvm_sequence#(trans);

	`uvm_object_utils(s_sequence)

	function new(string name="s_sequence");
		super.new(name);
	endfunction

endclass


class ok_seq extends s_sequence;

	`uvm_object_utils(s_sequence)

	function new(string name="ok_seq");
		super.new(name);
	endfunction

	task body;
		req=trans::type_id::create("req");
		start_item(req);
		assert(req.randomize);
		finish_item(req);
	endtask

endclass

