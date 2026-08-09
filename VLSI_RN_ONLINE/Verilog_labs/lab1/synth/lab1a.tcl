remove_design -all
set search_path {/home/cad/eda/SYNOPSYS/Design_Compiler/syn/T-2022.03-SP4/libraries/syn}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/full_adder.v ../rtl/half_adder.v} 

elaborate full_adder

link 

source ./lab1.con

check_design

current_design  full_adder

compile_ultra

write_file -f verilog -hier -output full_adder_netlist.v

report_timing -path full > timing_report.rpt

report_area > area.rpt
