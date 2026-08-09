/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech 
Bangalore - 560076

Webpage: 	www.maven-silicon.com

Filename:	ram_pkg.sv   

Description:	Package for dual port ram_testbench

Version:	1.0

*********************************************************************************************/
package ram_pkg;

   int number_of_transactions=1;

	`include "ram_trans.sv"
	`include "ram_gen.sv"
	`include "ram_write_bfm.sv"
	`include "ram_read_bfm.sv"
	`include "ram_write_mon.sv"
	`include "ram_read_mon.sv"
	`include "ram_model.sv"
	`include "ram_sb.sv"
	`include "ram_env.sv"


endpackage
