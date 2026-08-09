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


class ram_read_bfm;
// Instantiate virtual interface instance rd_if of type ram_if with RD modport

	virtual ram_if.RD_BFM rd_if;

// Declare a handle for ram_trans as 'data2duv'
	
	ram_trans data2duv;

// Declare a mailboxes 'gen2rd' parameterized by ram_trans		
	mailbox #(ram_trans) gen2rd;	

// In constructor 
	// Pass the following as the input arguments 
	   // virtual interface
	   // mailbox handle parameterized 'gen2rd' ram_trans    
     	   // Make connections
		// For example this.gen2rd=gen2rd
	function new(virtual ram_if.RD_BFM rd_if,
			mailbox #(ram_trans) gen2rd);
		this.rd_if=rd_if;
		this.gen2rd=gen2rd;
	endfunction: new

	virtual task drive();
		@(rd_if.rd_cb);
		rd_if.rd_cb.rd_address<=data2duv.rd_address;
		rd_if.rd_cb.read<=data2duv.read;	 
        
	// Wait for one clock cycle after applying all the inputs
        // if write is high, one cycle will be required to write the data
		repeat(2) @(rd_if.rd_cb);

	 // Disable the write andread signal
		rd_if.rd_cb.read<='0;
	
	endtask : drive
// In virtual task start
		
	virtual task start();
		// Within fork join_none 
		fork
			forever
			begin
			// Within forever , inside begin end			
			// get the data from mailbox 'gen2rd
			// call drive task
			gen2rd.get(data2duv);
			drive();
			end
		join_none
	endtask: start

endclass: ram_read_bfm
