#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes 
read_verilog design/c1.v

#Elaborate the design top
set_current_design c1


#Set the system mode to analysis mode
set_system_mode analysis

#Procedure to run test pattern generation
#Add all faults to the fault list
add_faults -all

#Generates test patterns
create_patterns

#Save the test patterns to an ASCII file
write_patterns patterns.ascii -ascii -replace


#Reports all faults
report_faults  

exit -d
