#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

#configure_lint_tag -enable -tag "W241" -goal lint_rtl
#configure_lint_tag -enable -tag "W240" -goal lint_rtl

configure_lint_setup -goal lint_rtl

analyze -verbose -format verilog "./rtl/picorv32.v"
analyze -verbose -format verilog "./rtl/picorv32_pcpi_div.v"
analyze -verbose -format verilog "./rtl/picorv32_pcpi_fast_mul.v"
analyze -verbose -format verilog "./rtl/picorv32_pcpi_mul.v"
analyze -verbose -format verilog "./rtl/picorv32_regs.v"
analyze -verbose -format verilog "./rtl/spimemio.v"
analyze -verbose -format verilog "./rtl/simpleuart.v"
analyze -verbose -format verilog "./rtl/raven_spi.v"
analyze -verbose -format verilog "./rtl/spi_slave.v"
analyze -verbose -format verilog "./rtl/raven_soc.v"

elaborate raven_soc

check_lint

report_lint -verbose -file report_lint_riscv.txt
