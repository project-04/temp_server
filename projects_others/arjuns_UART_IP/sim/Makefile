#Makefile for UVM Testbench- UART Project
# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa
#SIMULATOR = VCS
FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../uart_agt_top +incdir+../apb_agt_top
SVTB2 = ../test/uart_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit mem_cov9;run -all; exit"
VSIMBATCH10= -c -do  " log -r /* ;coverage save -onexit mem_cov10;run -all; exit"
VSIMBATCH11= -c -do  " log -r /* ;coverage save -onexit mem_cov11;run -all; exit"
VSIMBATCH12= -c -do  " log -r /* ;coverage save -onexit mem_cov12;run -all; exit"
VSIMBATCH13= -c -do  " log -r /* ;coverage save -onexit mem_cov13;run -all; exit"
VSIMBATCH14= -c -do  " log -r /* ;coverage save -onexit mem_cov14;run -all; exit"
VSIMBATCH15= -c -do  " log -r /* ;coverage save -onexit mem_cov15;run -all; exit"
VSIMBATCH16= -c -do  " log -r /* ;coverage save -onexit mem_cov16;run -all; exit"
VSIMBATCH17= -c -do  " log -r /* ;coverage save -onexit mem_cov17;run -all; exit"
VSIMBATCH18= -c -do  " log -r /* ;coverage save -onexit mem_cov18;run -all; exit"
VSIMBATCH19= -c -do  " log -r /* ;coverage save -onexit mem_cov19;run -all; exit"
VSIMBATCH20= -c -do  " log -r /* ;coverage save -onexit mem_cov20;run -all; exit"
VSIMBATCH21= -c -do  " log -r /* ;coverage save -onexit mem_cov21;run -all; exit"

help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                  								!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.  						!"
	@echo "! sv_cmp    	=>  Create library and compile the code.           						!"
	@echo "! run_test	=>  clean, compile & run the simulation for base_test in batch mode.	         	 	!" 
	@echo "!  														!"
	@echo "! run_test1	=>  clean, compile & run the simulation for 1.HD0_sequence_test in batch mode.			!" 
	@echo "! run_test2	=>  clean, compile & run the simulation for 2.HD0_multiple_sequence_test in batch mode.		!"
	@echo "! run_test3	=>  clean, compile & run the simulation for 3.HD1_sequence_test in batch mode.			!" 
	@echo "! run_test4	=>  clean, compile & run the simulation for 4.HD1_multiple_sequence_test in batch mode.		!" 
	@echo "! run_test5	=>  clean, compile & run the simulation for 5.FD_sequence_test in batch mode.			!" 
	@echo "! run_test6	=>  clean, compile & run the simulation for 6.FD_multiple_sequence_test in batch mode.		!" 
	@echo "! run_test7	=>  clean, compile & run the simulation for 7.loopback_sequence_test in batch mode.		!" 
	@echo "! run_test8	=>  clean, compile & run the simulation for 8.loopback_multiple_sequence_test in batch mode.	!" 
	@echo "! run_test9	=>  clean, compile & run the simulation for 9.THR_empty_sequence_test in batch mode.		!" 
	@echo "! run_test10	=>  clean, compile & run the simulation for 10.HD0_parity_sequence_test in batch mode.		!" 
	@echo "! run_test11	=>  clean, compile & run the simulation for 11.HD1_parity_sequence_test in batch mode.		!" 
	@echo "! run_test12	=>  clean, compile & run the simulation for 12.FD_parity_sequence_test in batch mode.		!"
	@echo "! run_test12	=>  clean, compile & run the simulation for 13.HD1_break_sequence_test in batch mode.		!"
	@echo "! run_test14	=>  clean, compile & run the simulation for 14.HD_frame_sequence_test in batch mode.		!" 
	@echo "! run_test15	=>  clean, compile & run the simulation for 15.FD_frame_sequence_test in batch mode.		!" 
	@echo "! run_test16	=>  clean, compile & run the simulation for 16.HD1_overrun_sequence_test in batch mode.		!" 
	@echo "! run_test17	=>  clean, compile & run the simulation for 17.HD1_timeout_sequence_test in batch mode.		!"	 
	@echo "! run_test18	=>  clean, compile & run the simulation for 18.				 in batch mode.		!" 
	@echo "! run_test19	=>  clean, compile & run the simulation for 19.				 in batch mode.		!" 
	@echo "! run_test20	=>  clean, compile & run the simulation for 20.				 in batch mode.		!" 
	
	@echo "!  														!"
	@echo "! view_wave1 =>  To view the waveform of base_test	    						        !" 
	@echo "! view_wave2 =>  To view the waveform of HD0_sequence_test	    						!" 
	@echo "! view_wave3 =>  To view the waveform of HD0_multiple_sequence_test 	  					!" 
	@echo "! view_wave4 =>  To view the waveform of HD1_sequence_test    							!" 
	@echo "! view_wave5 =>  To view the waveform of HD1_multiple_sequence_test    						!" 
	@echo "! view_wave6 =>  To view the waveform of FD_sequence_test    							!" 
	@echo "! view_wave7 =>  To view the waveform of FD_multiple_sequence_test    						!" 
	@echo "! view_wave8 =>  To view the waveform of loopback_sequence_test    						!" 
	@echo "! view_wave9 =>  To view the waveform of loopback_multiple_sequence_test    					!" 
	@echo "! view_wave10 =>  To view the waveform of THR_empty_sequence_test    						!" 
	@echo "! view_wave11 =>  To view the waveform of HD0_parity_sequence_test    						!" 
	@echo "! view_wave12 =>  To view the waveform of HD1_parity_sequence_test    						!" 
	@echo "! view_wave12 =>  To view the waveform of FD_parity_sequence_test    						!" 
	@echo "! view_wave13 =>  To view the waveform of HD1_break_sequence_test    						!" 		
	@echo "! view_wave14 =>  To view the waveform of HD_frame_sequence_test    						!" 
	@echo "! view_wave15 =>  To view the waveform of FD_frame_sequence_test    						!" 
	@echo "! view_wave16 =>  To view the waveform of HD1_overrun_sequence_test    						!" 
	@echo "! view_wave17 =>  To view the waveform of HD1_timeout_sequence_test    						!" 
	@echo "! view_wave18 =>  To view the waveform of     									!" 
	@echo "! view_wave19 =>  To view the waveform of 			    						!" 
	@echo "! view_wave20 =>  To view the waveform of     									!" 
	
	@echo "!  														!"	
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.							!"
	@echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
run_test4 : run_test4_$(SIMULATOR)
run_test5 : run_test5_$(SIMULATOR)
run_test6 : run_test6_$(SIMULATOR)
run_test7 : run_test7_$(SIMULATOR)
run_test8 : run_test8_$(SIMULATOR)
run_test9 : run_test9_$(SIMULATOR)
run_test10 : run_test10_$(SIMULATOR)
run_test11 : run_test11_$(SIMULATOR)
run_test12 : run_test12_$(SIMULATOR)
run_test13 : run_test13_$(SIMULATOR)
run_test14 : run_test14_$(SIMULATOR)
run_test15 : run_test15_$(SIMULATOR)
run_test16 : run_test16_$(SIMULATOR)
run_test17 : run_test17_$(SIMULATOR)
run_test18 : run_test18_$(SIMULATOR)
run_test19 : run_test19_$(SIMULATOR)
run_test20 : run_test20_$(SIMULATOR)

view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
view_wave5 : view_wave5_$(SIMULATOR)
view_wave6 : view_wave6_$(SIMULATOR)
view_wave7 : view_wave7_$(SIMULATOR)
view_wave8 : view_wave8_$(SIMULATOR)
view_wave9 : view_wave9_$(SIMULATOR)
view_wave10 : view_wave10_$(SIMULATOR)
view_wave11 : view_wave11_$(SIMULATOR)
view_wave12 : view_wave12_$(SIMULATOR)
view_wave13 : view_wave13_$(SIMULATOR)
view_wave14 : view_wave14_$(SIMULATOR)
view_wave15 : view_wave15_$(SIMULATOR)
view_wave16 : view_wave16_$(SIMULATOR)
view_wave17 : view_wave17_$(SIMULATOR)
view_wave18 : view_wave18_$(SIMULATOR)
view_wave19 : view_wave19_$(SIMULATOR)
view_wave20 : view_wave20_$(SIMULATOR)
	

regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -sv -work $(work) +define+UVM_REPORT_DISABLE_FILE_LINE $(RTL) $(INC) $(SVTB2) $(SVTB1) 
	
run_test_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=base_test 
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1
	
run_test1_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=HD0_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2
	
run_test2_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=HD0_multiple_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3
	
run_test3_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test4_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random work.top +UVM_TESTNAME=HD1_multiple_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test5_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=FD_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test6_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log  -sv_seed random  work.top +UVM_TESTNAME=FD_multiple_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7

run_test7_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log  -sv_seed random  work.top +UVM_TESTNAME=loopback_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

run_test8_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave_file9.wlf -l test9.log  -sv_seed random  work.top +UVM_TESTNAME=loopback_multiple_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

run_test9_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10)  -wlf wave_file10.wlf -l test10.log  -sv_seed random  work.top +UVM_TESTNAME=THR_empty_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10

run_test10_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH11)  -wlf wave_file11.wlf -l test11.log  -sv_seed random  work.top +UVM_TESTNAME=HD0_parity_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov11

run_test11_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH12)  -wlf wave_file12.wlf -l test12.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_parity_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov12

run_test12_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH13)  -wlf wave_file13.wlf -l test13.log  -sv_seed random  work.top +UVM_TESTNAME=FD_parity_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov13

run_test13_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH14)  -wlf wave_file14.wlf -l test14.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_break_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov14

run_test14_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH15)  -wlf wave_file15.wlf -l test15.log  -sv_seed random  work.top +UVM_TESTNAME=HD_frame_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov15

run_test15_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH16)  -wlf wave_file16.wlf -l test16.log  -sv_seed random  work.top +UVM_TESTNAME=FD_frame_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov16

run_test16_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH17)  -wlf wave_file17.wlf -l test17.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_overrun_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov17

run_test17_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH18)  -wlf wave_file18.wlf -l test18.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_timeout_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov18

run_test18_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH19)  -wlf wave_file19.wlf -l test19.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_timeout_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov19

run_test19_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH20)  -wlf wave_file20.wlf -l test20.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_timeout_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov20

run_test20_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH21)  -wlf wave_file21.wlf -l test21.log  -sv_seed random  work.top +UVM_TESTNAME=HD1_timeout_sequence_test +UVM_VERBOSITY=UVM_HIGH
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov21
#SEED VALUES:-

#uart_HD0_sequence_test = 4269204786
#uart_HD1_sequence_test = 1868949036
#uart_HD_Multiple_sequence_test = 
#uart_FD_Multiple_sequence_test = 4255268568
#uart_Loopback_sequence_test = 1848830577
#uart_Loopback_Multiple_sequence_test = 4275585755
#uart_THR_empty_sequence_test = 3820334860
#uart_HD_parity_sequence_test = 1072880754
#uart_FD_parity_sequence_test = 3125893827
#uart_FD_break_sequence_test = 3989842671
#uart_FD_frame_sequence_test = 4086502080
#uart_FD_overrun_sequence_test = 
#uart_FD_timeout_sequence_test = 

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

view_wave6_Questa:
	vsim -view wave_file6.wlf

view_wave7_Questa:
	vsim -view wave_file7.wlf

view_wave8_Questa:
	vsim -view wave_file8.wlf

view_wave9_Questa:
	vsim -view wave_file9.wlf

view_wave10_Questa:
	vsim -view wave_file10.wlf

view_wave11_Questa:
	vsim -view wave_file11.wlf

view_wave12_Questa:
	vsim -view wave_file12.wlf

view_wave13_Questa:
	vsim -view wave_file13.wlf

view_wave14_Questa:
	vsim -view wave_file14.wlf

view_wave15_Questa:
	vsim -view wave_file15.wlf

view_wave16_Questa:
	vsim -view wave_file16.wlf

view_wave17_Questa:
	vsim -view wave_file17.wlf

view_wave18_Questa:
	vsim -view wave_file18.wlf

view_wave19_Questa:
	vsim -view wave_file19.wlf

view_wave20_Questa:
	vsim -view wave_file20.wlf

view_wave21_Questa:
	vsim -view wave_file21.wlf


report_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10 mem_cov11 mem_cov12 mem_cov13 mem_cov14 mem_cov15 mem_cov16 mem_cov17 mem_cov18 mem_cov19 mem_cov20 mem_cov21 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa run_test8_Questa run_test9_Questa run_test10_Questa run_test11_Questa run_test12_Questa run_test13_Questa run_test14_Questa run_test15_Questa run_test16_Questa run_test17_Questa run_test18_Questa run_test19_Questa run_test20_Questa report_Questa cov_Questa

cov_Questa:
	firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a +define+UVM_REPORT_DISABLE_FILE_LINE $(RTL) $(INC) $(SVTB2) $(SVTB1)
		      
run_test_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=base_test +UVM_VERBOSITY=UVM_HIGH
	urg -dir mem_cov1.vdb -format both -report urgReport1
	
run_test1_VCS: clean sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=uart_HD0_sequence_test +UVM_VERBOSITY=UVM_HIGH
	urg -dir mem_cov2.vdb -format both -report urgReport2
	
run_test2_VCS:	clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=uart_HD1_sequence_test +UVM_VERBOSITY=UVM_HIGH
	urg -dir mem_cov3.vdb -format both -report urgReport3
	
run_test3_VCS:	clean sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave4.fsdb -cm_dir ./mem_cov4 +ntb_random_seed_automatic +UVM_TESTNAME=uart_FD_sequence_test +UVM_VERBOSITY=UVM_HIGH
	urg -dir mem_cov4.vdb -format both -report urgReport4
	
view_wave1_VCS: 
	verdi -ssf wave1.fsdb
	
view_wave2_VCS: 
	verdi -ssf wave2.fsdb

view_wave3_VCS: 
	verdi -ssf wave3.fsdb

view_wave4_VCS: 
	verdi -ssf wave4.fsdb		
	
report_VCS:
	urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: 
	clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS report_VCS

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#


