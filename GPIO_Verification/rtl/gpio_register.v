 
/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       gpio_register.v   

module Name             :       gpio_register

Description             :       To configure the registers for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

 //gpio register module
 // `include "gpio_defines.v"
 module gpio_register(sys_clk,sys_rst,gpio_adr,gpio_we,gpio_dat_i,gpio_dat_o,
             	      gpio_inta_o,in_pad_i, out_pad_o, oen_padoe_o,gpio_eclk,aux_i);

   input sys_clk,sys_rst,gpio_we;
   input [31:0]gpio_adr;
   input [31:0] gpio_dat_i;
   output reg[31:0]gpio_dat_o;
   output gpio_inta_o;
   input [31:0]  aux_i;		// Auxiliary inputs
   input [31:0]  in_pad_i;	// GPIO Inputs
   input   gpio_eclk;	// GPIO Eclk
   output  [31:0]  out_pad_o;	// GPIO Outputs
   output  [31:0]  oen_padoe_o;	// GPIO output drivers enables


   reg	[31:0]	rgpio_in;	// RGPIO_IN register
   reg	[31:0]	rgpio_out;	// RGPIO_OUT register
   reg	[31:0]	rgpio_oe;	// RGPIO_OE register
   reg	[31:0]	rgpio_inte;	// RGPIO_INTE register
   reg	[31:0]	rgpio_ptrig;	// RGPIO_PTRIG register
   reg	[31:0]	rgpio_aux;	// RGPIO_AUX register
   reg	[1:0]	rgpio_ctrl;	// RGPIO_CTRL register
   reg	[31:0]	rgpio_ints;	// RGPIO_INTS register
   reg	[31:0]	rgpio_eclk;	// RGPIO_ECLK register
   // GPIO Active Negative Edge  Register 
   reg	[31:0]	rgpio_nec;	// RGPIO_NEC register
   reg	[31:0] dat_reg;


   wire  [31:0]  extc_in;  // Muxed inputs sampled by external clock
   reg   [31:0]  pextc_sampled;  // Posedge external clock sampled inputs
   reg   [31:0]  nextc_sampled;  // Negedge external clock sampled inputs


   // Write to RGPIO_CTRL or update of RGPIO_CTRL[INT] bit
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_ctrl <=  2'b0;
     else if ((gpio_adr == `GPIO_RGPIO_CTRL) && gpio_we)
       rgpio_ctrl <= gpio_dat_i[1:0];
     else if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE])
       rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] <= rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o;

   // Write to RGPIO_OUT
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_out <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_OUT) && gpio_we)
       rgpio_out <=  gpio_dat_i[31:0];
     else
       rgpio_out <= rgpio_out;	

   // Write to RGPIO_OE.
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_oe <= 32'b0;
     else if ((gpio_adr ==  `GPIO_RGPIO_OE) && gpio_we)
       rgpio_oe <= gpio_dat_i[31:0];

   // Write to RGPIO_INTE
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_inte <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_INTE) && gpio_we)
       rgpio_inte <= gpio_dat_i[31:0];

   // Write to RGPIO_PTRIG
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_ptrig <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_PTRIG) && gpio_we)
       rgpio_ptrig <= gpio_dat_i[31:0];


   // Write to RGPIO_AUX
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_aux <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_AUX) && gpio_we)
       rgpio_aux <= gpio_dat_i[31:0];


   // Write to RGPIO_ECLK
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_eclk <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_ECLK) && gpio_we)
       rgpio_eclk <= gpio_dat_i[31:0];


   // Write to RGPIO_NEC
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_nec <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_NEC) && gpio_we)
       rgpio_nec <= gpio_dat_i[31:0];

   // Latch into RGPIO_IN
   wire [31:0]in_muxed;

   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_in <= 32'b0;
     else
       rgpio_in <= in_muxed;
		
		
   assign in_muxed = (rgpio_eclk & extc_in) | (~rgpio_eclk & in_pad_i) ;

   assign extc_in = (~rgpio_nec & pextc_sampled) | (rgpio_nec & nextc_sampled) ;

   always @(posedge gpio_eclk or posedge sys_rst)
     if (sys_rst)
       begin
         pextc_sampled <= 32'b0;
       end
     else 
       begin
         pextc_sampled <= in_pad_i ;
       end
  
   always @(negedge gpio_eclk or posedge sys_rst)
     if (sys_rst) 
       begin
         nextc_sampled <= 32'b0;
       end 
   else 
       begin
         nextc_sampled <=in_pad_i ;
       end
  
   // Mux all registers when doing a read of GPIO registers

   always @(*)
      case (gpio_adr)	
           `GPIO_RGPIO_IN:begin
			    dat_reg = rgpio_in;
	                  end
           `GPIO_RGPIO_OUT:begin
			     dat_reg = rgpio_out;
	                   end
           `GPIO_RGPIO_OE:begin
			   dat_reg = rgpio_oe;
		         end
           `GPIO_RGPIO_INTE:begin
			      dat_reg = rgpio_inte;
		            end
           `GPIO_RGPIO_PTRIG:begin
		               dat_reg = rgpio_ptrig;
	         	     end
       	   `GPIO_RGPIO_NEC:begin
			     dat_reg = rgpio_nec;
		           end
	   `GPIO_RGPIO_ECLK:begin
			      dat_reg = rgpio_eclk;
	                    end
           `GPIO_RGPIO_AUX:begin
			     dat_reg = rgpio_aux;
		           end
           `GPIO_RGPIO_CTRL:begin
			      dat_reg[1:0] = rgpio_ctrl;
			      dat_reg[31:2] = 30'b0;
		            end
           `GPIO_RGPIO_INTS:begin
			      dat_reg = rgpio_ints;
		            end
		    default:begin
			      dat_reg = rgpio_in;
		            end
      endcase

   // data output
   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       gpio_dat_o <= 32'b0;
     else
       gpio_dat_o <=  dat_reg;


   // RGPIO_INTS read only register

   always @(posedge sys_clk or posedge sys_rst)
     if (sys_rst)
       rgpio_ints <= 32'b0;
     else if ((gpio_adr == `GPIO_RGPIO_INTS) && gpio_we)
       rgpio_ints <= gpio_dat_i;
     else if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE])
       rgpio_ints <= (rgpio_ints | ((in_muxed ^ rgpio_in) & ~(in_muxed ^ rgpio_ptrig)) & rgpio_inte);


   // Generate interrupt request
   assign gpio_inta_o = |rgpio_ints ? rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] : 1'b0;
   // Output enables are RGPIO_OE bits
   assign oen_padoe_o = rgpio_oe;
   // Generate GPIO outputs
   assign out_pad_o = rgpio_out & ~rgpio_aux | aux_i & rgpio_aux;

 endmodule

