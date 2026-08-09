#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog design/c1.v

#Elaborate the design top
set_current_design c1

#Set the system mode to analysis
set_system_mode analysis

#Pattern stored in external file are used for simulation
set_pattern_source external c1_1.pat

#Add all faults to the fault list
add_faults -All

#Simulate patterns
simulate_patterns

#Report statistics
report_statistics

#Reset state
reset_state

set_pattern_source external c1_2.pat
add_faults -All
simulate_patterns
report_statistics
reset_state

set_pattern_source external c1_4.pat
add_faults -All
simulate_patterns
report_statistics
reset_state

set_pattern_source external c1_8.pat
add_faults -All
simulate_patterns
report_statistics
exit -d
