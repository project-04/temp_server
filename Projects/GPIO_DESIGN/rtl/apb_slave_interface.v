module apb_slave_interface (
	//from APB Host
	input PCLK, PRESET, PSEL, PENABLE, PWRITE,
	input [31:0] PADDR, PWDATA,
	//to APB Host
	output [31:0] PRDATA,
	output PREADY, IRQ,
	
	//from Register
	input gpio_inta_o,
	input [31:0] gpio_dat_o,
	//to Register
	output sys_clk, sys_rst, gpio_we,
	output [31:0] gpio_addr, gpio_dat_i
        );

	
	parameter IDLE = 2'b00, SETUP = 2'b01, ENABLE = 2'b10;
	
	reg [1:0] state,next_state;
	wire rd_en;
	
	//internal signals
	assign rd_en      = ((state == ENABLE) && !PWRITE) ? 1'b1 : 1'b0;
	
	//output signals
	assign sys_clk    = PCLK;
	assign sys_rst    = PRESET;
	assign gpio_addr  = PADDR;
	assign gpio_we    = (state  == ENABLE) ? PWRITE : 1'b0;
	assign gpio_dat_i = ((state == ENABLE) &&  PWRITE) ? PWDATA : 32'h00;
	assign PREADY     = (state  == ENABLE) ? 1'b1 : 1'b0;
	assign PRDATA     = rd_en ? gpio_dat_o : 32'h00;
	assign IRQ        = gpio_inta_o;
	


	always @(posedge PCLK or posedge PRESET) 
	begin
		if(PRESET)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @(*) 
	begin
		case(state)
			IDLE: 
			begin
				if(!PSEL && !PENABLE)
					next_state = IDLE;
				else if (PSEL && !PENABLE)
					next_state = SETUP;
				else
					next_state = IDLE;
			end
			SETUP: 
			begin
				if(PSEL && !PENABLE)
					next_state = SETUP;
				else if(PSEL && PENABLE) 
					next_state = ENABLE;
				else
					next_state = IDLE;
			end
			ENABLE: 
			begin
				if(PSEL && PENABLE)
					next_state = ENABLE;
				else if(PSEL && !PENABLE)
					next_state = SETUP;
				else
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end
endmodule








