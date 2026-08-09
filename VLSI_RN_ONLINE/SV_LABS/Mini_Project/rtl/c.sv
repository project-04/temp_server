module counter (input clock, resetn, load,up_down,input reg [3:0]data_in,output reg[3:0]count);

always@(posedge clock)
begin
	if(resetn)
		count<=4'b0000;
	else if(load)
		count<=data_in;
	else if(up_down==0)
	begin
		if(count>12)
			count<=4'b0;
		else
			count<=count+1'b1;
	end
	else if (up_down ==1)
	begin
		if((count>10)||(count<2))
			count<=4'd10;
		else
			count<=count-1'b1;
		end
	end
endmodule

module loadable_up_down_counter_tb();
  
  reg clock, resetn, load, up_down;
  reg [3:0] data_in, count;
  
  counter DUT(clock, resetn, load, up_down, data_in, count);
  
  always
  begin
    #10 clock = 1'b0;
    #10 clock = ~clock;
  end
  
  task reset();
    begin
      @(negedge clock);
      resetn = 1'b1;
      @(negedge clock);
      resetn = 1'b0;
    end
  endtask
  
  task in(input l,m, input [3:0] d);
    begin
      @(negedge clock);
      load = l;
      up_down = m;
      data_in = d;
    end
  endtask
  
  initial begin
    //$dumpfile("dump.vcd");
    //$dumpvars(0, loadable_up_down_counter_tb);
    {clock, resetn, load, data_in} = 0;
    in(1'b1, 1'b0, 4'b0000);
    in(1'b0, 1'b0, 4'b0000);
    #500 reset();
    in(1'b1, 1'b1, 4'b0111);
    in(1'b0, 1'b1, 4'b0111);
  end
  initial begin
    $monitor("%t -> %b | %b | %b | %b | %b | %d",$time, clock, resetn, load, up_down, data_in, count);
    #1000 $finish;
  end
endmodule

