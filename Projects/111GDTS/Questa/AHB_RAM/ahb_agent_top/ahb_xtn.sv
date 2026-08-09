class ahb_xtn extends uvm_sequence_item;

	`uvm_object_utils(ahb_xtn)

    	 bit HRESETn; // system bus reset
	 bit Hsel=1; // AHB peripheral select
	  bit Hready_in=1; // AHB ready bit
	 rand bit [1:0] Htrans; // AHB transfer type
	 rand bit [1:0] Hsize; // AHB hsize
	 rand bit Hwrite; // AHB hwrite
	 rand bit [11:0] Haddr; // AHB address bus
	 rand bit [31:0] Hwdata; // AHB write data bus
	 bit Hready_out; // AHB ready bit to S->M mux
	 bit Hresp; // AHB response
	// bit [31:0] Hrdata; 
	 rand bit[7:0]length;
	rand bit[2:0]Hburst;
	//extern function new(string name = "ahb_xtn");
	//extern function void do_print(uvm_printer printer);

	int mem[int];

     


constraint Hsize_cnst {Hsize inside {[0:2]};}

        constraint wr_rd_data {Hwrite == 0 -> Hwdata == 0;}

        constraint Haddr_cnst {Haddr inside {[12'h000:12'h100]};}

	constraint half_wrd_addr_cnst {(Hsize == 1) -> (Haddr%2 == 0);} 

	constraint wrd_addr_cnst {(Hsize == 2) -> (Haddr%4 == 0);} 
        
	constraint data_len {	if (Hburst == 3'h0) (length == 1);
                             
				if (Hburst == 3'h1)(length >= 1 && length < (255/(2**Hsize)));
                                   
                                if (Hburst == 3'h2)(length == 4);
                                   
                                if (Hburst == 3'h3)(length == 4);
                                
                                if (Hburst == 3'h4)(length == 8);
                                   
                                if (Hburst == 3'h5)(length == 8);
                                   
                                if (Hburst == 3'h6)(length == 16);
                                   
                                if (Hburst == 3'h7)(length == 16);}
		constraint aa{ (2**Hsize)*(length)<255;}	
	/*constraint kb_boundry{	if(Hburst == 1) Haddr <= (1024 - ((length)*(2**Hsize)));
				if((Hburst == 2) || (Hburst == 3)) Haddr <= (1024 - 4*(2**Hsize));
		                if((Hburst == 4) || (Hburst == 5)) Haddr <= (1024 - 8*(2**Hsize));
		                if((Hburst == 6) || (Hburst == 7)) Haddr <= (1024 - 16*(2**Hsize));}*/

        
	function new(string name = "ahb_xtn");
		super.new(name);
	endfunction

	function void do_print (uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Htrans",this.Htrans,2,UVM_DEC);
		printer.print_field("length",this.length,8,UVM_DEC);
		printer.print_field("Hsel",this.Hsel,1,UVM_DEC);
		printer.print_field("Hburst",this.Hburst,3,UVM_DEC);
		printer.print_field("Hsize",this.Hsize,3,UVM_DEC);
		printer.print_field("Haddr",this.Haddr,8,UVM_DEC);
		printer.print_field("Hwdata",this.Hwdata,32,UVM_HEX);
		foreach(mem[i])
		printer.print_field($sformatf("mem[%0d]",i),this.mem[i],32,UVM_HEX);
		printer.print_field("Hwrite",this.Hwrite,1,UVM_DEC);
		printer.print_field("Hready_in",this.Hready_in,1,UVM_DEC);
		printer.print_field("Hresp",this.Hresp,1,UVM_DEC);
	endfunction

	
       endclass
