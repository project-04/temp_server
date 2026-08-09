module apb_gpio_top_tb ();

reg PCLK, PRESET, PSEL, PENABLE, PWRITE, ext_clk_pad_i;
reg [31:0] PADDR, PWDATA, aux_in;
wire [31:0] PRDATA;
wire PREADY, IRQ;
wire [31:0] IO_pad;

apb_gpio_top DUT (PCLK,PRESET,PSEL, PENABLE, PWRITE, ext_clk_pad_i,
	PADDR, PWDATA, aux_in, PRDATA, PREADY, IRQ, IO_pad);

always #5 PCLK = ~PCLK;

always #10 ext_clk_pad_i = ~ext_clk_pad_i;


task reset;
	begin
		@(negedge PCLK);
		PRESET = 1'b1;
		@(negedge PCLK);
		PRESET = 1'b0;
	end
endtask

task apb_fsm_write;
	begin
		@(negedge PCLK);
		PWRITE = 1'b1;
		PSEL = 1'b1;
		PENABLE = 1'b0;
		@(negedge PCLK);
		PENABLE = 1'b1;
		wait (PREADY)
		@(negedge PCLK);
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
endtask

task apb_fsm_read;
	begin
		@(negedge PCLK);
		PWRITE = 1'b0;
		PSEL = 1'b1;
		PENABLE = 1'b0;
		@(negedge PCLK);
		PENABLE = 1'b1;
		wait (PREADY)
		@(negedge PCLK);
		PSEL = 1'b0;
		PENABLE = 1'b0;
	end
endtask

task  stimulus (input [31:0] pwdata, aux_in, paddr);
	begin
		@(negedge PCLK);
		PWDATA = pwdata;
		aux_in = aux_in;
		PADDR = paddr;
	end
endtask

task initialize;
	begin
{ PCLK, PRESET, PSEL, PENABLE, PWRITE, ext_clk_pad_i, PADDR, PWDATA, aux_in} = 0;
	end
endtask

initial begin

end
endmodule

