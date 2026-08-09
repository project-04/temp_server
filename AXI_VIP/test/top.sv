module top;
	import uvm_pkg::*;
	import axi_pkg::*;
		
	bit ACLK;
	always #10 ACLK = ~ACLK;

	axi_if in0(ACLK);

	initial
	      begin
		  `ifdef VCS
		  $fsdbDumpvars(0,top);
		  `endif
		  
		  uvm_config_db #(virtual axi_if)::set(null,"*","axi_if",in0);

		  //uvm_top.set_report_verbosity_level(UVM_NONE);
		  run_test("base_test");
	      end

endmodule

