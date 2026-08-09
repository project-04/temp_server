module gpio_register_tb();
	reg sys_clk, sys_rst;
	reg gpio_we;
	reg [31:0] gpio_addr, gpio_dat_i,in_pad_i;
	reg gpio_eclk;
	reg [31:0] aux_i;
	wire gpio_inta_o;
	wire [31:0] gpio_dat_o;
	wire [31:0] out_pad_o;
	wire [31:0] oen_padoe_o;


gpio_register DUT (sys_clk, sys_rst, gpio_we, gpio_addr, gpio_dat_i, in_pad_i, gpio_eclk, aux_i, gpio_inta_o, gpio_dat_o, out_pad_o, oen_padoe_o);

	parameter RGPIO_IN=32'h0; 
        parameter RGPIO_OUT=32'h4; 
  	parameter RGPIO_OE=32'h8; 
	parameter RGPIO_INTE=32'hc; 
	parameter RGPIO_PTRIG=32'h10;
        parameter RGPIO_AUX=32'h14; 
        parameter RGPIO_CTRL=2'h0; 
        parameter RGPIO_INTS=32'h1c;
        parameter RGPIO_ECLK=32'h20;
        parameter RGPIO_NEC=32'h24;
        parameter RGPIO_CTRL_INTE=1'b0;
        parameter RGPIO_CTRL_INTS=1'b1;
	
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
			sys_clk = 1'b0;
			gpio_we = 1'b0;
			gpio_addr = 0;
			gpio_dat_i = 1'b0;
			in_pad_i = 1'b0;
			aux_i = 0;
			gpio_eclk = 1'b0;
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
	task inps(input [31:0] a);
		begin
			@(gpio_eclk)
			in_pad_i = a;
		end
	endtask
	task delay;
		begin
			@(negedge sys_clk);
		end
	endtask

//DRIVE ALL THE TASKS IN INITIAL BLOCK
	initial begin
		initialize;
		reset;
		inputs(RGPIO_NEC, 	32'h19, 	32'h1220, 	32'h0010, 	1'b1); //the gpio_addr is Rgpio_Nec that data_reg will store the rgpio_nec data and rgpio_nec will get the data from gpio_dat_i
		inputs(RGPIO_ECLK, 	32'h19, 	32'h122, 	32'h10, 	1'b1); //The gpio_addr is RGPIO_ECLK the data_reg will store the rgpio_eclk data and rgpio_nec will get the data from gpio_dat_i
		inputs(RGPIO_IN, 	32'h19, 	32'h120, 	32'h00, 	1'b1); // The gpio_addr is RGPIO_IN the data_reg will store the rgpio_in data and rgpio_in will get the data from in_mux and the in mux will work depending on rgpio_eclk as well as external_clk with in_pad_i
		inputs(RGPIO_OUT, 	32'h23, 	32'h00, 	32'h00, 	1'b1); // The gpio_addr is RGPIO_OUT the data_reg will store the rgpio_out data and rgpio_out will get the data from gpio_dat_i
		inputs(RGPIO_OE, 	32'h123, 	32'h00, 	32'h01, 	1'b1); // The gpio_addr is RGPIO_OE the data_reg will store the rgpio_oe adata and rgpio_oe will get the data from gpio_dat_i
		inputs(RGPIO_INTE, 	32'h0123, 	32'h00, 	32'h00, 	1'b1); // The gpio_addr is RGPIO_INTE the data_reg will store the rgpio_inte and rgpio_inte will get the data from gpio_dat_i
		inputs(RGPIO_PTRIG,	32'h0112,	32'h0010,	32'h999f,	1'b1); // The gpio_addr is RGPIO_PTRIG the data_reg will store rgpio_ptrig and rgpio_ptrig will get the data from gpio_dat_i
		inputs(RGPIO_AUX,	32'h0010,	32'h0810,	32'hffff,	1'b1); // The gpio_addr is RGPIO_AUX the data_reg will store rgpio_aux and rgpio_aux will get the data from gpio_dat_i
	#50 $finish;
	end
endmodule
