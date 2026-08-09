interface sl_if(input bit clk);

	bit hresetn;
	wire hwrite;
	wire[31:0] haddr;
	wire[2:0] hburst;
	wire[2:0] hsize;
	wire[1:0] htrans;
	wire[31:0] hwdata;
//	wire[7:0] hlen;
	wire[31:0] hrdata;
	wire hready_out;
	wire [1:0]hresp;
	wire [1:0]hsel;

	clocking sdcb@(posedge clk);
     default input #1 output #1;
		input hresetn;
		input hwrite;
		output hready_out;
		output hresp;
		output hsel;
		output hrdata;
	endclocking

	clocking smcb@(posedge clk);
     default input #1 output #1;
		input hresetn;
		input hwrite;
		input haddr;
          input hresp;
		input hsize;
		input hrdata;
          input hburst;
		input hwdata;
		input hready_out;
	endclocking

	modport SDMP(clocking sdcb);
	modport SMMP(clocking smcb);



endinterface


