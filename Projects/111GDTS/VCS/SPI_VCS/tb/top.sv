`timescale 1ns/10ps
module top;
import spi_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
 
bit clock;
          
       always
 	#10 clock = ~clock;       
		
	spi_if wb_if(clock);
        spi_if sl_if(clock);

  spi_top  DUT(.wb_clk_i(wb_if.wb_clk_i), .wb_rst_i(wb_if.wb_rst_i), .wb_adr_i(wb_if.wb_adr_i), .wb_dat_i(wb_if.wb_dat_i), .wb_dat_o(wb_if.wb_dat_o), .wb_sel_i(wb_if.wb_sel_i),.wb_we_i(wb_if.wb_we_i), .wb_stb_i(wb_if.wb_stb_i), .wb_cyc_i(wb_if.wb_cyc_i), .wb_ack_o(wb_if.wb_ack_o), .wb_err_o(wb_if.wb_err_o), .wb_int_o(wb_if.wb_int_o),.ss_pad_o(sl_if.ss_pad_o), .sclk_pad_o(sl_if.sclk_pad_o), .mosi_pad_o(sl_if.mosi_pad_o), .miso_pad_i(sl_if.miso_pad_i));


initial 
	begin

			`ifdef VCS
			$fsdbDumpvars(0, top);
			`endif
	
			uvm_config_db#(virtual spi_if)::set(null,"*","vif_0",wb_if);
		        
			uvm_config_db#(virtual spi_if)::set(null,"*","vif_1",sl_if);
		fork
		run_test();
	//	#1900 $finish;
		join_any
	end
endmodule

