interface av_if(input clk);

	wire hresetn;
	wire hwrite;
	wire[31:0] haddr;
	wire[2:0] hburst;
	wire[2:0] hsize;
	wire[1:0] htrans;
	wire[31:0] hwdata;
	wire[7:0] hlen;
	wire[31:0] hrdata;
	wire hready_out;
	wire hresp;
	wire [2:0]hsel;

	clocking mdcb@(posedge clk);
     default input #1 output #1;
		input hresp;
		input hready_out;
		input hresetn;
		output hwrite;
		output haddr;
		output hburst;
		output hsize;
		output htrans;
		output hwdata;
		output hlen;
	endclocking

	clocking mmcb@(posedge clk);
     default input #1 output #2;
		input hresetn;
		input hwrite;
		input haddr;
		input hburst;
		input hsize;
		input htrans;
		input hwdata;
		input hlen;
		input hsel;
		input hrdata;
		input hready_out;
		input hresp;
	endclocking

	
	modport MDMP(clocking mdcb);
	modport MMMP(clocking mmcb);

/*
property p_address_phase_stability;
  @(posedge clk) (hready_out == 0) |-> ##1 (haddr == $past(haddr) && htrans == $past(htrans) && hburst == $past(hburst));
endproperty
assert property (p_address_phase_stability);

property p_transfer_alignment;
  @(posedge clk) (htrans == 2'b10) |-> (haddr % (1 << hsize) == 0);
endproperty
assert property (p_transfer_alignment);


property p1;
  @(posedge clk) if(haddr>0)(hsize inside {0,1,2});
endproperty

assert property(p1);
*/

endinterface

