// qverilog -vopt +acc ../default_200mhz_clk_outclk_100_50.sv 
// vsim work.tb -voptargs=+acc
// qverilog -vopt +acc ../default_200mhz_clk_outclk_100_50.sv; vsim work.tb -voptargs=+acc
`timescale 1ns/1ps
module tb;
    reg default_clk = 0;
    reg clk_100mhz;
    reg clk_50mhz;
    

    task automatic clock_generation(input real freq = 200, real duty_cycle = 50, ref clk);
	    real clk_prd = (1000/freq);
	    real clk_on_delay  = clk_prd*(duty_cycle/100);
	    real clk_off_delay = clk_prd*((100-duty_cycle)/100);
	    
	    forever begin
		clk = 1;
    		#clk_on_delay;
    	
    		clk = 0;
    		#clk_off_delay;
    	    end
    endtask

    initial begin
    	fork
    		clock_generation(200, 50, default_clk);
    		clock_generation(100, 75, clk_100mhz);
    		clock_generation( 50, 20, clk_50mhz);
    	join_none
        #200 $finish;
    end
endmodule

