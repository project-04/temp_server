class spi_xtn extends uvm_sequence_item;
   `uvm_object_utils(spi_xtn);

   bit ss;
   bit sclk;
   bit [7:0] mosi;
   rand bit [7:0] miso;
   bit spi_inpt_req;
	
   extern function new(string name="spi_xtn");
   extern function void do_print(uvm_printer printer);
 endclass

 function spi_xtn :: new(string name="spi_xtn");
   super.new(name);
 endfunction

 function void spi_xtn :: do_print(uvm_printer printer);
   super.do_print(printer);
	
   printer.print_field("ss", this.ss, 1, UVM_BIN);
   printer.print_field("mosi", this.mosi, 8, UVM_BIN);
   printer.print_field("miso", this.miso, 8, UVM_BIN);
   printer.print_field("spi_inpt_req", this.spi_inpt_req, 1, UVM_BIN);
 endfunction
