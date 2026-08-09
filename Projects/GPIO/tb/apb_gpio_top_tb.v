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
