package pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"

`include "apb_cfg.sv"
`include "aux_cfg.sv"
`include "io_cfg.sv"
`include "env_cfg.sv"

//  APB Files
`include "apb_xtn.sv"
`include "apb_seqs.sv"
`include "apb_drv.sv"
`include "apb_seqr.sv"
`include "apb_mon.sv"
`include "apb_agt.sv"
`include "apb_agt_top.sv"

// IO Files
`include "io_xtn.sv"
`include "io_seqs.sv"
`include "io_drv.sv"
`include "io_seqr.sv"
`include "io_mon.sv"
`include "io_agt.sv"
`include "io_agt_top.sv"

// AUX Files
`include "aux_xtn.sv"
`include "aux_seqs.sv"
`include "aux_drv.sv"
`include "aux_seqr.sv"
`include "aux_mon.sv"
`include "aux_agt.sv"
`include "aux_agt_top.sv"

// TB / Test Files
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

endpackage
