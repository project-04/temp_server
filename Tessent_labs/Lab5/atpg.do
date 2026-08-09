#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog ./design/c2.v

#Elaborate the design top
set_current_design c2

#Set the system mode to analysis
set_system_mode analysis

#Select the type of fault to be detected
set_fault_type stuck

#Add all faults to the fault list
add_faults -all

#Generate test patterns
create_patterns

#Reports faults of RE type
report_faults -class RE

exit -d
