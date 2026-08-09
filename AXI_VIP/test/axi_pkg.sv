package axi_pkg;
	import uvm_pkg::*;
	
	int verified_xtns, total_no_of_xtns;
	
	`include "uvm_macros.svh"

	`include "axi_xtn.sv"

	`include "master_config.sv"
	`include "slave_config.sv"
	`include "env_config.sv"

	`include "master_driver.sv"
	`include "master_monitor.sv"
	`include "master_sequencer.sv"
	`include "master_agent.sv"
	`include "master_agent_top.sv"
	`include "master_sequence.sv"

	`include "slave_driver.sv"
	`include "slave_monitor.sv"
	`include "slave_sequencer.sv"
	`include "slave_agent.sv"
	`include "slave_agent_top.sv"

	`include "sb.sv"

	`include "env.sv"

	`include "test.sv"
endpackage
