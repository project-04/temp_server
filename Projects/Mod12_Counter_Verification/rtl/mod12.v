module mod12counter(input clk,up,reset_n,load,input [3:0]data_in,output  reg [3:0] data_out);

	always@(posedge clk)
	begin
		if(reset_n)
			data_out<=4'd0;

		else if(load)
			data_out<=(data_in<=4'd11)?data_in:4'd0;
		else if(up)
		begin
			if(data_out>=4'd11)
			data_out<=4'd0;
			else
			data_out<=data_out+1'b1;
		end
		else
		begin
			if(data_out==4'd0)
			data_out<=4'd11;
			else
			data_out<=data_out-1'b1;
		end	
		
	end

endmodule



