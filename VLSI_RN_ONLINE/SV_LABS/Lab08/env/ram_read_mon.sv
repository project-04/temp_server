/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		   :  ram_read_mon.sv   

Description	   :  Monitor class for dual port ram_testbench

Author Name	   :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version		   :  1.0

Date			   :  02/06/2020

***********************************************************************************************/
//In class ram_read_mon

class ram_read_mon;

   //Instantiate virtual interface instance rd_mon_if of type ram_if with RD_MON_MP modport
   //Declare three handles 'rddata', 'data2rm' and 'data2sb' of class type ram_trans
   //Declare two mailboxes 'mon2rm' and 'mon2sb' parameterized by type ram_trans
	virtual ram_if.RD_MON_MP rd_mon_if;
	ram_trans rddata;
	ram_trans data2rm;
	ram_trans data2sb;
	mailbox #(ram_trans) mon2rm;
	mailbox #(ram_trans) mon2sb;

   //In constructor
   //Pass the following as the input arguments 	
   //virtual interface 
   //mailbox handles 'mon2rm' and 'mon2sb' parameterized by ram_trans	
   //make the connections and allocate memory for 'rddata'
   //make the connections and allocate memory for 'wrdata' 
	function new(virtual ram_if.RD_MON_MP rd_mon_if, mailbox #(ram_trans) mon2rm, mailbox #(ram_trans) mon2sb);
		this.rd_mon_if = rd_mon_if;
		this.mon2rm = mon2rm;
		this.mon2sb = mon2sb;
		rddata = new();
	endfunction

   virtual task monitor();
	   @(rd_mon_if.rd_mon_cb);
	   wait (rd_mon_if.rd_mon_cb.read==1);
      @(rd_mon_if.rd_mon_cb);
	   begin
		   rddata.read       = rd_mon_if.rd_mon_cb.read;
		   rddata.rd_address = rd_mon_if.rd_mon_cb.rd_address;
		   rddata.data_out   = rd_mon_if.rd_mon_cb.data_out;
		   //call the display of the ram_trans to display the monitor data
		   rddata.display("DATA FROM READ MONITOR");
		
      end
   endtask: monitor
	
   //In virtual task start			
   virtual task start();
	   //Within fork-join_none
	   //In forever loop
	   //Call the monitor task
	   //Understand the provided monitor task 
	   //Monitor task samples the interface signals 
	   //according to the protocol and convert to transaction items 		
	   //Shallow copy rddata to data2sb;
	   //Shallow copy rddata to data2rm;		
	   //Put the transaction item into two mailboxes mon2rm and mon2sb	
	   fork
	   	forever
		begin
			monitor();
			data2rm = new rddata;
			data2sb = new rddata;
			mon2rm.put(data2rm);
			mon2sb.put(data2sb);
		end
	   join_none

   endtask: start

endclass:ram_read_mon
