package test_packages;


	import uvm_pkg::*;
`include "uvm_macros.svh"
`include "axi_xtn.sv"
`include "master_config.sv"
`include "slave_config.sv"
`include "env_config.sv"
`include "master_driver.sv"
`include "master_monitor.sv"
`include "master_seqr.sv"
`include "master_agent.sv"
`include "master_agent_top.sv"
`include "master_seqs.sv"

`include "slave_monitor.sv"
`include "slave_seqr.sv"
`include "slave_seqs.sv"
`include "slave_driver.sv"
`include "slave_agent.sv"
`include "slave_agent_top.sv"

`include "virtual_seqr.sv"
`include "virtual_seq.sv"
`include "scoreboard.sv"

`include "env_tb.sv"


`include "test_vlib.sv"
endpackage
