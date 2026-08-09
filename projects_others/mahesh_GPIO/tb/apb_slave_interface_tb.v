module apb_slave_interface_tb();
	reg PCLK,PRESET, PSEL,PENABLE, PWRITE;
	reg [31:0] PADDR, PWDATA, gpio_dat_o;
	reg gpio_inta_o;
	wire sys_clk, sys_rst, gpio_we;
	wire [31:0] gpio_addr, gpio_dat_i, PRDATA;
	wire PREADY, IRQ;

integer i;
parameter IDLE = 2'b00, SETUP = 2'b01, ENABLE = 2'b10;

apb_slave_interface xyz(
	PCLK, PRESET,
	PSEL, PENABLE, PWRITE,
	PADDR, PWDATA,
	gpio_dat_o,
	gpio_inta_o,
	sys_clk,
	sys_rst,
	gpio_we,
	gpio_addr, gpio_dat_i, PRDATA,
	PREADY,
        IRQ);
/*always begin 
	PCLK = 1'b0;
	#5 PCLK = ~PCLK;
end
*/
initial begin
	PCLK = 1'b0;
	forever #5 PCLK = ~PCLK;
end
task initialize();
	begin
		PCLK = 0;
	       	PRESET = 0;
		PSEL = 0;
		PENABLE = 0;
		PADDR = 0;
		PWDATA = 0;
		gpio_dat_o = 0;
		gpio_inta_o = 0;
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
		wait(PREADY)
		@(negedge PCLK);
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
				wait(PREADY)
		@(negedge PCLK);
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
endtask

initial begin
	initialize();
	reset;
	PADDR = 32'd08764378;
	PWDATA = 32'd12345678;
	gpio_inta_o = 1'b1;
	gpio_dat_o = 32'd16346789;
	apb_write_fsm;
	apb_read_fsm;
	#200; $finish;
end
initial 
	$monitor("PCLK=%d, PRESET=%d, PSEL=%d, PENABLE=%d, PWRITE=%d, PADDR=%d, PWDATA=%d, gpio_dat_o=%d, gpio_inta_o=%d, sys_clk=%d, sys_rst=%d, gpio_we=%d, gpio_addr=%d, gpio_dat_i=%d, PRDATA=%d, PREADY=%d, IRQ=%d",PCLK,PRESET, PSEL,PENABLE, PWRITE, PADDR, PWDATA, gpio_dat_o, gpio_inta_o, sys_clk, sys_rst, gpio_we, gpio_addr, gpio_dat_i, PRDATA, PREADY, IRQ);
endmodule
