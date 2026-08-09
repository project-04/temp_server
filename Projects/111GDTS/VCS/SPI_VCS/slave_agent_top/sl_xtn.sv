class sl_xtn extends uvm_sequence_item;

	
`uvm_object_utils(sl_xtn)

        bit [127:0] mosi_pad_o;
	rand bit [127:0] miso_pad_i;
        bit [7:0]ss_pad_o='b00000010;
        bit sclk_pad_o;


extern function new(string name = "sl_xtn");
extern function void do_print(uvm_printer printer);

endclass

function sl_xtn::new(string name = "sl_xtn");
	super.new(name);
endfunction

function void  sl_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

	printer.print_field("mosi_pad_o",	this.mosi_pad_o,	128,		UVM_DEC);

	printer.print_field("miso_pad_i",	this.miso_pad_i,	128,		UVM_DEC);
	printer.print_field("ss_pad_o",		this.ss_pad_o,		8,		UVM_DEC);


endfunction

