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
   
   bit[31:0]in_reg;
   bit[31:0]out_reg;
   bit[31:0]oe_reg;
   bit[31:0]inte_reg;
   bit[31:0]ptrig_reg;
   bit[31:0]aux_reg;
   bit[31:0]ints_reg;
   bit[31:0]eclk_reg;
   bit[31:0]nec_reg;
   bit[1:0]ctrl_reg;

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

