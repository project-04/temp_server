#Set the context to patterns and sub context to scan
set_context patterns -scan

#Read the design source codes
read_verilog ./design/c1_mod.v

#Elaborate the design top
set_current_design c1

#Set the system mode to analysis
set_system_mode analysis

#Select the fault type to stuck at fault
set_fault_type stuck

#Add all faults to the fault list
add_faults -all

#Genertes test patterns
create_patterns

#Reports faults of RE type
report_faults -class RE

exit -d
