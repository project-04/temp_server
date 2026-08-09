#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

#configure_lint_tag -enable -tag "W241" -goal lint_rtl
#configure_lint_tag -enable -tag "W240" -goal lint_rtl

configure_lint_setup -goal lint_rtl

analyze -verbose -format verilog "../uart_fifo.v"
analyze -verbose -format verilog "../tx.v"
analyze -verbose -format verilog "../rx.v"
analyze -verbose -format verilog "../uart_register_file.v"
analyze -verbose -format verilog "../uart_16550.v"

elaborate uart_16550

check_lint

report_lint -verbose -file report_lint_uart.txt





