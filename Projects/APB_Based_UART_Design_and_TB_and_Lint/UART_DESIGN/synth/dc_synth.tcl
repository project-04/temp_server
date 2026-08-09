remove_design -all
#set search_path {/home/cad/eda/SYNOPSYS/Design_Compiler/syn/T-2022.03-SP4/libraries/syn}
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/uart_fifo.v ../rtl/tx.v ../rtl/rx.v ../rtl/uart_register_file.v ../rtl/uart_16550.v} 

elaborate uart_16550

link 

check_design

current_design uart_16550

compile_ultra

write_file -f verilog -hier -output uart_16550_netlist.v

report_timing -path full > uart_16550_timing_report.rpt

report_area > uart_16550_area.rpt



start_gui
