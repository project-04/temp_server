module factory_overriding_dynamic_classes;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class driver extends uvm_component;
		`uvm_component_utils(driver)
		function new(string name="driver", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class axi_drv extends driver;
		`uvm_component_utils(axi_drv)
		function new(string name="axi_drv", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class apb_drv extends driver;
		`uvm_component_utils(apb_drv)
		function new(string name="apb_drv", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class test extends uvm_test;
		`uvm_component_utils(test)
		
		driver driverh[4];
		
		function new(string name="test", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			//uvm_factory factory = uvm_factory::get();
			super.build_phase(phase);
			
			set_type_override_by_type(driver::get_type(), axi_drv::get_type(), 1);
			//factory.set_type_override_by_name("driver", "axi_drv", 1);
			set_inst_override_by_type("*driverh[2]", driver::get_type(), apb_drv::get_type());
			factory.set_inst_override_by_name("driver", "apb_drv", "*.driverh[3]");
			
			foreach(driverh[i])
				driverh[i] = driver::type_id::create($sformatf("driverh[%0d]",i), this);
				
			factory.print();
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			uvm_top.print_topology();
		endfunction
	endclass
	
	
	initial begin
		//qverilog -vopt +acc ../factory_overriding_dynamic_classes.sv; vsim work.top -voptargs=+acc
		//qverilog factory_overriding_dynamic_classes.sv
		//vcs -sverilog -ntb_opts uvm factory_overriding_dynamic_classes.sv; ./simv
		
		//uvm_top.set_report_verbosity_level(UVM_NONE);		
		run_test("test");
	end
endmodule


/*

Start time: 17:33:53 on Jul 02,2026
qverilog ../factory_overriding_dynamic_classes.sv 
-- Compiling module factory_overriding_dynamic_classes
-- Importing package mtiUvm.uvm_pkg (uvm-1.1d Built-in)
** Note: (qverilog-2286) ../factory_overriding_dynamic_classes.sv(3): Using implicit +incdir+/home/cad/eda/Mentor_Graphics/Questasim/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src from import uvm_pkg

Top level modules:
	factory_overriding_dynamic_classes
# vsim -lib work work.factory_overriding_dynamic_classes -c -do "run -all; quit -f" -appendlog -l qverilog.log -vopt 
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
# Loading work.factory_overriding_dynamic_classes(fast)
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
# 
#### Factory Configuration (*)
# 
# Instance Overrides:
# 
#   Requested Type  Override Path             Override Type
#   --------------  ------------------------  -------------
#   driver          uvm_test_top.*driverh[2]  apb_drv
#   driver          *.driverh[3]              apb_drv
# 
# Type Overrides:
# 
#   Requested Type  Override Type           
#   --------------  ------------------------
#   driver          axi_drv
# 
# All types registered with the factory: 41 total
# (types without type names will not be printed)
# 
#   Type Name
#   ---------
#   apb_drv
#   axi_drv
#   driver
#   questa_uvm_recorder
#   test
# (*) Types with no associated type name will be printed as <unknown>
# 
####
# 
# UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
# ----------------------------------
# Name          Type     Size  Value
# ----------------------------------
# uvm_test_top  test     -     @466 
#   driverh[0]  axi_drv  -     @473 
#   driverh[1]  axi_drv  -     @480 
#   driverh[2]  apb_drv  -     @487 
#   driverh[3]  apb_drv  -     @494 
# ----------------------------------
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
#    Time: 0 ns  Iteration: 215  Instance: /factory_overriding_dynamic_classes
# End time: 17:34:00 on Jul 02,2026, Elapsed time: 0:00:07
# Errors: 0, Warnings: 0

*/
