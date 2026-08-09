class ahb_xtn extends uvm_sequence_item;

	`uvm_object_utils(ahb_xtn)

	rand bit [31:0] Haddr;
	rand bit [31:0] Hwdata;
	rand bit [1:0] Htrans;
	rand bit [2:0] Hburst;
	rand bit [2:0] Hsize;
     rand bit [7:0] length;	
	rand bit Hwrite;
	bit [31:0] Hrdata;
     bit Hreadyin = 1;
     bit Hreadyout;
     bit[2:0]Hsel;

	extern function new(string name = "ahb_xtn");
	extern function void do_print(uvm_printer printer);


        constraint Hsize_cnst {Hsize inside {[0:2]};}

        constraint wr_rd_data {Hwrite == 0 -> Hwdata == 0;}

        constraint Haddr_cnst {Haddr inside {[32'h8000_0000:32'h8000_03FF], [32'h8400_0000:32'h8400_03FF],
					     [32'h8800_0000:32'h8800_03FF], [32'h8C00_0000:32'h8C00_03FF]};}

	constraint half_wrd_addr_cnst {(Hsize == 1) -> (Haddr%2 == 0);} 

	constraint wrd_addr_cnst {(Hsize == 2) -> (Haddr%4 == 0);} 
        
	constraint data_len {	if (Hburst == 3'h0) (length == 1);
                             
				if (Hburst == 3'h1)(length >= 1 && length < (1024/(2**Hsize)));
                                   
                                if (Hburst == 3'h2)(length == 4);
                                   
                                if (Hburst == 3'h3)(length == 4);
                                
                                if (Hburst == 3'h4)(length == 8);
                                   
                                if (Hburst == 3'h5)(length == 8);
                                   
                                if (Hburst == 3'h6)(length == 16);
                                   
                                if (Hburst == 3'h7)(length == 16);}
	
	/*constraint kb_boundry{	if(Hburst == 1) Haddr <= (1024 - ((length)*(2**Hsize)));
				if((Hburst == 2) || (Hburst == 3)) Haddr <= (1024 - 4*(2**Hsize));
		                if((Hburst == 4) || (Hburst == 5)) Haddr <= (1024 - 8*(2**Hsize));
		                if((Hburst == 6) || (Hburst == 7)) Haddr <= (1024 - 16*(2**Hsize));}*/
endclass

        
	function ahb_xtn::new(string name = "ahb_xtn");
		super.new(name);
	endfunction

	function void ahb_xtn::do_print (uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Htrans",this.Htrans,2,UVM_DEC);
		printer.print_field("Hburst",this.Hburst,3,UVM_DEC);
		printer.print_field("Hsize",this.Hsize,3,UVM_DEC);
		printer.print_field("Haddr",this.Haddr,32,UVM_HEX);
		printer.print_field("Hwdata",this.Hwdata,32,UVM_HEX);
		printer.print_field("Hrdata",this.Hrdata,32,UVM_HEX);
		printer.print_field("Hwrite",this.Hwrite,1,UVM_DEC);
	endfunction

	

