module top;

	import uvm_pkg::*;
	import avip_pkg::*;

	bit clk;

	av_if vif(clk);
//	av_if vifs(clk);

	always #5 clk=~clk;

	initial begin
                     `ifdef VCS
                     $fsdbDumpvars(0, top);
                      `endif
		uvm_top.enable_print_topology=1;
		uvm_config_db#(virtual av_if)::set(null,"*","vif",vif);
	//	uvm_config_db#(virtual av_if)::set(null,"*","vifs",vifs);
		run_test;
	end

endmodule

