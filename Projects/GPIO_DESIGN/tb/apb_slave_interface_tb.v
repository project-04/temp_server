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
