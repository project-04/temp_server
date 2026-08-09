class trans extends uvm_sequence_item;
	`uvm_object_utils(trans)
     
		//inputs
		logic PRESETn;
	rand	logic [31:0] PADDR;
  	rand 	logic [31:0] PWDATA;
  	rand 	logic PWRITE;
	      	logic PENABLE;
	      	logic PSEL;	//only connect the one the are needed 
	      	logic RDX;
	      	
	      	//outputs
	      	logic [31:0] PRDATA;
	      	logic PREADY;
	      	logic PSLVERR;
	      	logic IRQ;
	      	logic TXD;
	
		logic baud_0;

	// UART REGISTER FIELDS
   	 logic [7:0]  lcr;
	 logic [15:0] divisor;
	 logic [7:0]  fcr;
	 logic [7:0]  ier;
	 logic [7:0]  iir;
	 logic [7:0]  mcr;
	 logic [7:0]  lsr;

	logic data_in_thr;
	logic data_in_rbr;

	logic [7:0] thr[$];
	logic [7:0] rbr[$];
 
	function new(string name = "trans");
		super.new(name);
	endfunction
 
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
         	printer.print_field("time",	$time,  	$bits($time),	UVM_DEC);
	    	printer.print_field("PRESETn",	this.PRESETn,  	$bits(PRESETn), UVM_DEC);
	    	printer.print_field("PADDR",	this.PADDR,  	$bits(PADDR), 	UVM_HEX);
	    	printer.print_field("PWDATA",	this.PWDATA, 	$bits(PWDATA), 	UVM_HEX);
	    	printer.print_field("PWRITE", 	this.PWRITE,  	$bits(PWRITE), 	UVM_DEC);
		printer.print_field("PENABLE",  this.PENABLE,  	$bits(PENABLE), UVM_DEC);
	    	printer.print_field("PSEL", 	this.PSEL, 	$bits(PSEL), 	UVM_DEC);
	    	//printer.print_field("RDX",     	this.RDX,  	$bits(RDX), 	UVM_DEC);
	    	
	    	printer.print_field("PRDATA",  	this.PRDATA,  	$bits(PRDATA), 	UVM_BIN);
	    	printer.print_field("PREADY",  	this.PREADY, 	$bits(PREADY), 	UVM_DEC);
	    	printer.print_field("PSLVERR", 	this.PREADY,  	$bits(PREADY), 	UVM_DEC);
	    	printer.print_field("IRQ",  	this.IRQ,  	$bits(IRQ), 	UVM_DEC);
	    	//printer.print_field("TXD", 	this.TXD, 	$bits(TXD), 	UVM_DEC);
	    	
	    	printer.print_field("baud_0", 	this.baud_0,  	$bits(baud_0), 	UVM_DEC);
	    	
	    	printer.print_field("ier",	this.ier,	$bits(ier),	UVM_BIN);
		printer.print_field("iir",	this.iir,	$bits(iir),	UVM_BIN);
		printer.print_field("fcr",	this.fcr,	$bits(fcr),	UVM_BIN);
		printer.print_field("lcr",	this.lcr,	$bits(lcr),	UVM_BIN);
		printer.print_field("lsr",	this.lsr,	$bits(lsr),	UVM_BIN);
		printer.print_field("mcr",	this.mcr,	$bits(mcr),	UVM_BIN);
		printer.print_field("divisor",	this.divisor,	$bits(divisor),	UVM_DEC);
		//printer.print_field("dl_access",	this.dl_access,		$bits(dl_access),	UVM_DEC);
		printer.print_field("data_in_thr",	this.data_in_thr,	$bits(data_in_thr),	UVM_DEC);
		printer.print_field("data_in_rbr",	this.data_in_rbr,	$bits(data_in_rbr),	UVM_DEC);
		
		foreach(thr[i])
	    		printer.print_field($sformatf("thr[%0d]", i),	this.thr[i],	$bits(thr[i]),	UVM_BIN);
	    	
	    	foreach(rbr[i])
	    		printer.print_field($sformatf("rbr[%0d]", i),	this.rbr[i],	$bits(rbr[i]),	UVM_BIN);
	endfunction
endclass
