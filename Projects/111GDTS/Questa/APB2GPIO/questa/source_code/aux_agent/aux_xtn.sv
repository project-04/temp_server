class aux_xtn extends uvm_sequence_item;

	
`uvm_object_utils(aux_xtn)

	rand bit[31:0]aux_in;

extern function new(string name = "aux_xtn");
extern function void do_print(uvm_printer printer);

endclass

//Constructor new method  
function aux_xtn::new(string name = "aux_xtn");
	super.new(name);
endfunction

//do_ print
function void  aux_xtn::do_print (uvm_printer printer);


	printer.print_field("aux_in", this.aux_in , 32 , UVM_HEX);
endfunction

 

