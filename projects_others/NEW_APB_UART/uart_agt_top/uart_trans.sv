
class uart_trans extends uvm_sequence_item;

	`uvm_object_utils(uart_trans)
	
	function new (string name = "uart_trans");
		super.new(name);	
	endfunction 

	rand bit [7:0] tx;
	     bit [7:0] rx;
	     bit       parity;
	     bit       stop_bit;		    	

	function void do_print(uvm_printer printer);
		super.do_print(printer);

		printer.print_field("tx",tx,$bits(tx),UVM_DEC);
		printer.print_field("rx",rx,$bits(rx),UVM_DEC);
		printer.print_field("parity",parity,$bits(parity),UVM_DEC);
		printer.print_field("stop_bit",stop_bit,$bits(stop_bit),UVM_DEC);

	endfunction 

endclass

