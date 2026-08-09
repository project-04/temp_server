remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog ../rtl/mux4_1.v 

elaborate mux4_1

link 

check_design

current_design  mux4_1

compile_ultra

write_file -f verilog -hier -output mux4_1_netlist.v

report_timing -path full > timing_report.rpt

report_area > area.rpt
 


start_gui
