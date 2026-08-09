package test_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	`include "apb_config.sv"
	`include "aux_config.sv"
	`include "io_config.sv"
	`include "env_config.sv"
	
	`include "apb_xtn.sv"
	`include "aux_xtn.sv"
	`include "io_xtn.sv"
	
	`include "apb_driver.sv"
	`include "apb_monitor.sv"
	`include "apb_sequencer.sv"
	
	`include "aux_driver.sv"
	`include "aux_monitor.sv"
	`include "aux_sequencer.sv"
	
	`include "io_driver.sv"
	`include "io_monitor.sv"
	`include "io_sequencer.sv"
	
	`include "apb_agent.sv"
	`include "aux_agent.sv"
	`include "io_agent.sv"
	
	`include "apb_agent_top.sv"
	`include "aux_agent_top.sv"
	`include "io_agent_top.sv"
	
	`include "scoreboard.sv"
	`include "environment.sv"
	
	`include "test.sv"
	
endpackage
	
