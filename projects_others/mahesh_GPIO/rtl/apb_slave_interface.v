module apb_slave_interface (
	input PCLK, PRESET,
	input PSEL, PENABLE, PWRITE,
	input [31:0] PADDR, PWDATA,
	input [31:0] gpio_dat_o,
	input gpio_inta_o,
	output sys_clk,
	output sys_rst,
	output gpio_we,
	output [31:0] gpio_addr, gpio_dat_i, PRDATA,
	output PREADY,
        output IRQ);

reg [1:0] state,next_state;
wire rd_en;

parameter IDLE = 2'b00, SETUP = 2'b01, ENABLE = 2'b10;

	always @(posedge PCLK or posedge PRESET)
		begin
			if(PRESET)
				state <= IDLE;
			else
				state <= next_state;
		end

	always @(*) begin
		next_state = IDLE;
		//PREADY = 1'b0;
		case(state)
			IDLE: begin
				//PREADY = 1'b1;
				if(!PSEL && !PENABLE)
					next_state = IDLE;
				else if (PSEL && !PENABLE)
					next_state = SETUP;
				else
					next_state = IDLE;
			end
			SETUP: begin
				//PREADY = 1'b0;
				if(PSEL && !PENABLE)
					next_state = SETUP;
				else if(PSEL && PENABLE) 
					next_state = ENABLE;
				else
					next_state = IDLE;
			end
			ENABLE: begin
				//PREADY = 1'b1;
				if(PSEL)
					next_state = SETUP;
				else if(!PSEL)
					next_state = IDLE;
				else
					next_state = ENABLE;
			end
			default: next_state = IDLE;
		endcase
	end

	assign PREADY = (state == ENABLE)? 1'b1:1'b0;
	assign gpio_we = (state == ENABLE)? 1'b1:1'b0;
	assign sys_clk = PCLK;
	assign sys_rst = PRESET;
	assign rd_en = ((state == ENABLE) && !PWRITE)? 1'b1:1'b0;
	assign PRDATA = rd_en ? gpio_dat_o:32'h00;
	assign gpio_addr = PADDR;
	assign gpio_dat_i = (PWRITE && (state == ENABLE)) ? PWDATA:32'h00;
	assign IRQ = gpio_inta_o;
endmodule
