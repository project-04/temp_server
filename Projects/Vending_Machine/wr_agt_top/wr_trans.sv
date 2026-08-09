class wr_trans extends uvm_sequence_item;
	`uvm_object_utils(wr_trans)
	
	rand logic reset;
	rand logic [1:0] coin_in;
	/*logic done_out;
	logic [6:0] lsb7seg_out, msb7seg_out;*/
	
	constraint c1 {reset dist{0:=90, 1:=1};}
	
	function new(string name = "wr_trans");
		super.new(name);
	endfunction
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
		printer.print_field("reset", 	reset, 		$bits(reset), 	UVM_BIN);
		printer.print_field("coin_in",	coin_in,	$bits(coin_in), UVM_BIN);
	endfunction
endclass
