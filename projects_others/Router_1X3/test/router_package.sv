package router_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Transaction items
    `include "src_write_xtn.sv"
    `include "dest_read_xtn.sv"
	
    // Configurations
    `include "src_agt_config.sv"
    `include "dest_agt_config.sv"
    `include "env_config.sv"
	
    // Components 
    `include "src_seqr.sv"
    `include "dest_seqr.sv"
    `include "v_sequencer.sv"
    
    // Sequences
    `include "src_sequence.sv"
    `include "dest_sequence.sv"
    `include "v_sequence.sv"
    
    // Other components
    `include "src_mon.sv"
    `include "src_drv.sv"
    `include "dest_mon.sv"
    `include "dest_drv.sv"
    
    // Agents
    `include "src_agent.sv"
    `include "dest_agent.sv"
    
    // Environment components
    `include "scoreboard.sv"
    `include "src_agt_top.sv"
    `include "dest_agt_top.sv"
    
    // Top-level env
    `include "router_env.sv"
    
    // Test
    `include "router_test.sv"
endpackage