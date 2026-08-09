class mem extends uvm_mem;

	
	`uvm_object_utils(mem)
	
	function new(string name ="mem");
		super.new(name,'h16,8,"RW",UVM_NO_COVERAGE);
	endfunction
endclass
