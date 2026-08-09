#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog ./design/c1.v

#Elaborate the design top
set_current_design c1

#Set the system mode to analysis
set_system_mode analysis

#Run fault simulation for abcd =  0000
set_pattern_source external c1_0.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0001
set_pattern_source external c1_1.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0010
set_pattern_source external c1_2.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

//Run fault simulation for abcd =  0011
set_pattern_source external c1_3.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0100
set_pattern_source external c1_4.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0101
set_pattern_source external c1_5.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0110
set_pattern_source external c1_6.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  0111
set_pattern_source external c1_7.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1000
set_pattern_source external c1_8.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1001
set_pattern_source external c1_9.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1010
set_pattern_source external c1_10.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1011
set_pattern_source external c1_11.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1100
set_pattern_source external c1_12.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1101
set_pattern_source external c1_13.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1110
set_pattern_source external c1_14.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

#Run fault simulation for abcd =  1111
set_pattern_source external c1_15.ascii
add_faults -All
simulate_patterns
report_statistics
report_faults -class DS
reset state

exit -d
