remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog ../rtl/dff.v

elaborate dff

link 

check_design

current_design  dff

compile_ultra

write_file -f verilog -hier -output dff_netlist.v


 

