class io_xtn extends uvm_sequence_item;

	
`uvm_object_utils(io_xtn)

	rand logic[31:0]io_pad;
        rand bit[1:0] ctrl;

extern function new(string name = "io_xtn");
extern function void do_print(uvm_printer printer);
extern function void post_randomize;

endclass

//Constructor new method  
function io_xtn::new(string name = "io_xtn");
	super.new(name);
endfunction

//do_ print
function void  io_xtn::do_print (uvm_printer printer);

	printer.print_field("io_pad", this.io_pad , 32 , UVM_HEX);

endfunction


function void io_xtn::post_randomize();


	if(ctrl=='b00)
	    io_pad[31:0]='hz;
        else if(ctrl=='b01)
	    io_pad[31:0]=io_pad[31:0];
	else if(ctrl=='b11)
	  io_pad[31:16]='hz;
		
endfunction
 

