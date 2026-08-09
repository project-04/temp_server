help:
	-@echo "######################################################################"
	-@echo "make synth 	=> Synthesis the RTL. RTL to gate level netlist "
	-@echo "make clean  	=> Clean up current testcase directory"
	-@echo "make help   	=> Generate this help menu      "
	-@echo "######################################################################"

synth:
	#dc_shell -f synth.tcl
	/home/cad/eda/SYNOPSYS/Design_Compiler_2022.03/syn/T-2022.03-SP4/linux64/syn/bin/dc_shell -f synth.tcl

clean:
	 rm -rf novas* vcst* *.txt *.rpt *.log alib-52 *.pvl *.svf *.syn *.mr



