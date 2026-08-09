RTL = ../rtl/*
TB= ../tb/uart_16550_tb.v


fifo_run_test: clean 
	qverilog -vopt +acc ../rtl/uart_fifo.v ../tb/uart_fifo_tb.v
	#vsim work.tb -voptargs=+acc

tx_run_test: clean
	qverilog -vopt +acc ../rtl/uart_fifo.v ../rtl/tx.v ../tb/tx_tb.v
	#vsim work.uart_tx_tb -voptargs=+acc
	
rx_run_test: clean
	qverilog -vopt +acc ../rtl/uart_fifo.v ../rtl/rx.v ../tb/rx_tb.v
	#vsim work.uart_rx_tb -voptargs=+acc

uart_16550_run_test: clean
	qverilog -vopt +acc $(RTL) $(TB)
	#vsim work.uart_16550_tb -voptargs=+acc



vcs_uart_16550_run_test: clean
	vcs -full64 -debug_access +all -kdb $(RTL) $(TB) -l vcs_compile.log
	#./simv -l vcs_sim.log; ./simv -verdi

clean: 
	rm -rf simv simv.daidir csrc ucli.key *.fsdb wave.vcd qverilog.log work vsim.wlf transcript verdiLog dump.vcd novas* verdi_config_file *.log
	clear

#view_wave:
#	vsim work.tb -voptargs=+acc
