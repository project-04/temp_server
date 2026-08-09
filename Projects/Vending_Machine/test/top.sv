module assertions_check(input clock,reset,coin_in,done_out,lsb7seg_out,msb7seg_out);

	property p1;
		@(posedge clock)
		reset |=> done_out == 0;
	endproperty
	
	property p2;
		@(posedge clock) disable iff(reset)
		//@(posedge clock)
		coin_in==2'b00 |=> (done_out == 1'b0 && (lsb7seg_out == 7'b0100100 && msb7seg_out == 7'b0010010));
	endproperty
	
	assert1 : assert property(p1)
		$display("-----------reset pass");
	else 
		$display("-----------reset fail");
	
	assert2 : assert property(p2)
		$display("-----------coin 00 pass");
	else 
		$display("-----------coin 00 fail");

endmodule

module top();
	import uvm_pkg::*;
	`include "uvm_macros.svh"	
	import test_pkg::*;
	
	initial
	    begin
		run_test("test");
            end
  endmodule
