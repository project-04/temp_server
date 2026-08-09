class rd_trans extends uvm_sequence_item;
	`uvm_object_utils(rd_trans)
	
	/*logic reset;
	logic [1:0] coin_in;*/
	logic done_out;
	logic [6:0] lsb7seg_out, msb7seg_out;
	
	function new(string name = "rd_trans");
		super.new(name);
	endfunction
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
		printer.print_field("done_out", 	done_out, 		$bits(done_out), 	UVM_BIN);
		printer.print_field("lsb7seg_out",	lsb7seg_out,	$bits(lsb7seg_out), UVM_BIN);
		printer.print_field("msb7seg_out",	msb7seg_out,	$bits(msb7seg_out), UVM_BIN);
	endfunction
endclass
