/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_trans.sv   

Description    :  Transaction class for Dual Port Ram Testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/

// In class ram_trans
class ram_trans;
   
   // Declare the following rand fields
   // data (bit/logic type , size 64)
   // rd_address, wr_address (bit/logic type , size 12)
   // read, write (bit/logic type , size 1)
	rand bit[63:0] data;
	rand bit[11:0] rd_address, wr_address;
	rand bit read, write;

   // Declare a variable data_out (logic type , size 64)
	logic [63:0] data_out;

   // Declare a static variable trans_id (int type), to keep the count of transactions generated
   // Declare three static variables no_of_read_trans, no_of_write_trans, no_of_RW_trans (int type)
	static int trans_id, no_of_read_trans, no_of_write_trans, no_of_RW_trans;
	
	static bit [11:0] temp_addr;

   // Add the following constraints 
   // wr_address!=rd_address;
   // read,write != 2'b00;
   // data between 1 and 4294   
	constraint c1{wr_address != rd_address;}
	constraint c2{{read,write} != 2'b00;}
	constraint c3{data inside {[1:4294]};}

	constraint c4{wr_address inside {[1:5]};}
	constraint c5{rd_address inside {[1:5]};}
   
   //In virtual function display 
   // display the string         
   // display all the properties of the transaction class
	virtual function void display(string str);
				
		$display("%s",str);
		//$display("trans_id=%d, no_of_read_trans=%d, no_of_write_trans=%d, no_of_RW_trans=%d", trans_id, no_of_read_trans, no_of_write_trans, no_of_RW_trans);
		//$display("data=%d, rd_address=%d, wr_address=%d, read=%d, write=%d, data_out=%d\n", data, rd_address, wr_address, read, write, data_out);
		$display("read=%d | write=%d\nread_address=%d | write_address=%d\ndata=%d | data_out=%d \n----------------------------------------------\n",read, write, rd_address, wr_address, data, data_out);
	endfunction

   // In post_randomize method
      // Increment trans_id 
      // If it is only read transaction, increment no_of_read_trans
      // If it is only write transaction, increment no_of_write_trans
      // If it is read-write transaction, increment no_of_RW_trans
      // call the display method and pass a string

	function void post_randomize;
	if(trans_id < 16)              begin write = 1'b1; read = 1'b0; wr_address = temp_addr; rd_address = 12'd0; temp_addr = temp_addr+1'b1; end
	else begin temp_addr = temp_addr-1'b1; write = 1'b0; read = 1'b1; rd_address = temp_addr; wr_address = 12'd0; end

		trans_id++;
		if(read) no_of_read_trans++;
		if(write) no_of_write_trans++;
		if(read && write) no_of_RW_trans++;
		display("Transaction Completed");
      	endfunction
endclass
