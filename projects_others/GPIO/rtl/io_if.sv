

interface io_if(input bit clk);


	bit [31:0]	in_pad_i;
	bit [31:0]	io_pad;
	
	bit [31:0]	oen_padoe_o;
	bit [31:0]	out_pad;

	clocking wr_drv_cb @(posedge clk);
	
		default input#1 output#1;
		
			
		
		
			