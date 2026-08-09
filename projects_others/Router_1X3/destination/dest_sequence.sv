class dest_base_sequence extends uvm_sequence #(read_xtn);
	`uvm_object_utils(dest_base_sequence)
	
		function new(string name = "dest_base_sequence");
			super.new(name);
		endfunction 
endclass

class read_sequence extends dest_base_sequence;
	`uvm_object_utils(read_sequence)
	
		function new(string name = "read_sequence");
			super.new(name);
		endfunction 

	task body();
		req = read_xtn::type_id::create("read_xtn");
		start_item(req);
		assert(req.randomize );
		finish_item(req);
	endtask
	
endclass
