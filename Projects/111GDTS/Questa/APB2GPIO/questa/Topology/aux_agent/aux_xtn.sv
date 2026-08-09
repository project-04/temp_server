class aux_xtn extends uvm_sequence_item;

	
`uvm_object_utils(aux_xtn)

extern function new(string name = "aux_xtn");
extern function void do_print(uvm_printer printer);

endclass

//Constructor new method  
function aux_xtn::new(string name = "aux_xtn");
	super.new(name);
endfunction

//do_ print
function void  aux_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
endfunction

 

