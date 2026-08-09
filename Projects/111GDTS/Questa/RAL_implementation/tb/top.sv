module top;

	import uvm_pkg::*;
	import avip_pkg::*;

	bit clk;

	intf vif(clk);

	always #5 clk=~clk;

     reg_mem_block DUV(.clk(clk),.rst(vif.rst),.wr_en(vif.wr_en),.rd_en(vif.rd_en),.addr(vif.addr),.data_in(vif.data_in),.data_out(vif.data_out));

	initial begin
                     `ifdef VCS
                     $fsdbDumpvars(0, top);
                      `endif
		uvm_top.enable_print_topology=1;
		uvm_config_db#(virtual intf)::set(null,"*","vif",vif);
		run_test;
	end

endmodule

