#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog ./design/c2.v

#Elaborate the design top
set_current_design c2

#Set the system mode to analysis
set_system_mode analysis

#################################################################
#Procedure to run test pattern generation and  run fault simulation 
#Reading the test pattern from an external file
set_pattern_source external c2_01010_1.pat

#Add all faults to the fault list
add_faults -all

#Simulate test patterns
simulate_patterns

#Report statistics
report_statistics

#Report faults
report_faults -class DS

#Reset state
reset_state

#########################################################################
#################################################################
#Procedure to run test pattern generation and  run fault simulation 
#Reading the test pattern from an external file
set_pattern_source external c2_11011_2.pat

#Add all faults to the fault list
add_faults -all

#Simulate test patterns
simulate_patterns

#Report statistics
report_statistics

#Report faults
report_faults -class DS

#Reset state
reset_state

#########################################################################

#################################################################
#Procedure to run test pattern generation and  run fault simulation 
#Reading the test pattern from an external file
set_pattern_source external c2_00110_3.pat

#Add all faults to the fault list
add_faults -all

#Simulate test patterns
simulate_patterns

#Report statistics
report_statistics

#Report faults
report_faults -class DS

#Reset state
reset_state

#########################################################################


exit -d
