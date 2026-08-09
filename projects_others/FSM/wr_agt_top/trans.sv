

class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)
	
	function new (string name = "trans");
		super.new(name);
	endfunction 

	rand bit din;
		 bit rst;
		 bit dout;	
		
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
		printer.print_field("din",din,$bits(din),UVM_BIN);
		printer.print_field("rst",rst,$bits(rst),UVM_BIN);
		printer.print_field("dout",dout,$bits(dout),UVM_BIN);
		
	endfunction 

endclass	
			
		