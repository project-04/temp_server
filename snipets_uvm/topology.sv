module topology;
	
	`include "uvm_macros.svh"
	import uvm_pkg::*;
		
	class agt_config extends uvm_object;
		`uvm_object_utils(agt_config)
		
		uvm_active_passive_enum is_active;
		
		function new(string name="agt_config");
			super.new(name);
		endfunction
	endclass
	
	class xtn extends uvm_sequence_item;
		`uvm_object_utils(xtn)
		
		function new(string name="xtn");
			super.new(name);
		endfunction
	endclass
	
	class drv extends uvm_driver #(xtn);
		`uvm_component_utils(drv)
		
		function new(string name="drv", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class mon extends uvm_monitor;
		`uvm_component_utils(mon)
		
		function new(string name="mon", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class seqr extends uvm_sequencer #(xtn);
		`uvm_component_utils(seqr)
		
		function new(string name="seqr", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class seq extends uvm_sequence #(xtn);
		`uvm_object_utils(seq)
		
		function new(string name="seq");
			super.new(name);
		endfunction
	endclass
	
	class agt extends uvm_agent;
		`uvm_component_utils(agt)
		
		drv  drvh;
		mon  monh;
		seqr seqrh;
		agt_config agt_configh;
		
		function new(string name="agt", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(agt_config)::get(this, "", "agt_config", agt_configh))
				`uvm_fatal("agt", "can't get agt_config")
			
			monh = mon::type_id::create("monh", this);
			if(agt_configh.is_active == UVM_ACTIVE)
			begin
				drvh = drv::type_id::create("drvh", this);
				seqrh = seqr::type_id::create("seqh", this);
			end
		endfunction
		
		function void connect_phase(uvm_phase phase);
		if(agt_configh.is_active == UVM_ACTIVE)
		begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
		end
	
		endfunction
	endclass
	
	class env extends uvm_env;
		`uvm_component_utils(env)
		
		agt agt_1;
		agt agt_2;
		
		function new(string name="env", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			agt_1 = agt::type_id::create("agt_1", this);
			agt_2 = agt::type_id::create("agt_2", this);
		endfunction
	endclass
	
	class test extends uvm_test;
		`uvm_component_utils(test)
		
		env envh;
		agt_config agt_1_configh;
		agt_config agt_2_configh;
		
		function new(string name="test", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agt_1_configh = agt_config::type_id::create("agt_1_configh");
			agt_2_configh = agt_config::type_id::create("agt_1_configh");
			
			agt_1_configh.is_active = UVM_ACTIVE;
			agt_2_configh.is_active = UVM_PASSIVE; 
			
			uvm_config_db #(agt_config)::set(this, "*.agt_1", "agt_config", agt_1_configh);
			uvm_config_db #(agt_config)::set(this, "*.agt_2", "agt_config", agt_2_configh);
			
			envh = env::type_id::create("envh", this);
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			
			uvm_top.print_topology();
		endfunction
	endclass
	
	initial begin
		//qverilog topology.sv
		//vcs -sverilog -ntb_opts uvm topology.sv;	./smiv
		run_test("test");
	end
endmodule

/*
Start time: 09:34:54 on Jun 29,2026
qverilog ../topology.sv 
-- Compiling module topology
** Note: (qverilog-2286) ../topology.sv(3): Using implicit +incdir+/home/cad/eda/Mentor_Graphics/Questasim/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src from import uvm_pkg
-- Importing package mtiUvm.uvm_pkg (uvm-1.1d Built-in)

Top level modules:
	topology
# vsim -lib work work.topology -c -do "run -all; quit -f" -appendlog -l qverilog.log -vopt 
# ** Note: (vsim-3812) Design is being optimized...
# //  Questa Sim-64
# //  Version 2022.1_2 linux_x86_64 Apr  2 2022
# //
# //  Copyright 1991-2022 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  QuestaSim and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# Loading sv_std.std
# Loading mtiUvm.uvm_pkg(fast)
# Loading mtiUvm.questa_uvm_pkg(fast)
# Loading work.topology(fast)
# Loading /home/cad/eda/Mentor_Graphics/Questasim/questasim/uvm-1.1d/linux_x86_64/uvm_dpi.so
# run -all
# ----------------------------------------------------------------
# UVM-1.1d
# (C) 2007-2013 Mentor Graphics Corporation
# (C) 2007-2013 Cadence Design Systems, Inc.
# (C) 2006-2013 Synopsys, Inc.
# (C) 2011-2013 Cypress Semiconductor Corp.
# ----------------------------------------------------------------
# 
#   ***********       IMPORTANT RELEASE NOTES         ************
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_NO_DEPRECATED undefined.
#   See http://www.eda.org/svdb/view.php?id=3313 for more details.
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_OBJECT_MUST_HAVE_CONSTRUCTOR undefined.
#   See http://www.eda.org/svdb/view.php?id=3770 for more details.
# 
#       (Specify +UVM_NO_RELNOTES to turn off this notice)
# 
# UVM_INFO verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(277) @ 0: reporter [Questa UVM] QUESTA_UVM-1.2.3
# UVM_INFO verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(278) @ 0: reporter [Questa UVM]  questa_uvm::init(+struct)
# UVM_INFO @ 0: reporter [RNTST] Running test test...
# UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
# --------------------------------------------------------------
# Name                       Type                    Size  Value
# --------------------------------------------------------------
# uvm_test_top               test                    -     @467 
#   envh                     env                     -     @481 
#     agt_1                  agt                     -     @488 
#       drvh                 drv                     -     @511 
#         rsp_port           uvm_analysis_port       -     @526 
#         seq_item_port      uvm_seq_item_pull_port  -     @518 
#       monh                 mon                     -     @504 
#       seqh                 seqr                    -     @534 
#         rsp_export         uvm_analysis_export     -     @541 
#         seq_item_export    uvm_seq_item_pull_imp   -     @635 
#         arbitration_queue  array                   0     -    
#         lock_queue         array                   0     -    
#         num_last_reqs      integral                32    'd1  
#         num_last_rsps      integral                32    'd1  
#     agt_2                  agt                     -     @495 
#       monh                 mon                     -     @650 
# --------------------------------------------------------------
# 
# 
# --- UVM Report Summary ---
# 
# ** Report counts by severity
# UVM_INFO :    4
# UVM_WARNING :    0
# UVM_ERROR :    0
# UVM_FATAL :    0
# ** Report counts by id
# [Questa UVM]     2
# [RNTST]     1
# [UVMTOP]     1
# ** Note: $finish    : /home/cad/eda/Mentor_Graphics/Questasim/questasim/linux_x86_64/../verilog_src/uvm-1.1d/src/base/uvm_root.svh(430)
#    Time: 0 ns  Iteration: 215  Instance: /topology
# End time: 09:34:58 on Jun 29,2026, Elapsed time: 0:00:04
# Errors: 0, Warnings: 0
*/

