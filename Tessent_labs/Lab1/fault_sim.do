#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog design/c1.v

#Elaborate the design top
set_current_design c1

#Set the system mode to analysis
set_system_mode analysis

#Procedure to run test pattern generation and  run fault simulation for f/1

#Reading the test pattern from an external file
set_pattern_source external c1_pat_f1.ascii

#Add all faults to the fault list
add_faults -All

#Simulate test patterns
simulate_patterns

#Report statistics
report_statistics

#Reports faults
report_faults -class DS

#Reset state
reset state


#Procedure to run test pattern generation and  run fault simulation for h/1

#Reading the test pattern from an external file
set_pattern_source external c1_pat_h1.ascii

#Add all faults to the fault list
add_faults -All

#Simulate test patterns
simulate_patterns

#Report statistics
report_statistics

#Reports faults
report_faults -class DS

#Reset state
reset state

exit -d
