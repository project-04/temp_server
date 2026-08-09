#Makefile 
RTL = ../rtl/*.v
LIB = alu 
COVOP = -coveropt 3 +cover +acc
TB = ../tb/*.v
VSIMOPT = -coverage -vopt alu.tb_alu
VSIMCOV = coverage save -onexit -codeAll alucov 
VSIMBATCH = -c -do "$(VSIMCOV); run -all; exit" 

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

lib:
	vlib $(LIB)
	vmap work $(LIB)
help:
	@echo ===========================================================================================================================
	@echo " USAGE   	--  make target"
	@echo " clean   	=>  clean the earlier log and intermediate files."
	@echo " lib             =>  Create library and logical mapping."									   
	@echo " run_tb        	=>  To compile RTL, TB & simulate the RTL using TB in batch mode." 
	@echo " run       	=>  To clean, create libray, logical mapping, compile the source codes & simulate the RTL in batch mode."        
	@echo " html       	=>  To display html report using browser"        
	@echo " report       	=>  To create the html coverage report from the coverage database file"        
	@echo ===========================================================================================================================


run_tb:
	vlog -work alu $(COVOP) $(RTL) $(TB)
	vsim $(VSIMOPT) $(VSIMBATCH) 

report:
	vcover report  -details -codeAll -html alucov

html:
	firefox covhtmlreport/index.html&
	
run: clean lib run_tb report  html

clean:
	rm -rf modelsim.ini transcript cov*  alucov
	rm -rf $(LIB)
	rm -rf s* no* c* v* u*
	clear



cmp_tb:
	vcs $(RTL) $(TB) -cm line+tgl+fsm+branch+cond
	./simv -cm line+tgl+fsm+branch+cond urg -dir simv.vdb
	verdi -cov -covdir simv.vdb
	
run_vcs: clean cmp_tb



