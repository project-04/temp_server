package uart_test_pkg;

	import uvm_pkg::*;

	`include "uvm_macros.svh"
	
	`include "apb_agent_config.sv"
	`include "env_config.sv"
	`include "trans.sv"
	`include "monitor.sv"
	`include "sequencer.sv"
	`include "driver.sv"
	`include "apb_agent.sv"
	
	`include "seqs.sv"
	`include "more_seqs.sv"
	
	`include "virtual_sequencer.sv"
	`include "virtual_seqs.sv"
	`include "scoreboard.sv"
	
	`include "env.sv"

	`include "test.sv"
endpackage
