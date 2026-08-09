#Set the context to DFT & sub-context to rtl
set_context dft -rtl

#Create & set the TSDB directory
set_tsdb_output_directory TSDB

#Read the cell library files
read_cell_library adk.tcelllib

#Read the design source codes & memory files
set_design_sources -format verilog -y {mem  rtl} -extension v
set_design_sources -format tcd_memory -y {mem } -extension tcd_mem_lib
read_verilog ./design/blockB.v

#Elaborate the design top
set_current_design blockB

#Set the design level to sub-block level
set_design_level sub_block

#Specify the DFT requirements
set_dft_specification_requirements -memory_test on 

add_clock CLK -period 10ns -label clkb

#Validate the DFT requirements
check_design_rules 

#Create & report the DFT specification
set dftspec [create_dft_specification]
report_config_data $dftspec

#Display the DFT specification
display_specification

#Insert the DFT instruments
process_dft_specification

#Display the visualizer
open_visualizer

#Extract the ICL 
extract_icl

#Create & report the pattern specification 
set PatternSpec [create_pattern_specification]
report_config_data $PatternSpec

#Process the patterns
process_patterns_specification

#Set up the simulation library
set_simulation_library_sources -v adk.v

#Run & check the  simulation 
run_testbench_simulations
check_testbench_simulations -report_status
