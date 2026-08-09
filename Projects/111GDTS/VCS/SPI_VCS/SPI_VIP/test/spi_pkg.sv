package spi_pkg;

//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"

//import tb files

	`include "master_xtn.sv"
	`include "slave_xtn.sv"

	`include "master_agent_config.sv"
	`include "slave_agent_config.sv"
	`include "spi_env_config.sv"


	`include "master_driver.sv"
	`include "master_monitor.sv"
	`include "master_sequencer.sv"
	`include "master_agent.sv"
	`include "master_seqs.sv"
	`include "master_read_seqs.sv"

	`include "slave_driver.sv"
	`include "slave_monitor.sv"
	`include "slave_sequencer.sv"
	`include "slave_agent.sv"
	`include "slave_seqs.sv"
	
	`include "spi_scoreboard.sv"
	`include "spi_vseqr.sv"
	`include "spi_vseqs.sv"
	`include "spi_env.sv"

	`include "spi_base_test.sv"

endpackage
	
