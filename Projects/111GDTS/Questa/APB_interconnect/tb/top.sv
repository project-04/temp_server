module top;

    	import pkg::*;

	import uvm_pkg::*;

	bit clk;

	always 
	begin
		#10 clk = ~clk;
	end

	apb_if in0(clk);

   apb_interconnect_top DUV(.p_clk(clk),.p_rst(in0.Preset_n),.transfer(in0.transfer),.write(in0.Pwrite),.addr(in0.Paddr),.b_pw_data(in0.Pwdata),.p_ready(in0.pready),.p_slverr(in0.pslverr),.pr_data(in0.Prdata));
 

	initial begin
		uvm_config_db#(virtual apb_if)::set(null,"*","vif",in0);
		run_test();
	end

endmodule

