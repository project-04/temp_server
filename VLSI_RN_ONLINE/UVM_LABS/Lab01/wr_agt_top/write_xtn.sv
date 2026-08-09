/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   write_xtn.sv

Description		:	Write transaction class for Dual port RAM
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


// Extend write_xtn from uvm_sequence_item
class write_xtn extends uvm_sequence_item;
  
	// UVM Factory Registration Macro
	`uvm_object_utils(write_xtn)
	
	// clone not possible when we use 7lines of code.
	/*
	typedef uvm_object_registry #(write_xtn) type_id;
	static function type_id get_type();
		return type_id::get();
	endfunction
	function string get_type_name();
		return "write_xtn";
	endfunction
	*/
	//------------------------------------------
	// DATA MEMBERS (Outputs non-rand, inputs rand)
	//------------------------------------------

	// Add the rand fields - data (`RAM_WIDTH-1:0), address(`ADDR_SIZE – 1:0),declared in tb_defs.sv
	// write (type bit) 
	rand bit [`RAM_WIDTH-1 : 0] data;
	rand bit [`ADDR_SIZE-1 : 0] address;
	rand bit write;
	
  
	// Add the rand control knobs declared in tb_defs.sv
	// xtn_type (enumerated type addr_t)  -  for controlling the type of transaction 
	// xtn_delay (integer type) - for inserting delay between transactions
	rand addr_t xtn_type;
	rand bit[63:0] xtn_delay;
	
         
	//------------------------------------------
	// CONSTRAINTS
	//------------------------------------------
	 
	// Add the following constraints :
	// Data between 20 through 90
	// Address between 0 through 200
	// Distribute weights for xtn_type : BAD_XTN=2 and GOOD_XTN=30
	constraint c1 {data inside {[20:90]};}
	constraint c2 {address inside {[0:200]};}
	constraint c3 {xtn_type dist{BAD_XTN :=2 , GOOD_XTN := 30};}
	

	//------------------------------------------
	// METHODS
	//------------------------------------------
	//-----------------  constructor new method  -------------------//
	//Add code for new()
	function new(string name = "write_xtn");
		super.new(name);
	endfunction

	//-----------------  do_copy method  -------------------//
	//Add code for do_copy() to copy address, data, write, xtn_type and xtn_delay
	function void do_copy (uvm_object rhs);

    		// handle for overriding the variable
	    	write_xtn rhs_;

		// Add a check for rhs_ using $cast to check that the object types are 
		// compatible
		if(!$cast(rhs_, rhs))
		begin
			`uvm_fatal("do copy","cast of the rhs object failed")
		end
		// Copy over data members:
		// <var_name> = rhs_.<var_name>;
		//super.do_copy(rhs);
		this.data = rhs_.data;
		this.address = rhs_.address;
		this.write = rhs_.write;
		this.xtn_type = rhs_.xtn_type;
		this.xtn_delay = rhs_.xtn_delay;

	endfunction:do_copy


	// Standard UVM Methods like constructor,do_compare,do_copy,do_print,post_randomize
	//extern function new(string name = "write_xtn");
	//extern function void do_copy(uvm_object rhs);
	extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	extern function void do_print(uvm_printer printer);
	extern function void post_randomize();

endclass:write_xtn


//-----------------  do_compare method -------------------//

//Add code for do_compare() to compare address, data, write, xtn_type and xtn_delay
function bit  write_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);

	// handle for overriding the variable
    	write_xtn rhs_;
	// Add a check for rhs_ using $cast to check that the object types are 
	// compatible
    	if(!$cast(rhs_, rhs))
	begin
		`uvm_fatal("do_compare","cast of rhs object failed")
		return 0;
	end

	// Compare the data members and return the result of comparision
	// <var_name> == rhs_.<var_name>;
	return
		super.do_compare(rhs,comparer) &&
		this.data == rhs_.data &&
		this.address == rhs_.address &&
		this.write == rhs_.write &&
		this.xtn_type == rhs_.xtn_type &&
		this.xtn_delay == rhs_.xtn_delay;


endfunction:do_compare 

//-----------------  do_print method  -------------------//
//underastand the do_print method implemented below
//Use printer.print_field for integral variables
//Use printer.print_generic for enum variables
function void  write_xtn::do_print (uvm_printer printer);
	super.do_print(printer);

   
    //              	srting name   		bitstream value     size    radix for printing
    printer.print_field( "1da.ta", 		this.data, 	    64,		UVM_DEC		);
    printer.print_field( "2address", 		this.address, 	    12,		UVM_DEC		);
    printer.print_field( "3write", 		this.write, 	    1'b1,	UVM_DEC		);
    printer.print_field( "4xtn_delay", 		this.xtn_delay,     65,		UVM_DEC		);
   
    //  	         variable name	        xtn_type		$bits(variable name) 	        variable name.name
    printer.print_generic( "5xtn_type", 	"addr_t",		$bits(xtn_type),		xtn_type.name);

endfunction:do_print
    
// In post_andomize method assign address to 6000 if xtn_type is BAD_XTN


function void  write_xtn::post_randomize();
	if (xtn_type == BAD_XTN) address = 6000;
endfunction
