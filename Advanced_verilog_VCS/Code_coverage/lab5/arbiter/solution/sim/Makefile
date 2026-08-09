#Makefile Script
RTL = ../rtl/arbiter.v
TB = ../tb/bfm_arbiter.v ../tb/tb_userinterface.v


FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

cmp_tb:
	vcs $(RTL) $(TB) -cm line+tgl+fsm+branch+cond
	./simv -cm line+tgl+fsm+branch+cond urg -dir simv.vdb
	verdi -cov -covdir simv.vdb

help:
	@echo ===========================================================================================================================
	@echo " USAGE   	--  make target"
	@echo " clean   	=>  clean the earlier log and intermediate files."
	@echo " cmp_tb        	=>  To compile RTL, TB & simulate the RTL using TB in batch mode." 
	@echo " run1       	=>  To clean,compile the source codes & simulate the RTL in batch mode."        
	@echo ===========================================================================================================================

	
clean:
	rm -rf csrc .fsdb novas_dump.log simv* simv1.daidir ucli.key verdi* novas.* cm.log vdCov*
	clear

run1: clean cmp_tb

