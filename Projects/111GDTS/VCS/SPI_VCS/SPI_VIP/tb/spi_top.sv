`timescale 1ns / 10ps


module spi_top1;

import spi_pkg::*;

import uvm_pkg::*;

bit clock;

always 
  #10 clock = ~clock;


spi_top  DUV(
  // Wishbone signals
  	clock, in0.rst_i, in0.adr_i, in0.dat_i, in0.dat_o, in0.sel_i,
  in0.we_i, in0.stb_i, in0.cyc_i, in0.ack_o, in0.err_o, in0.int_o,

  // SPI signals
  in1.ss_pad_o, in1.sclk, in1.mosi_pad_o, in1.miso_pad_i
);

//spi_slave  S1(in1.sclk,
  //                 in1.ss_pad_o[0],
    //               in1.mosi_pad_o,
      //             in1.miso_pad_i
        //          );



master_if in0(clock);
slave_if in1(clock);


initial
	begin
	uvm_config_db#(virtual master_if)::set(null,"*","mas_if",in0);
	uvm_config_db#(virtual slave_if)::set(null,"*","sla_if",in1);

	run_test();
	end
endmodule

