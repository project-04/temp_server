

class apb_trans extends uvm_sequence_item;

	`uvm_object_utils(apb_trans)

	function new (string name = "apb_trans");
		super.new(name);
	endfunction 


		bit 		Presetn;
		bit 		Psel;
		bit 		Penable;
	rand 	bit 		Pwrite;
		bit 		Pready;
		bit 		Pslverr;
		bit 		IRQ;
	rand 	bit [31:0] 	Paddr;
	rand 	bit [31:0] 	Pwdata;
		bit [31:0] 	Prdata;


	bit [7:0] rbr[$];
	bit [7:0] thr[$];
	bit [7:0] ier;
	bit [7:0] iir;
	bit [7:0] fcr;
	bit [7:0] lcr;
	bit [7:0] lsr;
	bit [7:0] mcr;
	bit [25:0] divisor;
	bit dl_access;
	bit data_in_thr;
	bit data_in_rbr;


	function void do_print(uvm_printer printer);
		super.do_print(printer);

		printer.print_field("Presetn",Presetn,$bits(Presetn),UVM_DEC);
		printer.print_field("Psel",Psel,$bits(Psel),UVM_DEC);
		printer.print_field("Penable",Penable,$bits(Penable),UVM_DEC);
		printer.print_field("Pwrite",Pwrite,$bits(Pwrite),UVM_DEC);
		printer.print_field("Pready",Pready,$bits(Pready),UVM_DEC);
		printer.print_field("Pslverr",Pslverr,$bits(Pslverr),UVM_DEC);
		printer.print_field("IRQ",IRQ,$bits(IRQ),UVM_DEC);
		printer.print_field("Paddr",Paddr,$bits(Paddr),UVM_DEC);
		printer.print_field("Pwdata",Pwdata,$bits(Pwdata),UVM_DEC);
		printer.print_field("Prdata",Prdata,$bits(Prdata),UVM_DEC);

		printer.print_field("ier",ier,$bits(ier),UVM_DEC);
		printer.print_field("iir",iir,$bits(iir),UVM_DEC);
		printer.print_field("fcr",fcr,$bits(fcr),UVM_DEC);
		printer.print_field("lcr",lcr,$bits(lcr),UVM_DEC);
		printer.print_field("lsr",lsr,$bits(lsr),UVM_DEC);
		printer.print_field("mcr",mcr,$bits(mcr),UVM_DEC);
		printer.print_field("divisor",divisor,$bits(divisor),UVM_DEC);
		printer.print_field("dl_access",dl_access,$bits(dl_access),UVM_DEC);
		printer.print_field("data_in_thr",data_in_thr,$bits(data_in_thr),UVM_DEC);
		printer.print_field("data_in_rbr",data_in_rbr,$bits(data_in_rbr),UVM_DEC);

		
		foreach(rbr[i])
			begin 
				printer.print_field($sformatf("rbr[%od]",i),rbr[i],$bits(rbr[i]),UVM_DEC);
			end

		foreach(thr[i])
			begin 
				printer.print_field($sformatf("thr[%0d]",i),thr[i],$bits(thr[i]),UVM_DEC);
			end
	
	endfunction

endclass				
