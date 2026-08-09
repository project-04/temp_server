class src_base_sequence extends uvm_sequence #(write_xtn);
	`uvm_object_utils(src_base_sequence)
	
		function new(string name = "base_sequence");
			super.new(name);
		endfunction 
endclass

class small_sequence extends src_base_sequence;
	`uvm_object_utils(small_sequence)
	bit[1:0] addr;
		function new(string name = "small_sequence");
			super.new(name);
		endfunction 
	
	task body();
		req = write_xtn::type_id::create("req");

		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit1",addr))
			`uvm_fatal("small_sequence","not able to get")

		start_item(req);
		assert(req.randomize()with{header[7:2]<15;header[1:0]==addr;})
		finish_item(req);

	`uvm_info("small_sequence","PRINTING FROM SMALL SEQUENCE",UVM_LOW)
	req.print;
	endtask
	
endclass

class mid_sequence extends src_base_sequence;
	`uvm_object_utils(mid_sequence)
	bit[1:0] addr;
		function new(string name = "mid_sequence");
			super.new(name);
		endfunction 
	
	task body();
		req = write_xtn::type_id::create("req");

		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit2",addr))
			`uvm_fatal("mid_sequence","not able to get")

		start_item(req);
		assert(req.randomize()with{header[7:2] inside{[15:30]} ;header[1:0]==addr;})
		finish_item(req);

	`uvm_info("mid_sequence","PRINTING FROM SMALL SEQUENCE",UVM_LOW)
	req.print;
endtask
endclass

class large_sequence extends src_base_sequence;
	`uvm_object_utils(large_sequence)
	bit[1:0] addr;
		function new(string name = "large_sequence");
			super.new(name);
		endfunction 
	
	task body();
		req = write_xtn::type_id::create("req");

		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit3",addr))
			`uvm_fatal("large_sequence","not able to get")

		start_item(req);
		assert(req.randomize()with{header[7:2]>30 && header[7:2]<64 ;header[1:0]==addr;})
		finish_item(req);

	`uvm_info("large_sequence","PRINTING FROM SMALL SEQUENCE",UVM_LOW)
	req.print;
endtask
endclass
