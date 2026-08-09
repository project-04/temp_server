class slave_xtn extends uvm_sequence_item;

//FACTORY
	`uvm_object_utils(slave_xtn)

//DATA MEMBERS
	rand bit [127:0] miso_pad_i;
	bit [7:0]ss_pad_o;
	bit[127:0] mosi_pad_o;

bit [32:0] rx,rx1;


//METHODS
	extern function new(string name = "slave_xtn");
	extern function void do_print(uvm_printer printer);

endclass

//CONSTRUCTOR

	function slave_xtn:: new(string name = "slave_xtn");
		super.new(name);
	endfunction

	function void slave_xtn::do_print(uvm_printer printer);
	
	        printer.print_field("MISOn_I",miso_pad_i,128,UVM_HEX);
	        printer.print_field("MOSI_O",mosi_pad_o,128,UVM_HEX);
	endfunction
