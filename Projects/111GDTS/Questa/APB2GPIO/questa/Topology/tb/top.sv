`timescale 1ns/10ps
module top;

import pkg::*;

import uvm_pkg::*;

bit clock;

apb_if apb(clock);
aux_input_if aux(clock);
io_pad_if io_if(clock);

always #10 clock=!clock;


  gpio_core DUV(.PCLK(clock),
		.PADDR(apb.paddr),
		.PWDATA(apb.pwdata),
		.PRESETn(apb.reset),
                .PSEL(apb.psel),
		.PENABLE(apb.penable),
		.PWRITE(apb.pwdata),
		.PREADY(apb.pready),
		.PRDATA(apb.prdata),
		.IRQ(apb.irq),
		.aux_in(aux.aux_in),
		.io_pad(io_if.io_pad));
		


initial
begin

	
	uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",apb);
	uvm_config_db#(virtual aux_input_if)::set(null,"*","aux_input_if",aux);
	uvm_config_db#(virtual io_pad_if)::set(null,"*","io_pad_if",io_if);

	run_test();


end
endmodule
