#Set the context to DFT
set_context dft -rtl

#Read the cell library files
read_cell_library adk.tcelllib

#Read the design source codes
read_verilog ./design/core.v ./design/clk_div.v

#Read the TSDB of the sub-blocks
open_tsdb ./BlockA/blockA_tsdb
open_tsdb ../Lab13/tsdb

#Elaborate the design top
set_current_design core

#Source the PDL file of clock divider
source ./design/clk_div.pdl

#Report the open tsdb directories
get_tsdb_list

#Report the name & location of the tsdb to be generated at physical block level
get_tsdb_output_directory

#Report IJTAG instances that are included in this design
report_ijtag_instances 

#Report all the ICL modules
report_icl_modules

#Report the identified clock enables
report_dft_clock_enables

#Set the design level to physical block level
set_design_level physical_block

#Specify the DFT requirements
set_dft_specification_requirements -memory_test on -memory_bisr_chains off  -memory_bisr_controller off
#Validate the DFT requirements
check_design_rules

#Report a specific DRC violation
#report_drc_rules DFT_C1-1 
#Analyze the violation using schematic viewer
#analyze_drc_violation DFT_C1-1
#Fixing the violation DFT_C1-1
register_static_dft_signal_names sel_clkb
add_dft_control_point clock_mux1/S0 -control_source_name sel_clkb

#Run the DRC
#check_design_rules

#Report a specific DRC violation
#report_drc_rules DFT_C1-1 
#Analyze the violation using schematic viewer
#analyze_drc_violation DFT_C1-1
#Fixing the violation DFT_C1-1
add_clocks clka -period 3ns

#Run the DRC
#check_design_rules

#Report a specific DRC violation
#report_drc_rules DFT_C1-1 
#Analyze the violation using schematic viewer
#analyze_drc_violation DFT_C1-1
#Fixing the violation DFT_C1-1
add_clock clkb -period 10ns

#Run the DRC
#check_design_rules

#Report the clocks
report_clocks

exit




