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







/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       aux_interface.v   

module Name             :       aux_interface

Description             :       To provide auxiliary inputs for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
 //auxiliary interface module
 module aux_interface(input clk,rst,
	              input [31:0]aux_in, 
		      output reg [31:0]aux_i);

   always@(posedge clk or posedge rst)
     begin
       if (rst)
         aux_i<=32'b0;
       else
         aux_i<=aux_in;
     end

 endmodule





















/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       gpio_define.v   

module Name             :       gpio_define

Description             :       definition file(`define) for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

 `define GPIO_RGPIO_IN		32'h0	// Address 0x00
 `define GPIO_RGPIO_OUT		32'h1	// Address 0x04
 `define GPIO_RGPIO_OE	        32'h2	// Address 0x08
 `define GPIO_RGPIO_INTE	32'h3	// Address 0x0c
 `define GPIO_RGPIO_PTRIG	32'h4	// Address 0x10

 `define GPIO_RGPIO_AUX		32'h5	// Address 0x14

 `define GPIO_RGPIO_CTRL	32'h6	// Address 0x18
 `define GPIO_RGPIO_INTS	32'h7	// Address 0x1c

 `define GPIO_RGPIO_ECLK        32'h8  // Address 0x20
 `define GPIO_RGPIO_NEC         32'h9  // Address 0x24

 `define GPIO_RGPIO_CTRL_INTE		0
 `define GPIO_RGPIO_CTRL_INTS		1















 
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










/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       io_interface.v   

module Name             :       io_interface

Description             :       To configure input and output for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

 //input_output_pad interface module
 module io_interface(input [31:0]out_pad_o,oen_padoe_o,
               	     output [31:0]in_pad_i,
	             inout [31:0]io_pad);
	     
   assign in_pad_i=io_pad;
   assign io_pad[0]=oen_padoe_o[0]?out_pad_o[0]:1'bz;
   assign io_pad[1]=oen_padoe_o[1]?out_pad_o[1]:1'bz;
   assign io_pad[2]=oen_padoe_o[2]?out_pad_o[2]:1'bz;
   assign io_pad[3]=oen_padoe_o[3]?out_pad_o[3]:1'bz;
   assign io_pad[4]=oen_padoe_o[4]?out_pad_o[4]:1'bz;
   assign io_pad[5]=oen_padoe_o[5]?out_pad_o[5]:1'bz;
   assign io_pad[6]=oen_padoe_o[6]?out_pad_o[6]:1'bz;
   assign io_pad[7]=oen_padoe_o[7]?out_pad_o[7]:1'bz;
   assign io_pad[8]=oen_padoe_o[8]?out_pad_o[8]:1'bz; 
   assign io_pad[9]=oen_padoe_o[9]?out_pad_o[9]:1'bz;
   assign io_pad[10]=oen_padoe_o[10]?out_pad_o[10]:1'bz;
   assign io_pad[11]=oen_padoe_o[11]?out_pad_o[11]:1'bz;
   assign io_pad[12]=oen_padoe_o[12]?out_pad_o[12]:1'bz;
   assign io_pad[13]=oen_padoe_o[13]?out_pad_o[13]:1'bz;
   assign io_pad[14]=oen_padoe_o[14]?out_pad_o[14]:1'bz; 
   assign io_pad[15]=oen_padoe_o[15]?out_pad_o[15]:1'bz;
   assign io_pad[16]=oen_padoe_o[16]?out_pad_o[16]:1'bz;
   assign io_pad[17]=oen_padoe_o[17]?out_pad_o[17]:1'bz;
   assign io_pad[18]=oen_padoe_o[18]?out_pad_o[18]:1'bz;
   assign io_pad[19]=oen_padoe_o[19]?out_pad_o[19]:1'bz;
   assign io_pad[20]=oen_padoe_o[20]?out_pad_o[20]:1'bz;
   assign io_pad[21]=oen_padoe_o[21]?out_pad_o[21]:1'bz;
   assign io_pad[22]=oen_padoe_o[22]?out_pad_o[22]:1'bz;
   assign io_pad[23]=oen_padoe_o[23]?out_pad_o[23]:1'bz;
   assign io_pad[24]=oen_padoe_o[24]?out_pad_o[24]:1'bz;
   assign io_pad[25]=oen_padoe_o[25]?out_pad_o[25]:1'bz;
   assign io_pad[26]=oen_padoe_o[26]?out_pad_o[26]:1'bz;
   assign io_pad[27]=oen_padoe_o[27]?out_pad_o[27]:1'bz;
   assign io_pad[28]=oen_padoe_o[28]?out_pad_o[28]:1'bz;
   assign io_pad[29]=oen_padoe_o[29]?out_pad_o[29]:1'bz;
   assign io_pad[30]=oen_padoe_o[30]?out_pad_o[30]:1'bz;
   assign io_pad[31]=oen_padoe_o[31]?out_pad_o[31]:1'bz;

 endmodule


 



/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       gpio_core.v   

module Name             :       gpio_core

Description             :       gpio core(i.e top module) for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
 //gpio core top module
 module gpio_core(input  PCLK,PRESETn,
                  output [31:0]PRDATA,
                  input  [31:0] PADDR,PWDATA,
                  input PSEL,PENABLE,PWRITE,
                  input [31:0]aux_in,
                  output IRQ,PREADY,
                  inout [31:0]io_pad,
                  input ext_clk_pad_i);

    wire [31:0]in_pad_i;
    wire gpio_we;
    wire [31:0]gpio_adr;
    wire [31:0] gpio_dat_i;
    wire [31:0]gpio_dat_o;
    wire [31:0]out_pad_o,oen_padoe_o;
    wire gpio_inta_o;
    wire sys_clk,sys_rst;
    wire [31:0]aux_i;

    apb_slave_interface APB_INTERFACE(.PADDR(PADDR),.PWDATA(PWDATA),.PRESETn(PRESETn),
                                      .PSEL(PSEL),.PENABLE(PENABLE),.PWRITE(PWRITE),.PREADY(PREADY),
                                      .PRDATA(PRDATA),.IRQ(IRQ),.gpio_inta_o(gpio_inta_o),.gpio_we(gpio_we),.gpio_adr(gpio_adr),
                                      .gpio_dat_i(gpio_dat_i),.gpio_dat_o(gpio_dat_o),
                                      .PCLK(PCLK),.sys_clk(sys_clk),.sys_rst(sys_rst));

    aux_interface AUX_INTERFACE(.clk(sys_clk),.rst(sys_rst),.aux_in(aux_in), .aux_i(aux_i));

    gpio_register GPIO_REGISTER(.sys_clk(sys_clk),.sys_rst(sys_rst),.gpio_adr(gpio_adr),.gpio_we(gpio_we),
                                .gpio_dat_i(gpio_dat_i),.gpio_dat_o(gpio_dat_o),.in_pad_i(in_pad_i),
                                .out_pad_o(out_pad_o),.gpio_inta_o(gpio_inta_o),
                                .oen_padoe_o(oen_padoe_o),.gpio_eclk(ext_clk_pad_i),.aux_i(aux_i));


    io_interface IO_INTERFACE(.in_pad_i(in_pad_i),.out_pad_o(out_pad_o),.oen_padoe_o(oen_padoe_o),.io_pad(io_pad));

 endmodule
                                      
