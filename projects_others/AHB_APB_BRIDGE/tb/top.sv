

module top;


	import uvm_pkg::*;
	import test_pkg::*;

	bit clk;

	always #5 clk = ~clk;

	ahb_if ahb_st_f(clk);
	apb_if apb_st_f(clk);

	rtl_top dut (
			.Hclk		(clk),
			.Hresetn	(ahb_st_f.Hresetn),
			.Hsize		(ahb_st_f.Hsize),
			.Hreadyin	(ahb_st_f.Hreadyin),
			.Hwdata		(ahb_st_f.Hwdata),
			.Haddr		(ahb_st_f.Haddr),
			.Hwrite		(ahb_st_f.Hwrite),
			.Prdata		(apb_st_f.Prdata),
			.Hrdata		(ahb_st_f.Hrdata),
			.Hresp		(ahb_st_f.Hresp),
			.Hreadyout	(ahb_st_f.Hreadyout),
			.Pselx		(apb_st_f.Pselx),
			.Pwrite		(apb_st_f.Pwrite),
			.Penable	(apb_st_f.Penable),
			.Paddr		(apb_st_f.Paddr),
			.Pwdata		(apb_st_f.Pwdata)
								);

	initial 
		begin 
			uvm_config_db#(virtual ahb_if)::set(null,"*","ahb_if",ahb_st_f);
			uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",apb_st_f);
			run_test();
		end

endmodule
			

	

