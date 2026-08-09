#Makefile 

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


RTL=../rtl/*.v
work= work #library name
SVTB1= ../tb/top.sv
INTERFACE = ../interface/*.sv
INC = +incdir+../tb +incdir+../test +incdir+../axi_agent +incdir+../ahb_agent +incdir+../axi_rst_agent +incdir+../ahb_rst_agent
SVTB2 = ../test/pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"




help:
	@echo =============================================================================================================
	@echo "! USAGE          --  make target                                                                                 !"
	@echo "! clean          =>  clean the earlier log and intermediate files.                                               !"
	@echo "! sv_cmp         =>  Create library and compile the code.                                                        !"
	@echo "! run_test       =>  clean, compile & run the simulation for base_test in batch mode.            !"
	@echo "! run_test_reset       =>  clean, compile & run the simulation for reset_test in batch mode.            !"
	@echo "! run_test_axi       =>  clean, compile & run the simulation for axi_test in batch mode.            !"
	@echo "! run_test_axi_read       =>  clean, compile & run the simulation for axi_read_test in batch mode.            !"
	@echo "! run_test_axi_write_burst       =>  clean, compile & run the simulation for axi_write_burst in batch mode.            !"
	@echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)
run_test_reset : run_test_reset_$(SIMULATOR)
run_test_axi : run_test_axi_$(SIMULATOR)
run_test_axi_read : run_test_axi_read_$(SIMULATOR)
run_test_axi_write_burst : run_test_axi_write_burst_$(SIMULATOR)






# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INTERFACE) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.axi2ahb_bridge_tb_top +UVM_TESTNAME=base_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test_reset_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.axi2ahb_bridge_tb_top +UVM_TESTNAME=reset_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test_axi_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.axi2ahb_bridge_tb_top +UVM_TESTNAME=axi_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3


run_test_axi_read_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.axi2ahb_bridge_tb_top +UVM_TESTNAME=axi_read_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test_axi_write_burst_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random  work.axi2ahb_bridge_tb_top +UVM_TESTNAME=axi_write_burst_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5



view_wave1_Questa:
	vsim -view wave_file1.wlf

view_wave2_Questa:
	vsim -view wave_file2.wlf

view_wave3_Questa:
	vsim -view wave_file3.wlf

view_wave4_Questa:
	vsim -view wave_file4.wlf

view_wave5_Questa:
	vsim -view wave_file5.wlf




report_Questa:
	vcover merge -stats=none -strip 0 -testassociated regress_axi2ahb_cov.ucdb ../V_plan_ucdb_files/axi2ahb_vplan_ucdb_file.ucdb mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5
	
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html regress_axi2ahb_cov.ucdb 

regress_Questa: clean_Questa run_test_Questa run_test_reset_Questa run_test_axi_Questa run_test_axi_read_Questa run_test_axi_write_burst_Questa report_Questa


cov_Questa:
	firefox covhtmlreport/index.html&

clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INTERFACE) $(INC) $(SVTB2) $(SVTB1)

run_test_VCS:   clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=base_test +UVM_VERBOSITY=UVM_HIGH
	urg -dir mem_cov1.vdb -format both -report urgReport1

run_test_reset_VCS:   clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=reset_test
	urg -dir mem_cov2.vdb -format both -report urgReport2
run_test_axi_VCS:   clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=axi_test
	urg -dir mem_cov3.vdb -format both -report urgReport3

view_wave1_VCS:
	verdi -ssf wave1.fsdb

view_wave2_VCS:
	verdi -ssf wave2.fsdb

view_wave3_VCS:
	verdi -ssf wave3.fsdb

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#

