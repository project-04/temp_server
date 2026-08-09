//Set the context to patterns and sub context to scan
set_context patterns -scan

//Read the design source codes
read_verilog ./design/c2_mod.v

//Elaborate the design top
set_current_design c2


//change from setup mode to analysis mode
set_system_mode analysis


//fault type is selected for stuck at fault
set_fault_type stuck


//add all faults to the fault list
add_faults -all

//genertes test patterns to detect the faults
create_patterns

report_statistics

//reports all faults of category  redundant using switch
report_faults -class RE
exit -d
