module top;

	import uvm_pkg::*;
	import avip_pkg::*;

	bit clk;

	av_if vif(clk);
	av_if vif0(clk);
	av_if vif1(clk);
	av_if vif2(clk);

	always #5 clk=~clk;

	initial begin
                     `ifdef VCS
                     $fsdbDumpvars(0, top);
                      `endif
		uvm_top.enable_print_topology=1;
		uvm_config_db#(virtual av_if)::set(null,"*","vif",vif);
		uvm_config_db#(virtual av_if)::set(null,"*","vif0",vif0);
		uvm_config_db#(virtual av_if)::set(null,"*","vif1",vif1);
		uvm_config_db#(virtual av_if)::set(null,"*","vif2",vif2);
		run_test;
	end

endmodule

