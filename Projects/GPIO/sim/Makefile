help:
	-@echo "######################################################################"
	-@echo "make gpio_interface_run_test 		=> Run gpio_interface"
	-@echo "make aux_interface_run_test 		=> Run aux_interface"
	-@echo "make apb_slave_interface_run_test 	=> Run apb_slave_interface"
	-@echo "make gpio_register_run_test 		=> Run gpio_register"
	-@echo "make apb_gpio_top_run_test 		=> Run apb_gpio_top"
	-@echo "make clean  				=> Clean up current testcase directory"
	-@echo "make help   				=> Generate this help menu"
	-@echo "######################################################################"
	
	
gpio_interface_run_test: clean 
	clear
	qverilog -vopt +acc ../rtl/gpio_interface.v ../tb/gpio_interface_tb.v
	#vsim work.gpio_interface_tb -voptargs=+acc

aux_interface_run_test: clean 
	clear
	qverilog -vopt +acc ../rtl/aux_interface.v ../tb/aux_interface_tb.v
	#vsim work.aux_interface_tb -voptargs=+acc

apb_slave_interface_run_test: clean  
	clear
	qverilog -vopt +acc ../rtl/apb_slave_interface.v ../tb/apb_slave_interface_tb.v
	#vsim work.apb_slave_interface_tb -voptargs=+acc

gpio_register_run_test: clean  
	clear
	qverilog -vopt +acc ../rtl/gpio_register.v ../tb/gpio_register_tb.v
	#vsim work.gpio_register_tb -voptargs=+acc

apb_gpio_top_run_test: clean  
	clear
	qverilog -vopt +acc ../rtl/gpio_interface.v ../rtl/aux_interface.v ../rtl/apb_slave_interface.v ../rtl/gpio_register.v ../rtl/apb_gpio_top.v ../tb/apb_gpio_top_tb.v
	vsim work.apb_gpio_top_tb -voptargs=+acc

clean: 
	rm -rf simv simv.daidir csrc ucli.key dump.fsdb wave.fsdb wave.vcd qverilog.log work vsim.wlf transcript verdiLog dump.vcd novas.conf novas.rc
	clear

#view_wave:
#	vsim work.tb -voptargs=+acc




#for VCS
#cmp: clean
#	vcs -full64 -sverilog -debug_access+all -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a ../uart_fifo.v ../tx.v ../rx.v ../uart_register_file.v ../uart_16550.v ../uart_16550_tb.v -l vcs_compile.log
	
#vcs_uart_16550_run_test: cmp	
#	./simv +fsdbfile+wave.fsdb -l vcs_sim.log

