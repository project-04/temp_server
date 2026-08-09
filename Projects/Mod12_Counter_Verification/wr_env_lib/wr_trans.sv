class wr_trans extends uvm_sequence_item;
	`uvm_object_utils(wr_trans)
     
     int agent_number;
	rand 	logic up;
	rand	logic reset_n;
	rand 	logic load;
	rand 	logic [3:0] data_in;
	
	//	logic [3:0] data_out;
 
	function new(string name = "wr_trans");
		super.new(name);
	endfunction
	
	constraint CON1 {data_in inside {[0:11]};}
	constraint CON2 {load dist {1:=10, 0:=50};}
	constraint CON3 {up dist {0:=50,1:=50};}
	constraint CON4 {reset_n dist {0:=90,1:=3};}
 
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
   printer.print_field("agent_number",	agent_number,  	$bits(agent_number),	UVM_DEC);
         	printer.print_field("time",	$time,  	$bits($time),	UVM_DEC);
	    	printer.print_field("up",	this.up,  	$bits(up), 	UVM_DEC);
	    	printer.print_field("reset_n",	this.reset_n,  	$bits(reset_n), UVM_DEC);
	    	printer.print_field("load",	this.load, 	$bits(load), 	UVM_DEC);
	    	printer.print_field("data_in", 	this.data_in,  	$bits(data_in),	UVM_DEC);
	    	
	//	printer.print_field("data_out", this.data_out, $bits(data_out),	UVM_DEC);
	endfunction
	
/*	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		wr_trans rhs_;
		if(!$cast(rhs_,rhs))
			begin
				`uvm_error("uvm_comparer", "cast fail in do_compare")
				return 0;
			end
		
		return 
			super.do_compare(rhs, comparer) &&
			this.up 	== rhs_.up  	&&
			this.reset_n 	== rhs_.reset_n	&&
			this.load 	== rhs_.load  	&&
			this.data_in 	== rhs_.data_in &&
			this.data_out 	== rhs_.data_out;
	endfunction
 */
endclass
