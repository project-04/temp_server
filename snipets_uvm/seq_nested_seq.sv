module seq_nested_seq;
	
	`include "uvm_macros.svh"
	import uvm_pkg::*;
		
	class agt_config extends uvm_object;
		`uvm_object_utils(agt_config)
		
		uvm_active_passive_enum is_active;
		
		function new(string name="agt_config");
			super.new(name);
		endfunction
	endclass
	
	class env_config extends uvm_object;
		`uvm_object_utils(env_config)
		
		int no_of_agents;
		
		function new(string name="env_config");
			super.new(name);
		endfunction
	endclass
	
	
	class xtn extends uvm_sequence_item;
		`uvm_object_utils(xtn)
		
		rand bit[3:0] A;
		
		function new(string name="xtn");
			super.new(name);
		endfunction
		
		function void do_print(uvm_printer printer);
			super.do_print(printer);

			printer.print_field("A",     this.A,    $bits(this.A),	UVM_DEC);
		endfunction	
	endclass
	
	class drv extends uvm_driver #(xtn);
		`uvm_component_utils(drv)

		function new(string name="drv", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		task run_phase(uvm_phase phase);
			forever
			       begin
				    seq_item_port.get_next_item(req);
				    `uvm_info("DRV", $sformatf("From drv%s",req.sprint()), UVM_LOW)
				    #1;
				    seq_item_port.item_done();
			       end
			       
		endtask
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
	class A_equals_to_7_seq extends seq;
		`uvm_object_utils(A_equals_to_7_seq)

		function new(string name="A_equals_to_7_seq");
			super.new(name);
		endfunction
		
		task body();
		repeat(3)
		  	begin
		  	     req = xtn::type_id::create("req");
			     start_item(req);
			     assert(req.randomize() with {A == 7;});
		  	     finish_item(req);
			end
	  	endtask
	endclass
	class main_seq extends uvm_sequence #(xtn);
		`uvm_object_utils(main_seq)
		
		A_equals_to_7_seq A_7_seq;
		
		function new(string name="main_seq");
			super.new(name);
		endfunction
		
		task body();
		repeat(2)
		  	begin
		  	     A_7_seq = A_equals_to_7_seq::type_id::create("A_7_seq");
			     A_7_seq.start(m_sequencer);
			end
	  	endtask
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
				seqrh = seqr::type_id::create("seqrh", this);
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
		
		agt agth[];
		env_config env_configh;
		
		function new(string name="env", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
				`uvm_fatal("env", "can't get env_config")
			
			agth = new[env_configh.no_of_agents];
			
			foreach(agth[i])
			begin
				agth[i] = agt::type_id::create($sformatf("agth[%0d]",i), this);
			end
		endfunction
	endclass
	
	class test extends uvm_test;
		`uvm_component_utils(test)
		
		env envh;
		env_config env_configh;
		agt_config agt_configh[];
		
		function new(string name="test", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			env_configh = env_config::type_id::create("env_configh");
			env_configh.no_of_agents = 1;
			uvm_config_db #(env_config)::set(this, "*", "env_config", env_configh);
			
			agt_configh = new[env_configh.no_of_agents];
			foreach(agt_configh[i])
			begin
				agt_configh[i] = agt_config::type_id::create($sformatf("agt_configh[%0d]",i));
				if(i==0)
					agt_configh[i].is_active = UVM_ACTIVE;
				else
					agt_configh[i].is_active = UVM_PASSIVE;
			end
			
			foreach(agt_configh[i])
			begin
				uvm_config_db #(agt_config)::set(this, $sformatf("*.agth[%0d]",i), "agt_config", agt_configh[i]);
			end
			
			envh = env::type_id::create("envh", this);
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			
			uvm_factory::get().print();
			uvm_top.print_topology();
		endfunction
	endclass
	class test_A_7 extends test;
	      `uvm_component_utils(test_A_7)
	     
		main_seq main_seqh;

	 	function new(string name = "test_A_7", uvm_component parent);
			 super.new(name, parent);
	  	endfunction

		function void build_phase(uvm_phase phase);
		 	super.build_phase(phase);
		endfunction
	       
		task run_phase(uvm_phase phase);
		     	phase.raise_objection(this);

		     	main_seqh = main_seq::type_id ::create("main_seqh");
	 	     	main_seqh.start(envh.agth[0].seqrh);
	 	     	
			phase.drop_objection(this);
			
			$display("\n\n\n################################################ TEST ################################################\n\n\n");
	  	endtask
	endclass
	
	initial begin
		//qverilog seq_nested_seq.sv
		//vcs -sverilog -ntb_opts uvm seq_nested_seq.sv; ./simv
		
		//uvm_top.set_report_verbosity_level(UVM_NONE);		
		run_test("test_A_7");
	end
endmodule

/*
Start time: 09:43:13 on Jun 29,2026
qverilog ../seq_nested_seq.sv 
-- Compiling module seq_nested_seq
** Note: (qverilog-2286) ../seq_nested_seq.sv(3): Using implicit +incdir+/home/cad/eda/Mentor_Graphics/Questasim/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src from import uvm_pkg
-- Importing package mtiUvm.uvm_pkg (uvm-1.1d Built-in)

Top level modules:
	seq_nested_seq
# vsim -lib work work.seq_nested_seq -c -do "run -all; quit -f" -appendlog -l qverilog.log -vopt 
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
# Loading work.seq_nested_seq(fast)
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
# UVM_INFO @ 0: reporter [RNTST] Running test test_A_7...
# 
#### Factory Configuration (*)
# 
#   No instance or type overrides are registered with this factory
# 
# All types registered with the factory: 51 total
# (types without type names will not be printed)
# 
#   Type Name
#   ---------
#   A_equals_to_7_seq
#   agt
#   agt_config
#   drv
#   env
#   env_config
#   main_seq
#   mon
#   questa_uvm_recorder
#   seq
#   seqr
#   test
#   test_A_7
#   xtn
# (*) Types with no associated type name will be printed as <unknown>
# 
####
# 
# UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
# --------------------------------------------------------------
# Name                       Type                    Size  Value
# --------------------------------------------------------------
# uvm_test_top               test_A_7                -     @468 
#   envh                     env                     -     @485 
#     agth[0]                agt                     -     @493 
#       drvh                 drv                     -     @509 
#         rsp_port           uvm_analysis_port       -     @524 
#         seq_item_port      uvm_seq_item_pull_port  -     @516 
#       monh                 mon                     -     @502 
#       seqrh                seqr                    -     @532 
#         rsp_export         uvm_analysis_export     -     @539 
#         seq_item_export    uvm_seq_item_pull_imp   -     @633 
#         arbitration_queue  array                   0     -    
#         lock_queue         array                   0     -    
#         num_last_reqs      integral                32    'd1  
#         num_last_rsps      integral                32    'd1  
# --------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 0: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @657                                   
#   begin_time                   time      64    0                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 1: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @686                                   
#   begin_time                   time      64    1                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 2: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @690                                   
#   begin_time                   time      64    2                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 3: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @698                                   
#   begin_time                   time      64    3                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 4: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @702                                   
#   begin_time                   time      64    4                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# UVM_INFO ../seq_nested_seq.sv(54) @ 5: uvm_test_top.envh.agth[0].drvh [DRV] From drv--------------------------------------------------------------------------------------
# Name                           Type      Size  Value                                  
# --------------------------------------------------------------------------------------
# req                            xtn       -     @706                                   
#   begin_time                   time      64    5                                      
#   depth                        int       32    'd2                                    
#   parent sequence (name)       string    7     A_7_seq                                
#   parent sequence (full name)  string    39    uvm_test_top.envh.agth[0].seqrh.A_7_seq
#   sequencer                    string    31    uvm_test_top.envh.agth[0].seqrh        
#   A                            integral  4     'd7                                    
# --------------------------------------------------------------------------------------
# 
# 
# 
# 
################################################ TEST ################################################
# 
# 
# 
# UVM_INFO verilog_src/uvm-1.1d/src/base/uvm_objection.svh(1267) @ 6: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
# 
# --- UVM Report Summary ---
# 
# ** Report counts by severity
# UVM_INFO :   11
# UVM_WARNING :    0
# UVM_ERROR :    0
# UVM_FATAL :    0
# ** Report counts by id
# [DRV]     6
# [Questa UVM]     2
# [RNTST]     1
# [TEST_DONE]     1
# [UVMTOP]     1
# ** Note: $finish    : /home/cad/eda/Mentor_Graphics/Questasim/questasim/linux_x86_64/../verilog_src/uvm-1.1d/src/base/uvm_root.svh(430)
#    Time: 6 ns  Iteration: 65  Instance: /seq_nested_seq
# End time: 09:43:17 on Jun 29,2026, Elapsed time: 0:00:04
# Errors: 0, Warnings: 0
*/
