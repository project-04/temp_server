class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)
     
     rand bit wr_en;
     bit rd_en;
     rand bit[3:0]addr;
     rand bit[7:0]data_in;
     bit[7:0]data_out;

	function new(string name="trans");
		super.new(name);
	endfunction

     constraint c1{wr_en==0 -> data_in==0;}

	function void do_print(uvm_printer printer);
		printer.print_field("wr_en",wr_en,1,UVM_DEC);
		printer.print_field("address",addr,4,UVM_DEC);
		printer.print_field("data_in",data_in,8,UVM_DEC);
		printer.print_field("rd_en",rd_en,1,UVM_DEC);
		printer.print_field("data_out",data_out,8,UVM_DEC);
	endfunction

endclass

