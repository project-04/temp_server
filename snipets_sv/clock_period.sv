`timescale 1ns/1ps

module clock_calculation(clk, clock_period, clock_frequence, clock_duty_cycle);
    input  reg clk;
    output realtime clock_period;
    output real clock_frequence;
    output real clock_duty_cycle;

    realtime cp_t1 = 0;
    realtime cp_t2 = 0;
    
    realtime dc_t1 = 0;
    realtime dc_t2 = 0;
    realtime ton   = 0;
    realtime toff  = 0;

    always@(posedge clk)
    begin
    	if(clk)
    	begin
    		dc_t1 = $realtime;
    		toff = dc_t1-dc_t2;
    		dc_t2 = dc_t1;
    	end
        cp_t1 = $realtime;
        clock_period = cp_t1 - cp_t2;
        clock_frequence = 1000.0/clock_period;
        cp_t2 = cp_t1;
    end
    
    always@(negedge clk)
    begin
    	if(!clk)
    	begin
    		dc_t1 = $realtime;
    		ton = dc_t1-dc_t2;
    		dc_t2 = dc_t1;
    	end
    end
    
    assign clock_duty_cycle = (ton/(ton+toff))*100;
endmodule


module tb;
    reg clk = 0;
    realtime clock_period;
    real clock_frequence;
    real clock_duty_cycle;
    
    real freq = 256;
    real duty_cycle = 30;
    //real clk_delay = (1000/freq)/2; //(1*(10**3)/256)/2 = 1.95; ,512 = 0.975;  
    real clk_prd = (1000/freq); //clock period is 3.9
    real clk_on_delay  = clk_prd*(duty_cycle/100);
    real clk_off_delay = clk_prd*((100-duty_cycle)/100);
    
    
    clock_calculation DUV(clk, clock_period, clock_frequence, clock_duty_cycle);

    always begin
    	clk = 1;
    	#clk_on_delay;
    	
    	clk = 0;
    	#clk_off_delay;
    	
    	$write("clock on for %0.2f ns | ",clk_on_delay);
    	$write("clock off for %0.2f ns\n\n",clk_off_delay);
    end
    
    initial begin
        $monitor("time=%0.2f ns, clk=%0d, clock_period=%0.2f ns, clock_frequence=%0.2f Mhz, clock_duty_cycle=%0.2f",
                 $realtime, clk, clock_period, clock_frequence, clock_duty_cycle);

        #100 $finish;
    end
endmodule

