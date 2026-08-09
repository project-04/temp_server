   
module Top;

    	import bridge_pkg::*;

	import uvm_pkg::*;

	bit clk;

	always 
	begin
		#5 clk = 0;
		#5 clk = ~clk;
	end

	bridge_if in0(clk);

	AHBBlockRam DUT (.HCLK(clk),
			.HRESETn(in0.Hresetn),
			.HSEL(in0.Hsel),
			.HTRANS(in0.Htrans),
			.HSIZE(in0.Hsize), 
			.HREADY(in0.Hreadyin),
			.HWDATA(in0.Hwdata),
			.HADDR(in0.Haddr),
			.HWRITE(in0.Hwrite),
			.HRDATA(in0.Hrdata),
			.HRESP(in0.Hresp),
			.HREADYOUT(in0.Hreadyout));

	initial begin
		uvm_config_db#(virtual bridge_if)::set(null,"*","vif",in0);
		run_test();
	end

endmodule


