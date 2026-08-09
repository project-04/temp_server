/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech 
Bangalore - 560076

Webpage: 	www.maven-silicon.com

Filename:	ram_drv.sv   

Description:	Driver class for dual port ram_testbench

Version:	1.0

*********************************************************************************************/


class ram_write_bfm;
// Instantiate virtual interface instance wr_if of type ram_if with WR modport

	virtual ram_if.WR_BFM wr_if;

// Declare a handle for ram_trans as 'data2duv'
	
	ram_trans data2duv;

// Declare a mailboxes 'gen2wr' parameterized by ram_trans		
	mailbox #(ram_trans) gen2wr;	

// In constructor 
	// Pass the following as the input arguments 
	   // virtual interface
	   // mailbox handle parameterized 'gen2wr' ram_trans    
     	   // Make connections
		// For example this.gen2wr=gen2wr
	function new(virtual ram_if.WR_BFM wr_if,
			mailbox #(ram_trans) gen2wr);
		this.wr_if=wr_if;
		this.gen2wr=gen2wr;
	endfunction: new

	virtual task drive();
		@(wr_if.wr_cb);
		wr_if.wr_cb.data_in<=data2duv.data;
		wr_if.wr_cb.wr_address<=data2duv.wr_address;
		wr_if.wr_cb.write<=data2duv.write;
		        
	// Wait for one clock cycle after applying all the inputs
        // if write is high, one cycle will be required to write the data
		repeat(2) @(wr_if.wr_cb);

	 // Disable the write signal
		wr_if.wr_cb.write<='0;
			
	endtask : drive
// In virtual task start
		
	virtual task start();
		// Within fork join_none 
		fork
			forever
			begin
			// Within forever , inside begin end			
			// get the data from mailbox 'gen2wr
			// call drive task
			gen2wr.get(data2duv);
			drive();
			end
		join_none
	endtask: start

endclass: ram_write_bfm
