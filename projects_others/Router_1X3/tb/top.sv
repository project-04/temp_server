module top;
	import uvm_pkg::*;
	import router_package::*;
	`include "uvm_macros.svh"

	bit clock = 0;
	
	always
		#5 clock = ~clock;

	router_if src_if_0(clock);
	router_if dest_if_0(clock);
	router_if dest_if_1(clock);
	router_if dest_if_2(clock);

	router dut(.clock(clock),
		   .resetn(src_if_0.resetn),
		   .data_in(src_if_0.data_in),
		   .pkt_valid(src_if_0.pkt_valid),
		   .busy(src_if_0.busy),
	   	   .err(src_if_0.error),
		   .read_enb_0(dest_if_0.read_enb),.read_enb_1(dest_if_1.read_enb),.read_enb_2(dest_if_2.read_enb),
		   .data_out_0(dest_if_0.data_out),.data_out_1(dest_if_1.data_out),.data_out_2(dest_if_2.data_out),
		   .vld_out_0(dest_if_0.valid_out),.vld_out_1(dest_if_1.valid_out),.vld_out_2(dest_if_2.valid_out));



	initial 
		begin 
			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif

			uvm_config_db #(virtual router_if)::set(null,"*","src_if_0",src_if_0);
			uvm_config_db #(virtual router_if)::set(null,"*","dest_if_0",dest_if_0);
			uvm_config_db #(virtual router_if)::set(null,"*","dest_if_1",dest_if_1);
			uvm_config_db #(virtual router_if)::set(null,"*","dest_if_2",dest_if_2);

			run_test("test");
		end
endmodule 
