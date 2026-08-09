#Set the context to patterns & sub-context to scan
set_context patterns -scan

#Read the cell library files
read_cell_library adk.tcelllib

#Read the scan inserted netlist 
read_verilog scan_stitched.v

#Define the clocks
analyze_control_signals

#Elaborate the design top
set_current_design seq_det

#Read the atpg setup
dofile seq_det_atpg.dofile 

#Used to run the TCL procedure from the atpg.dofile
tessent_scan_setup

#Run the DRC
check_design_rules

#Displays a list of all clocks
report_clocks

#Generate the test patterns
create_patterns

#Displays a statistics report
report_statistics

#Displays faults for selected fault class
report_faults -class DS

report_scan_volume 

#Write the patterns to an ASCII File
write_patterns patterns.ascii -ascii -replace






