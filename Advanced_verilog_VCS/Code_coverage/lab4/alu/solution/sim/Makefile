#Makefile script
RTL = ../rtl/alu.v
TB = ../tb/tb_alu.v

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


help:
	@echo ===========================================================================================================================
	@echo " USAGE   	--  make target"
	@echo " clean   	=>  clean the earlier log and intermediate files."
	@echo " cmp_tb        	=>  To compile RTL, TB & simulate the RTL using TB in batch mode." 
	@echo " run1       	=>  To clean,compile the source codes & simulate the RTL in batch mode."        
	@echo ==========================================================================================================================

cmp_tb:
	vcs $(RTL) $(TB) -cm line+tgl+branch
	./simv -cm line+tgl+branch urg -dir simv.vdb
	verdi -cov -covdir simv.vdb

	
clean:
	rm -rf csrc .fsdb novas_dump.log simv* simv.daidir ucli.key verdi* novas.* cm.log vdCov* mysimv* result.out
	clear


run1: clean cmp_tb










