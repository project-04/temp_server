remove_design -all

set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

#analyze -format verilog {../rtl/apb_slave_interface.v} 
#analyze -format verilog {../rtl/aux_interface.v} 
#analyze -format verilog {../rtl/gpio_interface.v} 
#analyze -format verilog {../rtl/gpio_register.v} 
analyze -format verilog {../rtl/apb_gpio_top.v} 

#elaborate apb_slave_interface
#elaborate aux_interface
#elaborate gpio_interface
#elaborate gpio_register
elaborate apb_gpio_top

link 

check_design

#current_design  apb_save_interface
#current_design aux_interface
#current_design  gpio_interface
#current_design  gpio_register
current_design  apb_gpio_top

compile_ultra

#write_file -f verilog -hier -output apb_slave_interface_netlist.v
#write_file -f verilog -hier -output aux_interface_netlist.v
#write_file -f verilog -hier -output gpio_interface_netlist.v
#write_file -f verilog -hier -output gpio_register_netlist.v
write_file -f verilog -hier -output apb_gpio_top_netlist.v

start_gui

