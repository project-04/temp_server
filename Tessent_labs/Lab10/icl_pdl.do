#Set the context to DFT
set_context dft -rtl

#Read the design source codes
read_verilog design/PLL.v

#Elaborate the design top
set_current_design PLL

#Create the .icl file as per the below syntax
#Module PLL {
#       DataInPort CTRL[7:0];
#       DataInPort RESET;
#       DataOutPort LOCK;

#}

#Read the .icl file with a switch -force
read_icl PLL_Models/PLL.icl -force

#Elaborate the design top
set_current_design PLL

#Create a .pdl file 

#Set the context to patterns
set_context patterns -ijtag

#Set the design level to chip
set_design_level chip

#Verify the ICL ports
get_icl_ports

#Run DRC
check_design_rules

#Create a PDL pattern set
open_pattern_set example
iWrite CTRL[0] 0b1
iApply
iWrite CTRL[1] 0b1
iWrite RESET 0b0
iApply
iRunLoop 100
iWrite RESET 0b1
iApply
close_pattern_set
write_patterns PLL_Models/PLL.pdl -pdl

exit

