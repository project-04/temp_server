class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)

	bit hresetn;
	rand bit hwrite;
	rand bit[31:0] haddr;
	randc bit[2:0] hburst;
	rand bit[2:0] hsize;
	rand bit[1:0] htrans;
	rand bit[31:0] hwdata;
	rand bit[9:0] hlen;
	rand bit[31:0] hrdata;
	bit hready_out;
	bit[1:0] hresp;
	bit hsel;
	
	bit[31:0] master_write_mem[int];
	bit[31:0] master_read_mem[int];

	bit[31:0] slave_write_mem[int];
	bit[31:0] slave_read_mem[int];


	function new(string name="trans");
		super.new(name);
	endfunction

	constraint c1{(haddr%1024)+(hlen*(2**hsize))<=1024;}

	constraint c2{hsize inside{0,1,2};}
	constraint c3{hsize==1 -> haddr%2==0;
	    	      hsize==2 -> haddr%4==0;}
	constraint c4{ hlen inside {[1:20]};}
     constraint c6{if(hwrite==1) hrdata==0;}
	constraint data_len {	if (hburst == 3'h0) (hlen == 1);
                             

                                if (hburst == 3'h2)(hlen == 4);
                                   
                                if (hburst == 3'h3)(hlen == 4);
                                
                                if (hburst == 3'h4)(hlen == 8);
                                   
                                if (hburst == 3'h5)(hlen == 8);
                                   
                                if (hburst == 3'h6)(hlen == 16);
                                   
                                if (hburst == 3'h7)(hlen == 16);}



	function void do_print(uvm_printer printer);
		printer.print_field("HRESETn",hresetn,1,UVM_DEC);
		printer.print_field("HBURST",hburst,3,UVM_DEC);
		printer.print_field("HRESP",hresp,2,UVM_DEC);
		printer.print_field("HADDR",haddr,32,UVM_HEX);
		printer.print_field("HTRANS",htrans,2,UVM_DEC);
		printer.print_field("HWDATA",hwdata,32,UVM_HEX);
		printer.print_field("HLEN",hlen,8,UVM_DEC);
		printer.print_field("HRDATA",hrdata,32,UVM_DEC);
		printer.print_field("HSIZE",hsize,3,UVM_DEC);
		printer.print_field("HWRITE",hwrite,1,UVM_DEC);
		printer.print_field("HREADY_OUT",hready_out,1,UVM_DEC);
	endfunction

endclass

