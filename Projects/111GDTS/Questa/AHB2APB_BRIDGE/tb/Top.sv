   
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
//	bridge_if in1(clk);

	rtl_top DUT (.Hclk(clk),
			.Hresetn(in0.Hresetn),
			.Htrans(in0.Htrans),
			.Hsize(in0.Hsize), 
			.Hreadyin(in0.Hreadyin),
			.Hwdata(in0.Hwdata),
			.Haddr(in0.Haddr),
			.Hwrite(in0.Hwrite),
			.Prdata(in0.Prdata),
			.Hrdata(in0.Hrdata),
			.Hresp(in0.Hresp),
			.Hreadyout(in0.Hreadyout),
			.Pselx(in0.Pselx),
			.Pwrite(in0.Pwrite),
			.Penable(in0.Penable), 
			.Paddr(in0.Paddr),
			.Pwdata(in0.Pwdata));

	initial begin
		uvm_config_db#(virtual bridge_if)::set(null,"*","vif",in0);
		uvm_config_db#(virtual bridge_if)::set(null,"*","vif1",in0);
		run_test();
	end

endmodule


