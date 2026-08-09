/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       apb_slave_interface.v   

module Name             :       apb_slave_interface

Description             :       apb_slave_interface(to provide addr and data for gpio registers) for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

 //APB SLAVE INTERFACE module 
 module apb_slave_interface(input  [31:0] PADDR,PWDATA,
	                    input PCLK,PSEL,PENABLE,PWRITE,PRESETn,
	                    output reg[31:0]PRDATA,
	                    output  PREADY,
	                    input gpio_inta_o,
	                    output IRQ,output reg gpio_we,
	                    output  [31:0]  gpio_adr,
	                    output reg [31:0] gpio_dat_i,
	                    input [31:0]gpio_dat_o,
                            output sys_clk,
	                    output sys_rst);

  parameter IDLE=2'b00,
	     SETUP=2'b01,
	     ENABLE=2'b10;

  reg[1:0]STATE,NEXT_STATE;
 
  always@(posedge PCLK or posedge PRESETn)
    begin
      if(PRESETn)
        STATE <= IDLE;
      else
	STATE<=NEXT_STATE;
    end

  always@(*)
    begin
      case(STATE)
        IDLE:begin
               if(PSEL && !PENABLE)
                 NEXT_STATE = SETUP;
               else
                 NEXT_STATE = IDLE;
             end
 
         SETUP:begin
                 if(PSEL && PENABLE)
                   NEXT_STATE= ENABLE;
                 else if(PSEL && !PENABLE)
                   NEXT_STATE= SETUP;
                 else
                   NEXT_STATE= IDLE;
               end

         ENABLE:begin
                  if(PSEL)
                    NEXT_STATE = SETUP;
                  else 
                    NEXT_STATE = IDLE;
                end

                default: NEXT_STATE = IDLE;
        endcase
     end

  assign PREADY=(STATE==ENABLE)||(STATE==IDLE && PRESETn)?1'b1:1'b0;

  always@(*)
    begin
      gpio_dat_i=32'b0;
      gpio_we=1'b0;
      PRDATA=32'b0;

      if(PWRITE && STATE==ENABLE )
        begin
          gpio_dat_i=PWDATA;
	  gpio_we=1'b1;
        end
      else if(!PWRITE && STATE ==ENABLE)
	begin
          PRDATA=gpio_dat_o;
          gpio_we=1'b0;
        end
    end

  assign IRQ=gpio_inta_o;
  assign sys_clk=PCLK;
  assign sys_rst=PRESETn;
  assign gpio_adr= PADDR;
	     
 endmodule



