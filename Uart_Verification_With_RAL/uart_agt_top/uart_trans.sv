class uart_trans extends uvm_sequence_item;
	`uvm_object_utils(uart_trans)

	function new(string name="uart_trans");
		super.new(name);
	endfunction

   static   bit [7:0] THR [$];
   static   bit [7:0] RBR [$];
      
	rand bit [7:0]tx;
	rand bit parity;
	bit [7:0]rx;

	function void do_print(uvm_printer printer);
		super.do_print(printer);
	
		printer.print_field("tx",this.tx,8,UVM_BIN);
		printer.print_field("rx",this.rx,8,UVM_BIN);
		printer.print_field("Parity",this.parity,1,UVM_BIN);
	endfunction

endclass
