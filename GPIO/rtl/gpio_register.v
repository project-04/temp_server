module gpio_register(
	input sys_clk, sys_rst,
	input gpio_we,
	input [31:0] gpio_addr, 
	gpio_dat_i, 
	in_pad_i,
	input gpio_eclk,
	input [31:0] aux_i,
	output gpio_inta_o,
	output reg [31:0] gpio_dat_o, 
	output [31:0] out_pad_o, 
	output [31:0] oen_padoe_o);

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

	reg [31:0] rgpio_out, rgpio_oe, rgpio_ptrig, rgpio_aux, rgpio_eclk, rgpio_nec, rgpio_in, rgpio_inte, rgpio_ints;
	reg [1:0] rgpio_ctrl;

	wire [31:0] in_mux, extc_in;
	reg  [31:0] pextc_sampled, nextc_sampled;

	reg [31:0] data_reg;
	
	
	//internal signals
	assign extc_in = (|rgpio_nec)  ? nextc_sampled : pextc_sampled;
	assign in_mux  = (|rgpio_eclk) ? extc_in : in_pad_i;
	//////////////// pextc_sampled ////////////////
	always @(posedge gpio_eclk or posedge sys_rst) 
	begin
		if(sys_rst)
			pextc_sampled <= 0;
		else
			pextc_sampled <= in_pad_i;
	end
	 //////////////// nextc_sampled ////////////////
	always @(negedge gpio_eclk or posedge sys_rst) 
	begin
		if(sys_rst)
			nextc_sampled <= 0;
		else
			nextc_sampled <= in_pad_i;
	end

	//output signals
	assign gpio_inta_o = (|rgpio_ints) ? rgpio_ctrl[RGPIO_CTRL_INTE] : 1'b0;
	assign out_pad_o   = (rgpio_out & ~rgpio_aux) | (rgpio_aux & aux_i);
	assign oen_padoe_o = rgpio_oe;
	//////////////// gpio_dat_o ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			gpio_dat_o <= 32'h0;
		else
			gpio_dat_o <= data_reg;
	end
	
	
	
	//registers
	//////////////// rgpio_in ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_in <= 32'h0;
		else
			rgpio_in <= in_mux;
	end
	//////////////// rgpio_out ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin 
		if(sys_rst)
			rgpio_out <= 32'h0;
		else
			rgpio_out <= ((gpio_addr == RGPIO_OUT) && gpio_we) ? gpio_dat_i[31:0] : rgpio_out;
	end
	//////////////// rgpio_oe ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_oe <= 32'h0;
		else if((gpio_addr == RGPIO_OE) && gpio_we)
			rgpio_oe <= gpio_dat_i[31:0];
		else
			rgpio_oe <= rgpio_oe;
	end
	//////////////// rgpio_inte ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_inte <= 32'h0;
		else
			rgpio_inte <= ((gpio_addr == RGPIO_INTE) && gpio_we) ? gpio_dat_i[31:0] : rgpio_inte;
	end
	//////////////// rgpio_aux ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_aux <= 32'h0;
		else
			rgpio_aux <= ((gpio_addr == RGPIO_AUX) && gpio_we) ? gpio_dat_i[31:0] : rgpio_aux;
	end
	//////////////// rgpio_eclk ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_eclk <= 32'h0;
		else
			rgpio_eclk <= ((gpio_addr == RGPIO_ECLK) && gpio_we) ? gpio_dat_i[31:0] : rgpio_eclk;
	end
	//////////////// rgpio_ptrig ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_ptrig <= 32'h0;
		else
			rgpio_ptrig <= ((gpio_addr == RGPIO_PTRIG) && gpio_we) ? gpio_dat_i[31:0] : rgpio_ptrig;
	end
	//////////////// rgpio_nec ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_nec <= 32'h0;
		else
			rgpio_nec <= ((gpio_addr == RGPIO_NEC) && gpio_we) ? gpio_dat_i[31:0] : rgpio_nec;
	end
	//////////////// rgpio_ints ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_ints <= 32'h0;
		else if((gpio_addr == RGPIO_INTS) && gpio_we)
			rgpio_ints <= gpio_dat_i[31:0];
		else if(rgpio_ctrl[RGPIO_CTRL_INTE])
			rgpio_ints <= (rgpio_ints | (rgpio_inte & (rgpio_in ^ in_mux) & (~(rgpio_ptrig ^ in_mux))));
		else
			rgpio_ints <= rgpio_ints;
	end
	//////////////// rgpio_ctrl ////////////////
	always @(posedge sys_clk or posedge sys_rst) 
	begin
		if(sys_rst)
			rgpio_ctrl <= 2'h0;
		else if((gpio_addr == RGPIO_CTRL) && gpio_we)
			rgpio_ctrl <= gpio_dat_i[1:0];
		else if(rgpio_ctrl[RGPIO_CTRL_INTE])
			rgpio_ctrl <= {rgpio_ctrl[RGPIO_CTRL_INTS]|gpio_inta_o,rgpio_ctrl[RGPIO_CTRL_INTE]};
		else
			rgpio_ctrl <= rgpio_ctrl;
	end
	
	
	//////////////// data_reg ////////////////	
	always@(*)
	begin
                case(gpio_addr)
		        RGPIO_IN    : data_reg = rgpio_in;
		        RGPIO_OUT   : data_reg = rgpio_out;
		        RGPIO_OE    : data_reg = rgpio_oe;
		        RGPIO_INTE  : data_reg = rgpio_inte;
		        RGPIO_PTRIG : data_reg = rgpio_ptrig;
		        RGPIO_AUX   : data_reg = rgpio_aux;
			RGPIO_CTRL  : begin
					data_reg[1:0]  = rgpio_ctrl;
					data_reg[31:2] = 0;
				      end
		        RGPIO_INTS  : data_reg = rgpio_ints;
		        RGPIO_ECLK  : data_reg = rgpio_eclk;
		        RGPIO_NEC   : data_reg = rgpio_nec;
		        default     : data_reg = 32'h00;
                endcase
	end
endmodule

