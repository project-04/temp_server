#Set context to patterns and sub-context to scan
set_context patterns -scan

#Read the design source codes
read_verilog design/c1.v

#Elaborate the design top
set_current_design c1

#Set the system mode to analysis
set_system_mode analysis

#Test patterns are read from an external file
set_pattern_source external c1_1.pat

#Adds all the faults to the fault list
add_faults -All

#Simulate patterns
simulate_patterns

#Reports statistics
report_statistics

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

reset_state
set_pattern_source external c1_16.pat
add_faults -All
simulate_patterns
report_statistics

exit -d
