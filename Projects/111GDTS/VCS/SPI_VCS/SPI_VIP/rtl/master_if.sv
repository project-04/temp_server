`timescale 1ns / 10ps


interface master_if(input clock);

logic rst_i;   //reset signal
logic [4:0]adr_i;   //lower address bits
logic [31:0]dat_i;  //Data towards the core
logic [31:0]dat_o;  //Data from the core
logic [3:0]sel_i;   //byte select signals
logic we_i;         //write enable input
logic stb_i;       //strobe signal/core select input
logic cyc_i;       //valid bus cycle input
logic ack_o;       //bus cycle acknowledge output
logic err_o;	   //bus cycle error output
logic int_o;       //interrupt signal output

//DRIVER
clocking cb_drv@(posedge clock);
default input #1 output #2;
output rst_i;
output adr_i;
output dat_i;
output sel_i;
output we_i;
output stb_i;
output cyc_i;

input ack_o;
input err_o;
input int_o;

endclocking

modport DRV(clocking cb_drv);



//MONITOR
clocking cb_mon@(posedge clock);
default input #1 output #2;
input rst_i;
input adr_i;
input dat_i;
input dat_o;//extra
input sel_i;
input we_i;
input stb_i;
input cyc_i;

input ack_o;
input err_o;
input int_o;

endclocking


modport MON(clocking cb_mon);

endinterface
