help:
	-@echo "######################################################################"
	-@echo "make top_lint 	=> Run VC Static lint check on GPIO top"
	-@echo "make mod_lint 	=> Run VC Static lint check on single module"
	-@echo "make clean  	=> Clean up current testcase directory"
	-@echo "make help   	=> Generate this help menu      "
	-@echo "######################################################################"

top_lint:
	$(VC_STATIC_HOME)/bin/vc_static_shell -mode64 -f gpio_top_lint.tcl
	cat report_lint*
	
mod_lint:
	$(VC_STATIC_HOME)/bin/vc_static_shell -mode64 -f single_module_lint.tcl
	cat report_lint*

clean:
	 rm -rf novas* vcst* *.txt



