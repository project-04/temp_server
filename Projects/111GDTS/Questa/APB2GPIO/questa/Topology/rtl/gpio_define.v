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


