

package test_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "apb_config.sv"
	`include "uart_config.sv"
	`include "env_config.sv"

	`include "apb_trans.sv"
	`include "uart_trans.sv"

	`include "apb_sequence.sv"
	`include "uart_sequence.sv"

	`include "apb_sequencer.sv"
	`include "uart_sequencer.sv"

	`include "apb_driver.sv"
	`include "uart_driver.sv"

	`include "apb_monitor.sv"
	`include "uart_monitor.sv"

	`include "apb_agent.sv"
	`include "uart_agent.sv"

	`include "apb_agent_top.sv"
	`include "uart_agent_top.sv"
	`include "scoreboard.sv"
					
	`include "environment.sv"
	`include "test.sv"

endpackage			






