/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.


Filename		:	fifo_assertions.sv   

Description		:	FIFO Assertions Module

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "tech_support@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module fifo_assertions (clk,
						rst_n,
						rd_n,
						wr_n,
						over_flow,
						under_flow );

	input logic rst_n,clk,rd_n,wr_n;
	input logic under_flow,over_flow;

	// RESET - On reset overflow and underflow should be zero 
	

	//FIFO OVERFLOW - After reset if only write is enabled continuously for 
	//17 times overflow should go high 
	
	
	
	//FIFO UNDERFLOW - After fifo overflow if only is read is enabled continuously 
	//17 times underflow should go high
	
	
	

	RESET : assert property (reset_prty);
	OVERFLOW:assert property (overflow_prty);
	UNDERFLOW:assert property(underflow_prty)

endmodule
