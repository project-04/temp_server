`timescale 1ns / 10ps


interface slave_if(input clock);

logic [7:0]ss_pad_o;		//slave select output
logic mosi_pad_o;
logic miso_pad_i; 
logic sclk;

//DRIVER

clocking cb_drv@(posedge clock);
default input#1 output #2;
output miso_pad_i;
input ss_pad_o;
input sclk;
endclocking

modport DRV(clocking cb_drv);



clocking cb_mon@(posedge clock);

default input#1 output #2;

input mosi_pad_o;
input miso_pad_i;
input ss_pad_o;
input sclk;

endclocking

modport MON(clocking cb_mon);

endinterface
