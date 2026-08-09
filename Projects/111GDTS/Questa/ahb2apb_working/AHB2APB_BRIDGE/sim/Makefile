#Makefile for UVM Testbench
RTL= ../Bridge_rtl/* +define+WRAPPING_INCR
work= work #library name
SVTB1= ../tb/Top.sv
INC = +incdir+../tb +incdir+../test +incdir+../ahb_agent_top +incdir+../apb_agent_top 
SVTB2 = ../test/bridge_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit -assert -directive -cvg -codeAll mem_cov3;run -all; exit"


sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=test_1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=unspecified_incr_transfer_test 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test2:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=wrap_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

gui:
	vsim -view wave_file1.wlf

report:
	vcover merge mem_cov1 mem_cov2 mem_cov3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov
	firefox covhtmlreport/index.html &

clean: 
	rm -rf transcript* *log* work *wlf fcover* covhtml* mem_cov*  clear

regress: clean run_test run_test1 run_test2 report

cov: firefox covhtml


