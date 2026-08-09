help:
	-@echo "######################################################################"
	-@echo "FROM EACH test_<name> DIRECTORY...."
	-@echo "make synth 	=> Run DC shell on current testcase"
	-@echo "make clean  	=> Clean up current testcase directory"
	-@echo "FROM examples DIRECTORY...."
	-@echo "make help   	=> Generate this help menu      "
	-@echo "NOTE: Refer to README file for more details on the testcase"
	-@echo "######################################################################"

synth: clean
	#dc_shell -f synth.tcl
	/home/cad/eda/SYNOPSYS/Design_Compiler_2022.03/syn/T-2022.03-SP4/linux64/syn/bin/dc_shell -f dc_synth.tcl

clean:
	 rm -rf uart* UART* *.txt *.log default.svf alib-52 novas* vcst* *.txt
