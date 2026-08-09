module counter(input clock, resetn, load, up_down, input reg [3:0] data_in, output reg [3:0] count);
  
  always@(posedge clock)
    begin
      if(resetn)
        count <= 4'd0;        
      else
      begin
      	   if(load)
        	count <= data_in;
      	   else
	   begin
        	if(up_down == 1'b1)
		begin
          		if(count == 4'd11) 
				count <= 4'd0;
          		else 
				count <= count+1'b1;
		end
        	else
		begin
          		if(count == 4'd0) 
				count <= 4'd11;
          		else 
				count <= count-1'b1;
		end
	   end
	end
    end
endmodule
