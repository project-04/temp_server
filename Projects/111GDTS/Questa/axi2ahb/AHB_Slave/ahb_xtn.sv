class ahb_xtn extends uvm_sequence_item;

	
`uvm_object_utils(ahb_xtn)


	bit HRESETn;
        bit [1:0] HTRANS;
        bit [2:0] HBURST;
        bit [2:0] HSIZE;
        bit HWRITE;
        bit [31:0] HADDR;
        bit [63:0] HWDATA;
       rand bit [63:0] HRDATA;
        bit HREADY;
        bit [1:0] HRESP;
	bit HGRANT;
	bit HMASTER;



extern function new(string name = "ahb_xtn");
extern function void do_print(uvm_printer printer);

endclass

//Constructor new method  
function ahb_xtn::new(string name = "ahb_xtn");
	super.new(name);
endfunction

//do_ print
function void  ahb_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
endfunction


