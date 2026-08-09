`timescale 1ns/10ps

module top;

import uvm_pkg::*;

import axi_test_pkg::*;

bit clock;

always #5 clock= ~clock;

axi_if axi_if0(clock);
ahb_if ahb_if0(clock);


axi2ahb_bridge_top DUV (.aclk(clock),
			.aresetn(axi_if0.ARESETn),
			.hclk(clock),
			.hresetn(ahb_if0.HRESETn),
			.awid(axi_if0.AWID),
			.awaddr(axi_if0.AWADDR),
			.awlen(axi_if0.AWLEN),
			.awsize(axi_if0.AWSIZE),
			.awburst(axi_if0.AWBURST),
			.awvalid(axi_if0.AWVALID),
			.awready(axi_if0.AWREADY),
			.wid(axi_if0.AWID),
			.wdata(axi_if0.WDATA),
			.wstrb(axi_if0.WSTRB),
			.wlast(axi_if0.WLAST),
			.wvalid(axi_if0.WVALID),
			.wready(axi_if0.WREADY),
			.arid(axi_if0.ARID),
			.araddr(axi_if0.ARADDR),
			.arlen(axi_if0.ARLEN),
			.arsize(axi_if0.ARSIZE),
			.arburst(axi_if0.ARBURST),
			.arvalid(axi_if0.ARVALID),
			.arready(axi_if0.ARREADY),
			.bid(axi_if0.BID),
			.bresp(axi_if0.BRESP),
			.bvalid(axi_if0.BVALID),
			.bready(axi_if0.BREADY),
			.rid(axi_if0.RID),
			.rdata(axi_if0.RDATA),
			.rresp(axi_if0.RRESP),
			.rlast(axi_if0.RLAST),
			.rvalid(axi_if0.RVALID),
			.rready(axi_if0.RREADY),
			//.hbusreq(ahb_if0.),
			//.hlock(ahb_if0.),
			.haddr(ahb_if0.HADDR),
			.htrans(ahb_if0.HTRANS),
			.hwrite(ahb_if0.HWRITE),
			.hsize(ahb_if0.HSIZE),
			.hburst(ahb_if0.HBURST),
			.hwdata(ahb_if0.HWDATA),
			.hrdata(ahb_if0.HRDATA),
			.hready(ahb_if0.HREADY),
			.hresp(ahb_if0.HRESP),
			.hgrant(ahb_if0.HGRANT),
			.hmaster(ahb_if0.HMASTER));



initial
	begin
	
	uvm_config_db #(virtual axi_if)::set(null,"*","axi_if",axi_if0);
	uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_if",ahb_if0);

	run_test();

	end

endmodule
