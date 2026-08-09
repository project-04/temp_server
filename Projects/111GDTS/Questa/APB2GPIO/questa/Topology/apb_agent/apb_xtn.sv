class apb_xtn extends uvm_sequence_item;

	
`uvm_object_utils(apb_xtn)

extern function new(string name = "apb_xtn");
extern function void do_print(uvm_printer printer);

endclass

//Constructor new method  
function apb_xtn::new(string name = "apb_xtn");
	super.new(name);
endfunction

//do_ print
function void  apb_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
endfunction
 

