module top();
	import uvm_pkg::*;
	import uart_pkg::*;

	bit clock1; //Clock to be given to UART DUT
	bit clock2; //Clock to be given to UART_agent
	bit PRESETn;
	
	int PERIOD_CLOCK1 = 10; //100 MHz
	int PERIOD_CLOCK2 = 20; //50 MHz

	always #(PERIOD_CLOCK1/2) clock1 = ~clock1; //100 MHz	,Divisor = 54
	always #(PERIOD_CLOCK2/2) clock2 = ~clock2; //50 MHz	,Divisor = 27

	apb_if  in0(clock1);
	uart_if in1();

	initial begin
		clock1=1'b0;
		clock2=1'b0;
		PRESETn = 1'b0;
		#100;
		PRESETn = 1'b1;
	end

	int clock_freq = 50_000_000; //50 MHz.
	int BAUD_RATE = 115200;
	int SAMPLE = 16;

	int DIVISOR = clock_freq / (BAUD_RATE * SAMPLE); //Divisor = 27

	int baud_count;

	/*For the UART_agent acting as the UART2, we need to give baud tick 
	for transmission-reception synchronisation between the UART DUT(UART1) and UART_agent*/

	always@(posedge clock2 or negedge PRESETn)
	begin
			if(!PRESETn)
			begin
				baud_count <= 1'b0;
				in1.baud_o <= 1'b0;
			end
					
			else if(baud_count == (DIVISOR-1))
			begin
				baud_count <= 1'b0;
				in1.baud_o <= 1'b1;
			end

			else 
			begin
				baud_count <= baud_count + 1'b1;
				in1.baud_o <= 1'b0;
			end
	end

	uart_16550 DUT(	.PCLK(clock1),
			.PRESETn(in0.presetn),
			.PADDR(in0.paddr),
			.PWDATA(in0.pwdata),
			.PRDATA(in0.prdata),
			.PWRITE(in0.pwrite),
			.PENABLE(in0.penable),
			.PSEL(in0.psel),
			.PREADY(in0.pready),
			.PSLVERR(in0.pslverr),
			.IRQ(in0.irq),
			.TXD(in1.RX), //These signals are suppose to interact with UART2
			.RXD(in1.TX),
			.baud_o(in0.baud_o));

	initial begin
		`ifdef VCS
			$fsdbDumpvars(0,top);
		`endif
 	
		uvm_config_db #(virtual apb_if)::set(null,"*","apb_vif",in0);
		uvm_config_db #(virtual uart_if)::set(null,"*","uart_vif",in1);

		run_test();
	end

endmodule
