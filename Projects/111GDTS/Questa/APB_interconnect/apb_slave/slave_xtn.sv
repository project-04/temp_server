class slave_xtn extends uvm_sequence_item;

	`uvm_object_utils(slave_xtn)

    rand bit[31:0] Prdata;
    bit[31:0] Pwdata[31:0];
    bit Pwrite; 
	extern function new(string name = "slave_xtn");
	extern function void do_print(uvm_printer printer);


 endclass

        
	function slave_xtn::new(string name = "slave_xtn");
		super.new(name);
	endfunction

	function void slave_xtn::do_print (uvm_printer printer);
		printer.print_field("Pwrite",this.Pwrite,1,UVM_DEC);
		printer.print_field("Prdata",this.Prdata,32,UVM_HEX);
	endfunction

	


