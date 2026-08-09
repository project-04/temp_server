#Liberty files are needed for logical and physical netlist designs
set search_path "../"
set link_library " "

set_app_var enable_lint true

#configure_lint_tag -enable -tag "W224" -goal lint_rtl
#configure_lint_tag -enable -tag "W263" -goal lint_rtl

configure_lint_setup -goal lint_rtl

#analyze -verbose -format verilog "../rtl/apb_slave_interface.v"
#analyze -verbose -format verilog "../rtl/aux_interface.v"
#analyze -verbose -format verilog "../rtl/gpio_interface.v"
analyze -verbose -format verilog "../rtl/gpio_register.v"

#elaborate apb_slave_interface
#elaborate aux_interface
#elaborate gpio_interface
elaborate gpio_register

check_lint

#report_lint -verbose -file report_lint_apb_slave_interface.txt
#report_lint -verbose -file report_lint_aux_interface.txt
#report_lint -verbose -file report_lint_gpio_interface.txt
report_lint -verbose -file report_lint_gpio_register.txt


exit
