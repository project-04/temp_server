
vlog axi_tb_top.sv

vsim -novopt top +UVM_VERBOSITY=UVM_HIGH +UVM_TESTNAME=axi_write_test

add wave -position insertpoint sim:/top/intf/*
