module top;

	import uvm_pkg::*;
	
	import test_pkg::*;
	
	bit clk;
	
	always #5 clk = ~clk;
	
	apb_if apb_sf(clk);
	aux_if aux_sf(clk);
	io_if io_sf(clk);
	
	initial
		begin
			uvm_config_db#(virtual apb_if)::set(null,"","apb_if",apb_sf);
			uvm_config_db#(virtual aux_if)::set(null,"","aux_if",aux_sf);
			uvm_config_db#(virtual io_if)::set(null,"","io_if",io_sf);
			run_test();
			
		end
		
endmodule
