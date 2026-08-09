class apb_uart_trans extends uvm_sequence_item;

	`uvm_object_utils(apb_uart_trans)

	function new(string name = "apb_uart_trans");
		super.new(name);
	endfunction 

             bit        Presetn;
	rand bit [31:0] Paddr;
             bit        Psel;
	rand bit        Pwrite;
             bit        Penable;
	rand bit [31:0] Pwdata;
             bit [31:0] Prdata;
             bit        Pready;
             bit        Pslverr;	
	     bit        IRQ;


	bit [7:0] RBR [$];
	bit [7:0] THR [$];
	bit [7:0] IER;
	bit [7:0] IIR;
	bit [7:0] FCR;
	bit [7:0] LCR;
	bit [7:0] LSR;
	bit [7:0] MCR;
	bit [7:0] MSR;
	bit [25:0] divisor;

	bit dl_access;
	bit data_in_thr;
	bit data_in_rbr;

	function void do_print(uvm_printer printer);
		super.do_print(printer);

		printer.print_field("Presetn",	Presetn,$bits(Presetn),	UVM_BIN);
		printer.print_field("Pwrite",	Pwrite,	$bits(Pwrite),	UVM_BIN);
		printer.print_field("Paddr",	Paddr,	$bits(Paddr),	UVM_HEX);
		printer.print_field("Pwdata",	Pwdata,	$bits(Pwdata),	UVM_DEC);
		printer.print_field("Prdata",	Prdata,	$bits(Prdata),	UVM_DEC);
		printer.print_field("Psel",	Psel,	$bits(Psel),	UVM_BIN);
		printer.print_field("Penable",	Penable,$bits(Penable),	UVM_BIN);
		printer.print_field("Pready",	Pready,	$bits(Pready),	UVM_BIN);
		printer.print_field("Pslverr",	Pslverr,$bits(Pslverr),	UVM_BIN);

		printer.print_field("IRQ",IRQ,$bits(IRQ),UVM_BIN);
		printer.print_field("IER",IER,$bits(IER),UVM_BIN);
		printer.print_field("IIR",IIR,$bits(IIR),UVM_BIN);
		printer.print_field("FCR",FCR,$bits(FCR),UVM_BIN);
		printer.print_field("LCR",LCR,$bits(LCR),UVM_BIN);
		printer.print_field("LSR",LSR,$bits(LSR),UVM_BIN);
		printer.print_field("MCR",MCR,$bits(MCR),UVM_BIN);
		printer.print_field("MSR",MSR,$bits(MSR),UVM_BIN);

		printer.print_field("dl_access",dl_access,$bits(dl_access),UVM_BIN);
		printer.print_field("data_in_thr",data_in_thr,$bits(data_in_thr),UVM_BIN);
		printer.print_field("data_in_rbr",data_in_rbr,$bits(data_in_rbr),UVM_BIN);

		foreach(THR[i])
			begin 
				printer.print_field($sformatf("THR[%0d]",i),this.THR[i],$bits(THR[i]),UVM_DEC);
			end

		foreach(RBR[i])
			begin 
				printer.print_field($sformatf("RBR[%0d]",i),this.RBR[i],$bits(RBR[i]),UVM_DEC);
			end


	endfunction 

endclass



