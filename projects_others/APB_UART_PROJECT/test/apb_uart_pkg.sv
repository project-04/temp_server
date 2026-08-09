
package apb_uart_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "LINE_CONTROL_REG.sv";
	`include "LINE_STATUS_REG.sv";
	`include "INTERRUPT_ENABLE_REG.sv";
	`include "MODEM_CONTROL_REG.sv";
	`include "FIFO_CONTROL_REG.sv";
	`include "MODEM_STATUS_REG.sv";	
	`include "reg_block.sv";

	`include "apb_uart_agt_config.sv"; 
	`include "apb_uart_env_config.sv";
	`include "apb_uart_trans.sv"; 

	`include "apb_uart_sequence.sv"; 
	`include "apb_uart_sequencer.sv"; 
	`include "apb_uart_driver.sv"; 
	`include "apb_uart_monitor.sv"; 
	`include "apb_uart_agent.sv"; 
	`include "apb_uart_agent_top.sv"; 

	`include "apb_uart_scoreboard.sv"; 
	`include "apb_uart_environment.sv"; 
	`include "apb_uart_test.sv"; 
	
endpackage
		
