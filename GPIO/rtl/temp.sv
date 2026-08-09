module apb_gpio_top(
	input PCLK,PRESET,PSEL, PENABLE, PWRITE, ext_clk_pad_i,
	input [31:0] PADDR, PWDATA, aux_in,
	output [31:0] PRDATA,
	output PREADY,IRQ,
	inout [31:0] IO_pad);

	wire [31:0] gpio_addr,gpio_dat_i,gpio_dat_o, aux_i, out_pad_o, oen_padoe_o, in_pad_i;
	wire sys_rst, sys_clk, gpio_we, gpio_inta_o,gpio_eclk;

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


	gpio_interface GI (.ext_clk_pad_i(ext_clk_pad_i),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o),
			.in_pad_i(in_pad_i),
			.IO_pad(IO_pad),
			.gpio_eclk(gpio_eclk));


	aux_interface AI (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.aux_in(aux_in),
			.aux_i(aux_i));
endmodule
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








module aux_interface(
	//from APB Slave
	input sys_clk, sys_rst,
	//from AUX
	input [31:0] aux_in,
	//to Register
	output reg [31:0] aux_i);

	always @(posedge sys_clk or posedge sys_rst)
	begin
		if(sys_rst)
			aux_i <= 32'h0;
		else
			aux_i <= aux_in;
	end
endmodule

module gpio_interface (
	//from Outside
	input ext_clk_pad_i,
	//from Register
	input [31:0] out_pad_o, oen_padoe_o,
	//from outside or to outside (32 input and output pins)
	inout [31:0] IO_pad, 
	//to Register
	output [31:0] in_pad_i, 
	output gpio_eclk
	);
	
	
	genvar i;

	generate for(i=0; i<32; i=i+1)
	begin : IO_padS_GENERATION
		bufif1 a1 (IO_pad[i], out_pad_o[i], oen_padoe_o[i]);
	end
	endgenerate
	
	
	/*	
	assign IO_pad[0]=oen_padoe_o[0]?out_pad_o[0]:1'bz;
	assign IO_pad[1]=oen_padoe_o[1]?out_pad_o[1]:1'bz;
	assign IO_pad[2]=oen_padoe_o[2]?out_pad_o[2]:1'bz;
	assign IO_pad[3]=oen_padoe_o[3]?out_pad_o[3]:1'bz;
	assign IO_pad[4]=oen_padoe_o[4]?out_pad_o[4]:1'bz;
	assign IO_pad[5]=oen_padoe_o[5]?out_pad_o[5]:1'bz;
	assign IO_pad[6]=oen_padoe_o[6]?out_pad_o[6]:1'bz;
	assign IO_pad[7]=oen_padoe_o[7]?out_pad_o[7]:1'bz;
	assign IO_pad[8]=oen_padoe_o[8]?out_pad_o[8]:1'bz; 
	assign IO_pad[9]=oen_padoe_o[9]?out_pad_o[9]:1'bz;
	assign IO_pad[10]=oen_padoe_o[10]?out_pad_o[10]:1'bz;
	assign IO_pad[11]=oen_padoe_o[11]?out_pad_o[11]:1'bz;
	assign IO_pad[12]=oen_padoe_o[12]?out_pad_o[12]:1'bz;
	assign IO_pad[13]=oen_padoe_o[13]?out_pad_o[13]:1'bz;
	assign IO_pad[14]=oen_padoe_o[14]?out_pad_o[14]:1'bz; 
	assign IO_pad[15]=oen_padoe_o[15]?out_pad_o[15]:1'bz;
	assign IO_pad[16]=oen_padoe_o[16]?out_pad_o[16]:1'bz;
	assign IO_pad[17]=oen_padoe_o[17]?out_pad_o[17]:1'bz;
	assign IO_pad[18]=oen_padoe_o[18]?out_pad_o[18]:1'bz;
	assign IO_pad[19]=oen_padoe_o[19]?out_pad_o[19]:1'bz;
	assign IO_pad[20]=oen_padoe_o[20]?out_pad_o[20]:1'bz;
	assign IO_pad[21]=oen_padoe_o[21]?out_pad_o[21]:1'bz;
	assign IO_pad[22]=oen_padoe_o[22]?out_pad_o[22]:1'bz;
	assign IO_pad[23]=oen_padoe_o[23]?out_pad_o[23]:1'bz;
	assign IO_pad[24]=oen_padoe_o[24]?out_pad_o[24]:1'bz;
	assign IO_pad[25]=oen_padoe_o[25]?out_pad_o[25]:1'bz;
	assign IO_pad[26]=oen_padoe_o[26]?out_pad_o[26]:1'bz;
	assign IO_pad[27]=oen_padoe_o[27]?out_pad_o[27]:1'bz;
	assign IO_pad[28]=oen_padoe_o[28]?out_pad_o[28]:1'bz;
	assign IO_pad[29]=oen_padoe_o[29]?out_pad_o[29]:1'bz;
	assign IO_pad[30]=oen_padoe_o[30]?out_pad_o[30]:1'bz;
	assign IO_pad[31]=oen_padoe_o[31]?out_pad_o[31]:1'bz;
	*/
	
	assign in_pad_i  = IO_pad;
	assign gpio_eclk = ext_clk_pad_i;
endmodule
module gpio_register(
	input sys_clk, sys_rst,
	input gpio_we,
	input [31:0] gpio_addr, gpio_dat_i, in_pad_i,
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

