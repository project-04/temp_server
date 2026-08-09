
module top;

	import uvm_pkg::*;
	import test_pkg::*;
	
	bit clk;
	
	always #5 clk = ~clk;
	
	fsm_if fsm_sif(clk);
	
	fsm_101_overlapping DUV(
						.clk(clk),
						.rst(fsm_sif.rst),
						.din(fsm_sif.din),
						.dout(fsm_sif.dout)
											);
	
	

	initial 
		begin 
			`ifdef VCS
			$fsdbDumpvars(0,top);
			`endif
			
			uvm_config_db#(virtual fsm_if)::set(null,"*","fsm_if",fsm_sif);
			run_test();
		end
endmodule
