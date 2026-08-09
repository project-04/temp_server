

module top;
	
	import uvm_pkg::*;
	import test_pkg::*;
	
	`include "uvm_macros.svh"

	bit clk1;
	bit clk2;
	
	//100 mhz
	always #5 clk1 = ~clk1;		/*	Frequency = 1 / (10 × 10⁻⁹)
												= 100 × 10⁶ Hz
												= 100 MHz */
	
	//50 mhz	
	always #10 clk2 = ~clk2;	/*	Frequency = 1 / (20 × 10⁻⁹)
											= 50 × 10⁶ Hz
											= 50 MHz	*/

	

	apb_if apb_sif(clk1);
	uart_if uart_sif();
	
	bit PRESETn;
	initial 
		begin
			PRESETn = 0;
			#100;
			PRESETn = 1;
		end
	
	
	
	// UART BAUD GEN
	int clk_freq = 50000000; //50 Mhz
	int baud_rate = 115200;
	int sample = 16;
	int divisor = (clk_freq /(baud_rate * sample));	//divisor = 27;  
	int baud_cnt;


	// counter logic 
	always_ff@(posedge clk2 or negedge PRESETn)
		begin 
			if(!PRESETn)
				begin 
					baud_cnt <= 0;
					uart_sif.baud_o <= 0;
				end
			else if(baud_cnt == divisor - 1)
				begin 
					baud_cnt <= 0;
					uart_sif.baud_o <= 1;
				end
			else
				begin 
					baud_cnt <= baud_cnt + 1;
					uart_sif.baud_o <= 0;
				end
		end
			
	
		
	
	
	
	uart_16550 DUV (
					.PCLK(clk1),
					.PRESETn(apb_sif.Presetn),
					.PADDR(apb_sif.Paddr),
					.PWDATA(apb_sif.Pwdata),
					.PRDATA(apb_sif.Prdata),
					.PWRITE(apb_sif.Pwrite),
					.PENABLE(apb_sif.Penable),
					.PSEL(apb_sif.Psel),
					.PREADY(apb_sif.Pready),
					.PSLVERR(apb_sif.Pslverr),
					.IRQ(apb_sif.IRQ),
					.TXD(uart_sif.rx),
					.RXD(uart_sif.tx)
  		);
		
	initial
		begin 
		
			`ifdef VCS
			$fsdbDumpvars(0,top);
			`endif
				
			uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",apb_sif);
			uvm_config_db#(virtual uart_if)::set(null,"*","uart_if",uart_sif);

			run_test();

		end

endmodule		
			
