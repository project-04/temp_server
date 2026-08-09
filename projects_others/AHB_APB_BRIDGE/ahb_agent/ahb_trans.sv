class ahb_trans extends uvm_sequence_item;

	`uvm_object_utils(ahb_trans)

	function new(string name="ahb_trans");
		super.new(name);
	endfunction

	rand bit[31:0] Haddr;
	rand bit[31:0] Hwdata;
	     bit[31:0] Hrdata;
	rand bit       Hwrite;
	     bit       Hreadyout;
	     bit       Hreadyin;
	rand bit[2:0]  Hsize;
	rand bit[1:0]  Htrans;
	rand bit[2:0]  Hburst;
	rand bit[9:0]  length; 
	

	constraint ADDR_VAL{Hsize inside {0,1,2};}

	constraint ADDR_SIZE{	(Hsize==1)->(Haddr%2==0);
				(Hsize==2)->(Haddr%4==0);}

	constraint S_SEL{Haddr inside { [32'h8000_0000:32'h8000_03FF],
									[32'h8400_0000:32'h8400_03FF],
									[32'h8800_0000:32'h8800_03FF],
									[32'h8c00_0000:32'h8c00_03FF]};
																	}     

	constraint BURST_LEN{				(Hburst==2) -> (length==4);
							(Hburst==3) -> (length==4);
							(Hburst==4) -> (length==8);
							(Hburst==5) -> (length==8);
							(Hburst==6) -> (length==16);
							(Hburst==7) -> (length==16);
														}

	constraint LEN_VAL {(Haddr%1024)+(length*2**Hsize)<=1023;}

	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Haddr",	this.Haddr,	$bits(Haddr),	UVM_DEC);
		printer.print_field("Hwdata",	this.Hwdata,	$bits(Hwdata),	UVM_DEC);
		printer.print_field("Hrdata",	this.Hrdata,	$bits(Hrdata),	UVM_DEC);
		printer.print_field("Hreadyin",	this.Hreadyin,	$bits(Hreadyin),	UVM_DEC);
		printer.print_field("Hreadyout",this.Hreadyout,	$bits(Hreadyout),	UVM_DEC);
		printer.print_field("Hwrite",	this.Hwrite,	$bits(Hwrite),  UVM_DEC);
		printer.print_field("Hsize",	this.Hsize,		$bits(Hsize),	UVM_DEC);
		printer.print_field("Htrans",	this.Htrans,	$bits(Htrans),	UVM_DEC);
		printer.print_field("Hburst",	this.Hburst,	$bits(Hburst),	UVM_DEC);
		printer.print_field("length",	this.length,	$bits(length),	UVM_DEC);
	endfunction




function void do_copy(uvm_object rhs);
	ahb_trans rhs_t;

	if(!$cast(rhs_t, rhs))
		`uvm_fatal("DO_COPY", "Cast of rhs to ahb_trans failed in do_copy()")

	super.do_copy(rhs);

	this.Haddr  = rhs_t.Haddr;
	this.Hwdata = rhs_t.Hwdata;
	this.Hrdata = rhs_t.Hrdata;
	this.Hwrite = rhs_t.Hwrite;
	this.Hreadyin = rhs_t.Hreadyout;
	this.Hreadyout = rhs_t.Hreadyin;
	this.Hsize  = rhs_t.Hsize;
	this.Htrans = rhs_t.Htrans;
	this.Hburst = rhs_t.Hburst;
	this.length = rhs_t.length;
endfunction


endclass
