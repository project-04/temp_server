interface av_if(input bit clk);

	logic hresetn;
	logic hwrite;
	logic[31:0] haddr;
	logic[2:0] hburst;
	logic[2:0] hsize;
	logic[1:0] htrans;
	logic[31:0] hwdata;
	logic[7:0] hlen;
	logic[31:0] hrdata;
	logic hready_out;
	logic [1:0]hresp;
	logic hsel;

	clocking mdcb@(posedge clk);
		input hresp;
		input hready_out;
		output hresetn;
		output hwrite;
		output haddr;
		output hburst;
		output hsize;
		output htrans;
		output hwdata;
		output hlen;
	endclocking

	clocking mmcb@(posedge clk);
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

	clocking sdcb@(posedge clk);
		input hresetn;
		input hwrite;
		output hready_out;
		output hresp;
		output hsel;
		output hrdata;
	endclocking

	clocking smcb@(posedge clk);
		input hwrite;
		input haddr;
		input hsize;
		input hrdata;
		input hwdata;
		input hready_out;
	endclocking

	modport MDMP(clocking mdcb);
	modport MMMP(clocking mmcb);
	modport SDMP(clocking sdcb);
	modport SMMP(clocking smcb);


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


endinterface

