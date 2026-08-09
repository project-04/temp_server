class write_xtn extends uvm_sequence_item;
	`uvm_object_utils(write_xtn)
	

	rand bit[7:0] header,payload[];
	bit [7:0] parity;
	bit error;
	bit busy;
	
	constraint  valid_addr{header[1:0]!=2'b11;}
 	constraint  valid_len{header[7:2]!=0;}
	constraint  valid_size{payload.size==header[7:2];}

	function void post_randomize();
		parity = header;
		foreach(payload[i])
			begin  
				parity = payload[i]^parity;
			end
	endfunction 
	

	
function void  do_print (uvm_printer printer);
	super.do_print(printer);

    printer.print_field( "header", 		    			    this.header,		 $bits(header),		     UVM_DEC       );
    foreach(payload[i]) 
	begin
    printer.print_field($sformatf("payload[%0d]", i),                       this.payload[i],             $bits(payload[i]),          UVM_DEC       );
    end
    printer.print_field( "parity", 		    			    this.parity,		 $bits(parity),		     UVM_DEC       );
    printer.print_field( "error", 			                    this.error, 	         $bits(error),		     UVM_DEC       );
    printer.print_field( "busy", 			                    this.busy, 	         	 $bits(busy),		     UVM_DEC       );

	

endfunction:do_print

endclass
