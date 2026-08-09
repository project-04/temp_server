/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech 
Bangalore - 560076

Webpage: 	www.maven-silicon.com
**********************************************************************************************/
class ram_write_mon;

	//Instantiate virtual interface instance wrmon_if of type ram_if with WR_MON modport
	virtual ram_if.WR_MON wrmon_if;

	//Declare an handle data2rm of class type ram_trans
	ram_trans data2rm;

	//Declare two mailboxes mon2rm parameterized by type ram_trans
	mailbox #(ram_trans) mon2rm;
	
//In construct
		//Pass the following properties as the input arguments 
	
		//pass the virtual interface and the two mailboxes as arguments
	
		//make the connections

	function new(virtual ram_if.WR_MON wrmon_if,
			mailbox #(ram_trans) mon2rm
			);
		this.wrmon_if=wrmon_if;
		this.mon2rm=mon2rm;
		this.data2rm=new;
	endfunction: new


	task monitor();
		@(wrmon_if.wr_mon_cb)
	 	wait(wrmon_if.wr_mon_cb.write==1) 
         	@(wrmon_if.wr_mon_cb);
		begin
			data2rm.write= wrmon_if.wr_mon_cb.write;
			data2rm.wr_address =  wrmon_if.wr_mon_cb.wr_address;
			data2rm.data= wrmon_if.wr_mon_cb.data_in;
			//call the display of the ram_trans to display the monitor data
			data2rm.display("DATA FROM WRITE MONITOR");
		
		end
	endtask
	
	
//In start task
			
	task start();
	//within fork-join_none

			//In forever loop
		fork
		forever
			begin
			//Call the monitor task
				//Understand the provided monitor task. 
				//Monitor task samples the interface signals 
				//according to the protocol and convert to transaction items 
			monitor(); 
			//Put the transaction item into the mailbox mon2rm
			mon2rm.put(data2rm);
			end
		join_none
	endtask: start

endclass:ram_write_mon
