 class apb_xtn extends uvm_sequence_item;
   `uvm_object_utils(apb_xtn);

   // Properties
   bit PRESETn;
   rand bit PWRITE;
   bit PSEL;
   bit PENABLE;
   rand bit [31:0] PADDR;
   rand bit [31:0] PWDATA;
   bit [31:0] PRDATA;
   bit PREADY;
   bit PSLVERR;
   bit IRQ;
   
   static bit[31:0]in_reg;
   static bit[31:0]out_reg;
   static bit[31:0]oe_reg;
   static bit[31:0]inte_reg;
   static bit[31:0]ptrig_reg;
   static bit[31:0]aux_reg;
   static bit[31:0]ints_reg;
   static bit[31:0]eclk_reg;
   static bit[31:0]nec_reg;
   static bit[1:0]ctrl_reg;


	function void print_regs();
		$display("================================");
		$display("---Internal Registers of GPIO---");
		$displayh("0x00 in_reg    = 'h", in_reg);
		$displayh("0x04 out_reg   = 'h", out_reg);
		$displayh("0x08 oe_reg    = 'h", oe_reg);
		$displayh("0x0C inte_reg  = 'h", inte_reg);
		$displayh("0x10 ptrig_reg = 'h", ptrig_reg);
		$displayh("0x14 aux_reg   = 'h", aux_reg);
		$displayh("0x18 ints_reg  = 'h", ints_reg);
		$displayh("0x1C eclk_reg  = 'h", eclk_reg);
		$displayh("0x20 nec_reg   = 'h", nec_reg);
		$displayb("0x24 ctrl_reg  = 'b", ctrl_reg);
		$display("================================\n");
	endfunction
	
	
   extern function new(string name="apb_xtn");
   extern function void do_print(uvm_printer printer);
   extern function void post_randomize();
 endclass

 function apb_xtn :: new(string name="apb_xtn");
   super.new(name);
 endfunction

 function void apb_xtn :: do_print(uvm_printer printer);
   super.do_print(printer);

   printer.print_field("PRESETn", this.PRESETn, 1, UVM_HEX);
   printer.print_field("PWRITE", this.PWRITE, 1, UVM_HEX);
   printer.print_field("PSEL", this.PSEL, 1, UVM_HEX);
   printer.print_field("PENABLE", this.PENABLE, 1, UVM_HEX);
   printer.print_field("PADDR", this.PADDR, 32, UVM_HEX);
   printer.print_field("PWDATA", this.PWDATA, 32, UVM_HEX);
   printer.print_field("PRDATA", this.PRDATA, 32, UVM_HEX);
   printer.print_field("PREADY", this.PREADY, 1, UVM_HEX);
   printer.print_field("PSLVERR", this.PSLVERR, 1, UVM_HEX);
   printer.print_field("IRQ", this.IRQ, 1, UVM_HEX);
 endfunction

 function void apb_xtn :: post_randomize();
 
 endfunction

