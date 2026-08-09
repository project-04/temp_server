module apb_gpio_top_tb;

	reg PCLK,PRESET,PSEL, PENABLE, PWRITE, ext_clk_pad_i;
	reg [31:0] PADDR, PWDATA, aux_in;
	wire [31:0] PRDATA;
	wire PREADY,IRQ;
	wire [31:0] IO_pad;
	
	reg [31:0] oe, temp_IO_pad;
	
	parameter RGPIO_IN	  = 32'h0;  //0000_0000
        parameter RGPIO_OUT	  = 32'h4;  //0000_0100
  	parameter RGPIO_OE	  = 32'h8;  //0000_1000
	parameter RGPIO_INTE	  = 32'hc;  //0000_1100
	parameter RGPIO_PTRIG	  = 32'h10; //0001_0000
        parameter RGPIO_AUX	  = 32'h14; //0001_0100
        parameter RGPIO_CTRL	  = 32'h18; //0001_1000
        parameter RGPIO_INTS	  = 32'h1c; //0001_1100
        parameter RGPIO_ECLK	  = 32'h20; //0010_0000
        parameter RGPIO_NEC	  = 32'h24; //0010_0100

	apb_gpio_top DUV(
		.PCLK(PCLK),
		.PRESET(PRESET),
		.PSEL(PSEL), 
		.PENABLE(PENABLE), 
		.PWRITE(PWRITE), 
		.ext_clk_pad_i(ext_clk_pad_i),
		.PADDR(PADDR),
		.PWDATA(PWDATA), 
		.aux_in(aux_in),
		.PRDATA(PRDATA),
		.PREADY(PREADY),
		.IRQ(IRQ),
		.IO_pad(IO_pad));
		
	
	initial forever #1 PCLK = ~PCLK;

	initial forever #100 ext_clk_pad_i = ~ext_clk_pad_i;

	task initialize();
	begin
		{PCLK, PRESET, PSEL, PENABLE, PWRITE, ext_clk_pad_i, PADDR, PWDATA, aux_in, oe, temp_IO_pad} = 0;
	end
	endtask
	
	task reset;
	begin
		@(negedge PCLK);
		PRESET = 1'b1;
		$display("\n\n%0t -> ----------------------------reset---------------------------- \n\n", $time);
		
		@(negedge PCLK);
		PRESET = 1'b0;
	end
	endtask
	
	task sys_clk_IO_pad(input reg [31:0] IO);
	begin
		@(negedge PCLK);
		temp_IO_pad = IO;
		$display("%0t -> sys_clk_IO_pad = %0h", $time, temp_IO_pad);
	end
	endtask

	task sys_clk_aux_in(input reg [31:0] aux);
	begin
		@(negedge PCLK);
		aux_in = aux;
		$display("%0t -> sys_clk_aux_in = %0h", $time, aux_in);
	end
	endtask
	
	task eclk_pos_IO_pad(input reg [31:0] IO);
	begin
		@(negedge ext_clk_pad_i);
		temp_IO_pad = IO;
		$display("%0t -> eclk_pos_IO_pad = %0h", $time, temp_IO_pad);
	end
	endtask
	
	task eclk_neg_IO_pad(input reg [31:0] IO);
	begin
		@(posedge ext_clk_pad_i);
		temp_IO_pad = IO;
		$display("%0t -> eclk_neg_IO_pad = %0h", $time, temp_IO_pad);
	end
	endtask
	
	task apb_write_fsm(input reg [31:0] addr, data);
	begin
		@(negedge PCLK);
	       	PWRITE = 1'b1;
	       	PADDR  = addr;
		PWDATA = data;
		PSEL = 1'b1;
		PENABLE = 1'b0;
		
		@(negedge PCLK)
		PSEL = 1'b1;
		PENABLE = 1'b1;
		
		wait(PREADY);
		
		@(negedge PCLK);
	       	//PWRITE = 1'b0;
		PSEL = 1'b0;
		PENABLE = 1'b0;
		
		apb_read_fsm(addr);
	end
	endtask

	task apb_read_fsm(input reg [31:0] addr);
	begin
		//wait(IRQ);
		@(negedge PCLK);
	       	PWRITE = 1'b0;
	       	PADDR  = addr;
		PSEL = 1'b1;
		PENABLE = 1'b0;

		@(negedge PCLK);
		PSEL = 1'b1;
		PENABLE = 1'b1;
				
		wait(PREADY);
		$display("%0t -> PADDR=%h  PRDATA=%h IRQ=%0b", $time, addr, PRDATA, IRQ);
		
		@(negedge PCLK);
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
	endtask
	
	//assign IO_pad = ~oe ? temp_IO_pad : 32'hzzzz_zzzz;
	
   	assign IO_pad[0]=~oe[0]?temp_IO_pad[0]:1'bz;
   	assign IO_pad[1]=~oe[1]?temp_IO_pad[1]:1'bz;
   	assign IO_pad[2]=~oe[2]?temp_IO_pad[2]:1'bz;
   	assign IO_pad[3]=~oe[3]?temp_IO_pad[3]:1'bz;
   	assign IO_pad[4]=~oe[4]?temp_IO_pad[4]:1'bz;
   	assign IO_pad[5]=~oe[5]?temp_IO_pad[5]:1'bz;
   	assign IO_pad[6]=~oe[6]?temp_IO_pad[6]:1'bz;
   	assign IO_pad[7]=~oe[7]?temp_IO_pad[7]:1'bz;
   	assign IO_pad[8]=~oe[8]?temp_IO_pad[8]:1'bz; 
   	assign IO_pad[9]=~oe[9]?temp_IO_pad[9]:1'bz;
   	assign IO_pad[10]=~oe[10]?temp_IO_pad[10]:1'bz;
   	assign IO_pad[11]=~oe[11]?temp_IO_pad[11]:1'bz;
   	assign IO_pad[12]=~oe[12]?temp_IO_pad[12]:1'bz;
   	assign IO_pad[13]=~oe[13]?temp_IO_pad[13]:1'bz;
   	assign IO_pad[14]=~oe[14]?temp_IO_pad[14]:1'bz; 
   	assign IO_pad[15]=~oe[15]?temp_IO_pad[15]:1'bz;
   	assign IO_pad[16]=~oe[16]?temp_IO_pad[16]:1'bz;
   	assign IO_pad[17]=~oe[17]?temp_IO_pad[17]:1'bz;
   	assign IO_pad[18]=~oe[18]?temp_IO_pad[18]:1'bz;
   	assign IO_pad[19]=~oe[19]?temp_IO_pad[19]:1'bz;
   	assign IO_pad[20]=~oe[20]?temp_IO_pad[20]:1'bz;
   	assign IO_pad[21]=~oe[21]?temp_IO_pad[21]:1'bz;
   	assign IO_pad[22]=~oe[22]?temp_IO_pad[22]:1'bz;
   	assign IO_pad[23]=~oe[23]?temp_IO_pad[23]:1'bz;
   	assign IO_pad[24]=~oe[24]?temp_IO_pad[24]:1'bz;
   	assign IO_pad[25]=~oe[25]?temp_IO_pad[25]:1'bz;
   	assign IO_pad[26]=~oe[26]?temp_IO_pad[26]:1'bz;
   	assign IO_pad[27]=~oe[27]?temp_IO_pad[27]:1'bz;
   	assign IO_pad[28]=~oe[28]?temp_IO_pad[28]:1'bz;
   	assign IO_pad[29]=~oe[29]?temp_IO_pad[29]:1'bz;
   	assign IO_pad[30]=~oe[30]?temp_IO_pad[30]:1'bz;
   	assign IO_pad[31]=~oe[31]?temp_IO_pad[31]:1'bz;
	
		
	initial 
	begin
		initialize();
		#40;
        	
        	
        	/*
		reset();
        	$display("\n########################## GPIO as POLLED INPUTS ########################## \n");
		oe = 32'h0000_0000;
		sys_clk_IO_pad(32'hff00_ffff);
		
		apb_write_fsm(RGPIO_OUT, 	32'h0000_0000);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'h0000_0000);
		apb_write_fsm(RGPIO_PTRIG, 	32'h0000_0000);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0000);		
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'h0000_0000);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		sys_clk_IO_pad(32'hffff_00ff);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		

		#200;
		reset();
		$display("\n########################## GPIO as INPUTS in INTERRUPT MODE ########################## \n");
		oe = 32'h0000_0000;
		sys_clk_IO_pad(32'hff00_ffff);
		
		apb_write_fsm(RGPIO_OUT, 	32'h0000_0000);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_PTRIG, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0001);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'h0000_0000);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		sys_clk_IO_pad(32'hffff_00ff);
		wait(IRQ);
		$display("%0t -> IRQ HIGH", $time);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		#100;
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		#100;
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		
	
		#200;
		reset();
		$display("\n########################## GPIO as OUTPUTS ########################## \n");
		oe = 32'hffff_ffff;
		sys_clk_IO_pad(32'hff00_ffff);
		
		apb_write_fsm(RGPIO_OUT, 	33'hf0f0_f0f0);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'h0000_0000);
		apb_write_fsm(RGPIO_PTRIG, 	32'h0000_0000);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0000);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'h0000_0000);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		sys_clk_IO_pad(32'hffff_00ff);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		

		#200;
		reset();
		$display("\n########################## GPIO as AUXILIRY INPUTS ########################## \n");
		oe = 32'hffff_ffff;
		sys_clk_aux_in(32'hf00f_f00f);
		//sys_clk_IO_pad(32'hff00_ffff);
		
		apb_write_fsm(RGPIO_OUT, 	32'h0000_0000);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'h0000_0000);
		apb_write_fsm(RGPIO_PTRIG, 	32'h0000_0000);
		apb_write_fsm(RGPIO_AUX, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0000);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'h0000_0000);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		//sys_clk_IO_pad(32'hffff_00ff);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		
		*/
		#200;
		reset();
		$display("\n########################## GPIO as BI-DIRECTIONAL I/O ########################## \n");
		oe = 32'hffff_0000;
		//sys_clk_aux_in(32'hf00f_f00f);
		sys_clk_IO_pad(32'h1111_1111);
		
		apb_write_fsm(RGPIO_OUT, 	32'h2222_2222);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'h0000_0000);
		apb_write_fsm(RGPIO_PTRIG, 	32'h0000_0000);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0000);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'h0000_0000);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		repeat(5)
		begin
			apb_write_fsm(RGPIO_IN, 	oe);
			//oe = ~oe;
			//apb_write_fsm(RGPIO_OE, 	oe);
			#100;
		end
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		
		
		/*
		#200;
		reset();
        	$display("\n########################## GPIO as POLLED INPUTS with eclk ########################## \n");
		oe = 32'h0000_0000;
		sys_clk_IO_pad(32'hff00_ffff);
		eclk_pos_IO_pad(32'h2222_2222);
		
		apb_write_fsm(RGPIO_OUT, 	32'h0000_0000);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'h0000_0000);
		apb_write_fsm(RGPIO_PTRIG, 	32'h0000_0000);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0000);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		//sys_clk_IO_pad(32'hffff_00ff);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		
		
		
		#200;
		reset();
        	$display("\n########################## GPIO as INPUTS in INTERRUPT MODE with eclk ########################## \n");
		oe = 32'h0000_0000;
		//sys_clk_IO_pad(32'hff00_ffff);
		eclk_pos_IO_pad(32'hf000_ffff);
		
		apb_write_fsm(RGPIO_OUT, 	32'h0000_0000);
		apb_write_fsm(RGPIO_OE, 	oe);
		apb_write_fsm(RGPIO_INTE, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_PTRIG, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_AUX, 	32'h0000_0000);
		apb_write_fsm(RGPIO_CTRL, 	32'h0000_0001);
		apb_write_fsm(RGPIO_INTS, 	32'h0000_0000);
		apb_write_fsm(RGPIO_ECLK, 	32'hffff_ffff);
		apb_write_fsm(RGPIO_NEC, 	32'h0000_0000);
		#40;
		eclk_pos_IO_pad(32'hffff_000f);
		//sys_clk_IO_pad(32'hfff0_00ff);
		wait(IRQ);
		$display("%0t -> IRQ HIGH", $time);
		apb_read_fsm(RGPIO_CTRL);
		apb_read_fsm(RGPIO_INTS);
		*/
		
		#50; $finish;
	end
	
	initial $monitor("%t -> IO_pad=%h",$time, IO_pad);
	
endmodule
module apb_slave_interface_tb();
	reg PCLK,PRESET, PSEL,PENABLE, PWRITE;
	reg [31:0] PADDR, PWDATA, gpio_dat_o;
	reg gpio_inta_o;
	wire sys_clk, sys_rst, gpio_we;
	wire [31:0] gpio_addr, gpio_dat_i, PRDATA;
	wire PREADY, IRQ;
	
	parameter IDLE = 2'b00, SETUP = 2'b01, ENABLE = 2'b10;

	apb_slave_interface ASI (.PCLK(PCLK),
				.PRESET(PRESET),
				.PSEL(PSEL),
				.PENABLE(PENABLE),
				.PWRITE(PWRITE),
				.PADDR(PADDR),
				.PWDATA(PWDATA),
				.gpio_inta_o(gpio_inta_o),
				.sys_clk(sys_clk),
				.sys_rst(sys_rst),
				.gpio_we(gpio_we),
				.gpio_addr(gpio_addr),
				.gpio_dat_i(gpio_dat_i),
				.gpio_dat_o(gpio_dat_o),
				.PRDATA(PRDATA),
				.PREADY(PREADY),
				.IRQ(IRQ));

	initial 
	begin
		PCLK = 1'b0;
		forever #5 PCLK = ~PCLK;
	end
	
	task initialize();
	begin
		{PCLK, PRESET, PSEL, PENABLE, PWRITE, PADDR, PWDATA, gpio_dat_o, gpio_inta_o} = 0;
	end
	endtask

	task reset;
	begin
		@(negedge PCLK);
		PRESET = 1'b1;
		
		@(negedge PCLK);
		PRESET = 1'b0;
	end
	endtask

	task apb_write_fsm;
	begin
		@(negedge PCLK);
	       	PWRITE = 1'b1;
		PSEL = 1'b1;
		PENABLE = 1'b0;
		
		@(negedge PCLK);
		PENABLE = 1'b1;
		
		wait(PREADY);
		
		@(negedge PCLK);
	       	PWRITE = 1'b0;
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
	endtask


	task apb_read_fsm;
	begin
		@(negedge PCLK);
	       	PWRITE = 1'b0;
		PSEL = 1'b1;
		PENABLE = 1'b0;

		@(negedge PCLK);
		PENABLE = 1'b1;
				
		wait(PREADY);
		
		@(negedge PCLK);
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
	endtask

	initial 
	begin
		initialize();
		reset;
		PADDR  = 32'h01ab_cdef;
		PWDATA = 32'h1111_0000;
		gpio_inta_o = 1'b1;
		gpio_dat_o  = 32'h1100_0011;
		apb_write_fsm;
		apb_read_fsm;
		#50; $finish;
	end
	
	initial 
	begin
		$monitor("PCLK=%0h, PRESET=%0h, PSEL=%0h, PENABLE=%0h, PWRITE=%0h, PADDR=%0h, PWDATA=%0h, PRDATA=%0h, PREADY=%0h, IRQ=%0h \ngpio_dat_o=%0h, gpio_inta_o=%0h, sys_clk=%0h, sys_rst=%0h, gpio_we=%0h, gpio_addr=%0h, gpio_dat_i=%0h \n",PCLK,PRESET, PSEL,PENABLE, PWRITE, PADDR, PWDATA, PRDATA, PREADY, IRQ, gpio_dat_o, gpio_inta_o, sys_clk, sys_rst, gpio_we, gpio_addr, gpio_dat_i);
	end
endmodule
module aux_interface_tb();
	reg sys_clk, sys_rst;
	reg [31:0] aux_in;
	wire [31:0] aux_i;

	aux_interface AI (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.aux_in(aux_in),
			.aux_i(aux_i));

	initial 
	begin
		sys_clk = 1'b0;
		forever #5 sys_clk = ~sys_clk;
	end

	task reset;
	begin
		@(negedge sys_clk);
		sys_rst = 1'b1;
		
		@(negedge sys_clk);
		sys_rst = 1'b0;
	end
	endtask

	initial 
	begin
		reset;
		aux_in = 32'h0123_4567;
		#30 $finish;
	end

	initial 
	begin
		$monitor("sys_clk=%d, sys_rst=%d, aux_in=%h, aux_i=%h",sys_clk, sys_rst, aux_in, aux_i);
	end
endmodule
module gpio_interface_tb();
	reg ext_clk_pad_i;
	reg [31:0] out_pad_o, oen_padoe_o;
	wire [31:0] IO_pad, in_pad_i;
	wire gpio_eclk;

	gpio_interface GI (.ext_clk_pad_i(ext_clk_pad_i),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o),
			.in_pad_i(in_pad_i),
			.IO_pad(IO_pad),
			.gpio_eclk(gpio_eclk));
		
	initial 
	begin
		ext_clk_pad_i = 1'b0;
		forever #5 ext_clk_pad_i = ~ext_clk_pad_i;
	end

	task initialize();
	begin
		out_pad_o     = 32'h0000_0000;
		oen_padoe_o   = 32'h0000_0000;
	end
	endtask

	task inputs(input [31:0] a, b);
	begin
		out_pad_o   = a;
		oen_padoe_o = b;
	end
	endtask

	initial
	begin
		initialize();
		
		#10;
		inputs(32'hffff_0000, 32'hffff_ffff);
		
		#20;
		$finish;
	end

	initial 
	begin
		$monitor("ext_clk_pad_i=%0h, out_pad_o=%0h, oen_padoe_o=%0h, IO_pad=%0h, in_pad_i=%0h, gpio_eclk=%0h \n", ext_clk_pad_i, out_pad_o, oen_padoe_o, IO_pad, in_pad_i, gpio_eclk);
	end
endmodule
module gpio_register_tb();
	reg sys_clk, sys_rst;
	reg gpio_we;
	reg [31:0] gpio_addr, gpio_dat_i, in_pad_i;
	reg gpio_eclk;
	reg [31:0] aux_i;
	wire gpio_inta_o;
	wire [31:0] gpio_dat_o;
	wire [31:0] out_pad_o;
	wire [31:0] oen_padoe_o;
	


	gpio_register GR (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.gpio_we(gpio_we),
			.gpio_addr(gpio_addr),
			.gpio_dat_i(gpio_dat_i),
			.in_pad_i(in_pad_i),
			.gpio_eclk(gpio_eclk),
			.aux_i(aux_i),
			.gpio_inta_o(gpio_inta_o),
			.gpio_dat_o(gpio_dat_o),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o));
			
			

	parameter RGPIO_IN	  = 32'h0;  //0000_0000
        parameter RGPIO_OUT	  = 32'h4;  //0000_0100
  	parameter RGPIO_OE	  = 32'h8;  //0000_1000
	parameter RGPIO_INTE	  = 32'hc;  //0000_1100
	parameter RGPIO_PTRIG	  = 32'h10; //0001_0000
        parameter RGPIO_AUX	  = 32'h14; //0001_0100
        parameter RGPIO_CTRL	  = 32'h18; //0001_1000
        parameter RGPIO_INTS	  = 32'h1c; //0001_1100
        parameter RGPIO_ECLK	  = 32'h20; //0010_0000
        parameter RGPIO_NEC	  = 32'h24; //0010_0100
        parameter RGPIO_CTRL_INTE = 1'b0;
        parameter RGPIO_CTRL_INTS = 1'b1;
	
	// GENERATE THE SYSTEM CLOCK
	always #5 sys_clk = ~sys_clk;

	//GENERATE THE GPIO CLOCK
	always #5 gpio_eclk = ~gpio_eclk;
	
	//GNERETE THE ACTIVE RESET USING TASK 
	task reset;
	begin
		@(negedge sys_clk);
		sys_rst = 1'b1;
		@(negedge sys_clk);
		sys_rst = 1'b0;
	end
	endtask
	
	//INITIALIZE THE INPUTS USING THE TASK
	task initialize;
	begin
		{sys_clk, gpio_we, gpio_addr, gpio_dat_i, in_pad_i, aux_i, gpio_eclk} = 1'b0;
	end
	endtask
	
	//DRIVNG THE INPUTS USING TASK
	task inputs(input [31:0] a,b,c,d, input e);
	begin
		@(posedge sys_clk)
		gpio_addr = a;
		gpio_dat_i = b;
		in_pad_i = c;
		aux_i = d;
		gpio_we = e;
	end
	endtask

	//DRIVE ALL THE TASKS IN INITIAL BLOCK
	initial 
	begin
		initialize;
		reset;
		//     gpio_addr	gpio_dat_i	in_pad_i	aux_i		gpio_we
		
		inputs(RGPIO_NEC, 	32'h19, 	32'h1220, 	32'h0010, 	1'b1); 
		//the gpio_addr is RGPIO_NEC that data_reg will store the rgpio_nec data and 
		//rgpio_nec will get the data from gpio_dat_i
		
		inputs(RGPIO_ECLK, 	32'h19, 	32'h122, 	32'h10, 	1'b1); 
		//The gpio_addr is RGPIO_ECLK the data_reg will store the rgpio_eclk data and 
		//rgpio_nec will get the data from gpio_dat_i
		
		inputs(RGPIO_IN, 	32'h19, 	32'h120, 	32'h00, 	1'b1); 
		// The gpio_addr is RGPIO_IN the data_reg will store the rgpio_in data and 
		//rgpio_in will get the data from in_mux and the in_mux will work depending on 
		//rgpio_eclk as well as external_clk with in_pad_i
		
		inputs(RGPIO_OUT, 	32'h23, 	32'h00, 	32'h00, 	1'b1); 
		// The gpio_addr is RGPIO_OUT the data_reg will store the rgpio_out data and 
		//rgpio_out will get the data from gpio_dat_i
		
		inputs(RGPIO_OE, 	32'h123, 	32'h00, 	32'h01, 	1'b1); 
		// The gpio_addr is RGPIO_OE the data_reg will store the rgpio_oe adata and 
		//rgpio_oe will get the data from gpio_dat_i
		
		inputs(RGPIO_INTE, 	32'h0123, 	32'h00, 	32'h00, 	1'b1); 
		// The gpio_addr is RGPIO_INTE the data_reg will store the rgpio_inte and 
		//rgpio_inte will get the data from gpio_dat_i
		
		inputs(RGPIO_PTRIG,	32'h0112,	32'h0010,	32'h999f,	1'b1); 
		// The gpio_addr is RGPIO_PTRIG the data_reg will store rgpio_ptrig and 
		//rgpio_ptrig will get the data from gpio_dat_i
		
		inputs(RGPIO_AUX,	32'h0010,	32'h0810,	32'hffff,	1'b1); 
		// The gpio_addr is RGPIO_AUX the data_reg will store rgpio_aux and rgpio_aux 
		//will get the data from gpio_dat_i
		
		#100 $finish;
	end
	
	
	initial 
	begin
		$monitor("gpio_eclk=%0h, sys_clk=%0h, sys_rst=%0h, gpio_we=%0h, gpio_addr=%0h, gpio_dat_i=%0h, in_pad_i=%0h, aux_i=%0h \ngpio_inta_o=%0h, gpio_dat_o=%0h, out_pad_o=%0h, oen_padoe_o=%0h \n",gpio_eclk, sys_clk, sys_rst, gpio_we, gpio_addr, gpio_dat_i, in_pad_i, aux_i, gpio_inta_o, gpio_dat_o, out_pad_o, oen_padoe_o);
	end
endmodule
