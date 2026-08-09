package axi_test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "axi_xtn.sv"
    `include "master_config.sv"
    `include "slave_config.sv"
    `include "axi_env_config.sv"
    `include "master_driver.sv"
    `include "master_monitor.sv"
    `include "master_sequencer.sv"
    `include "master_agent.sv"
    `include "master_agent_top.sv"
    `include "master_seqs.sv"

    `include "slave_driver.sv"
    `include "slave_monitor.sv"
    `include "slave_sequencer.sv"
    `include "slave_agent.sv"
    `include "slave_agent_top.sv"
   `include "slave_seqs.sv"

    `include "axi_virtual_sequencer.sv"
    `include "axi_virtual_seqs.sv"
    `include "axi_scoreboard.sv"
    `include "axi_tb.sv"

    `include "axi_vtest_lib.sv"

endpackage

