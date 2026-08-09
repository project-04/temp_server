#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

#to control wave errors
#configure_lint_tag -enable -tag "W224" -goal lint_rtl
#configure_lint_tag -enable -tag "W263" -goal lint_rtl

configure_lint_setup -goal lint_rtl

analyze -verbose -format verilog "../rtl/apb_slave_interface.v"
analyze -verbose -format verilog "../rtl/aux_interface.v"
analyze -verbose -format verilog "../rtl/gpio_interface.v"
analyze -verbose -format verilog "../rtl/gpio_register.v"
analyze -verbose -format verilog "../rtl/apb_gpio_top.v"

elaborate apb_gpio_top
check_lint

report_lint -verbose -file report_lint_apb_gpio_top.txt

exit
