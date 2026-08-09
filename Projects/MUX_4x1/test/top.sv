module mux_assertions(input i0, i1, i2, i3, s0, s1, d_out);
	always_comb begin
		a0 :	assert ((s0==0 && s1==0) && d_out == i0)
				$display("---------------i0 pass");
			else
				$display("i0 fail");
		a1 :	assert ((s0==0 && s1==1) && d_out == i1)
				$display("---------------i1 pass");
			else
				$display("i1 fail");
		a2 :	assert ((s0==1 && s1==0) && d_out == i2)
				$display("---------------i2 pass");
			else
				$display("i2 fail");
		a3 :	assert ((s0==1 && s1==1) && d_out == i3)
				$display("---------------i3 pass");
			else
				$display("i3 fail");
	end
endmodule

module top;
  import uvm_pkg::*; 
  `include "uvm_macros.svh"
  
  import counter_test_pkg::*;

 mux_if vif();
	
	mux_4_1 duv(
		vif.i0,
		vif.i1,
		vif.i2,
		vif.i3,
		vif.s0,
		vif.s1,
		vif.d_out
		);
/*	mux_assertions assertions_duv(
		vif.i0,
		vif.i1,
		vif.i2,
		vif.i3,
		vif.s0,
		vif.s1,
		vif.d_out
		);*/
		
	initial begin
		//uvm_top.set_report_verbosity_level(UVM_NONE);
		
		uvm_config_db #(virtual mux_if)::set(null, "*", "mux_if", vif);
		run_test();
		
	end
endmodule
