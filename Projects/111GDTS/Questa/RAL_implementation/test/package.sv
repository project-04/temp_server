package avip_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "transaction.sv"
	`include "ral_reg.sv"
	`include "ral_mem.sv"
	`include "adapter.sv"     
	`include "reg_block.sv"

	`include "master_config.sv"
	`include "slave_config.sv"
	`include "env_config.sv"
	`include "slave_seqs.sv"
	`include "slave_seqr.sv"
	`include "slave_monitor.sv"
	`include "slave_driver.sv"
	`include "slave_agent.sv"


	
	`include "master_seqs.sv"
	`include "master_seqr.sv"
	`include "master_monitor.sv"
	`include "master_driver.sv"
	`include "master_agent.sv"
	`include "scoreboard.sv"
	`include "tb.sv"

	`include "test.sv"

endpackage

