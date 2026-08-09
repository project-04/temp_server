/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_class_defn.sv   

Description		:	Example for handles and objects

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/



module test_class_defn;


	// Declare class account_c
	class account_c;

		// Within class account_c
		
		// Declare variable balance as int type
		int balance;

		// Write a function summary that returns balance from it
		function int summary();
			return balance;
		endfunction

		// Write a task deposit with pay (type int) as the input argument and add pay with the balance
		task deposit(input int pay);
			balance = balance + pay;
		endtask

	endclass

	// Declare a handle for class account_c
	account_c account1;

	// Within initial block
	initial begin
		// Create an instance of the class account_c
		account1 = new();
	
		// Call method deposit and pass pay value as the input argument and call method summary to display balance
		account1.deposit(2**20);
		$display("\nBalance is %d\n", account1.summary());
	end
endmodule



