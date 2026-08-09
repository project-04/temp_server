package counter_test_pkg;

	import uvm_pkg::*;

	`include "uvm_macros.svh"
	
	`include "env_config.sv"
/*	`include "wr_agent_config.sv"
	`include "wr_trans.sv"
	`include "wr_monitor.sv"
	`include "wr_sequencer.sv"
	`include "wr_seqs.sv"
	`include "wr_driver.sv"
	`include "wr_agent.sv"
 */
 
 	`include "wr_agent_top.sv"
   	`include "rd_agent_top.sv"

	`include "virtual_sequencer.sv"
	`include "virtual_seqs.sv"
	`include "scoreboard.sv"
	
	`include "env.sv"

	`include "test.sv"
endpackage
