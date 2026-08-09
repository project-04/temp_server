

package test_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "rd_agent_config.sv"
	`include "wr_agent_config.sv"
	`include "env_config.sv"
	`include "trans.sv"
	
	`include "rd_sequence.sv"
	`include "wr_sequence.sv"
	
	`include "wr_sequencer.sv"
	`include "rd_sequencer.sv"
	
	`include "wr_driver.sv"
	`include "rd_driver.sv"
	
	`include "wr_monitor.sv"
	`include "rd_monitor.sv"
	
	`include "wr_agent.sv"
	`include "rd_agent.sv"
	
	`include "wr_agent_top.sv"
	`include "rd_agent_top.sv"
	
	`include "scorebaord.sv"
	`include "environment.sv"
	`include "test.sv"

endpackage
	
