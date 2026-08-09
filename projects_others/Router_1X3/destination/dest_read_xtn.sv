class read_xtn extends uvm_sequence_item;
	`uvm_object_utils(read_xtn)
	
	rand bit[7:0] header,payload[];
	bit [7:0] parity;
	bit valid_out;
	bit read_enb;
	rand bit [7:0] count;
	
	constraint read_count{count inside{[1:28]};}
	
function void  do_print (uvm_printer printer);
	super.do_print(printer);

   
    //              	string name   		bitstream value         size          radix for printing
    printer.print_field( "read_enb", 		this.read_enb, 	     $bits(read_enb),		 UVM_DEC		);
    printer.print_field( "valid_out", 		this.valid_out, 	 $bits(valid_out),		 UVM_DEC		);
    printer.print_field( "header", 		    			    this.header,		 $bits(header),		     UVM_DEC       );
    foreach(payload[i]) 
	begin
    printer.print_field($sformatf("payload[%0d]", i),                       this.payload[i],             $bits(payload[i]),          UVM_DEC       );
    end
    printer.print_field( "parity", 		    			    this.parity,		 $bits(parity),		     UVM_DEC       );


endfunction:do_print

function bit do_compare(uvm_object rhs, uvm_comparer comparer = null);
    read_xtn rhs_;
    if (!$cast(rhs_, rhs)) 
	begin 
        `uvm_error("do_compare", "cast of rhs object failed")
        return 0;
    end

    if (!super.do_compare(rhs, comparer))
        return 0;

    if (this.header != rhs_.header)
        return 0;

    if (this.parity != rhs_.parity)
        return 0;

    if (this.payload.size() != rhs_.payload.size())
        return 0;

    foreach (this.payload[i]) begin
        if (this.payload[i] != rhs_.payload[i])
            return 0;
    end

    return 1;
endfunction


endclass
