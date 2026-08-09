module top;

	import uvm_pkg::*;
	import avip_pkg::*;

     bit reset;

	bit clk;

always #5 clk=~clk;

     ahb_rst_if rst_if(clk);
	av_if master_if(clk);
	sl_if slave0_if(clk);
	sl_if slave1_if(clk);
	sl_if slave2_if(clk);
     
assign slave0_if.hresetn = rst_if.hresetn;
assign slave1_if.hresetn = rst_if.hresetn;
assign slave2_if.hresetn = rst_if.hresetn;

assign master_if.hresetn = rst_if.hresetn;

assign slave0_if.htrans = master_if.htrans;
assign slave1_if.htrans = master_if.htrans;
assign slave2_if.htrans = master_if.htrans;

assign slave0_if.hwrite = master_if.hwrite;
assign slave1_if.hwrite = master_if.hwrite;
assign slave2_if.hwrite = master_if.hwrite;

assign slave0_if.hburst = master_if.hburst;
assign slave1_if.hburst = master_if.hburst;
assign slave2_if.hburst = master_if.hburst;

assign slave0_if.hsize = master_if.hsize;
assign slave1_if.hsize = master_if.hsize;
assign slave2_if.hsize = master_if.hsize;

assign slave0_if.hwdata = master_if.hwdata;
assign slave1_if.hwdata = master_if.hwdata;
assign slave2_if.hwdata = master_if.hwdata;

assign slave0_if.haddr = master_if.haddr;
assign slave1_if.haddr = master_if.haddr;
assign slave2_if.haddr = master_if.haddr;

assign master_if.hready_out = (slave0_if.hready_out || slave1_if.hready_out || slave2_if.hready_out)? 1:0 ;

assign slave0_if.hsel = master_if.hsel;
assign slave1_if.hsel = master_if.hsel;
assign slave2_if.hsel = master_if.hsel;

assign master_if.hrdata = slave0_if.hrdata || slave1_if.hrdata || slave2_if.hrdata;
assign master_if.hresp = slave0_if.hresp || slave1_if.hresp || slave2_if.hresp;


decoder DUV ( .haddr(master_if.haddr),.hwdata(master_if.hwdata),.hsel(master_if.hsel));//,.s0data(slave0_if.hwdata),.s1data(slave1_if.hwdata),.s2data(slave2_if.hwdata));

/******************  MUX logic  *******************/
/*
always @(*)
begin
     if(DUV.hsel == 'b001)
         assign vif.hrdata = slave0_if.hrdata;
     else if(DUV.hsel == 'b010)
        assign  vif.hrdata = slave1_if.hrdata;
     else if(DUV.hsel == 'b100)
         assign vif.hrdata = slave2_if.hrdata;
end
*/

	initial begin
                     `ifdef VCS
                          $fsdbDumpvars(0, top);
                     `endif

		uvm_top.enable_print_topology=1;

		uvm_config_db#(virtual ahb_rst_if)::set(null,"*","rst_vif",rst_if);
		uvm_config_db#(virtual av_if)::set(null,"*","vif",master_if);
		uvm_config_db#(virtual sl_if)::set(null,"*","vif[0]",slave0_if);
		uvm_config_db#(virtual sl_if)::set(null,"*","vif[1]",slave1_if);
		uvm_config_db#(virtual sl_if)::set(null,"*","vif[2]",slave2_if);
		run_test;
	end

endmodule

