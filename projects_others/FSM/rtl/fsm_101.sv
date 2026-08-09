
module fsm_101_overlapping(input clk,rst,din,output dout);

	parameter 	s0 = 2'b00,
			s1 = 2'b01,
			s2 = 2'b10,
			s3 = 2'b11;

	reg [1:0] state,next_state;

	always @(posedge clk)
	begin

		if(rst)
			state <= s0;
		else 
			state <= next_state;

	end

	always @(*)
	begin

		case(state)

		s0 : 	if(din == 1)
				next_state = s1;
			else 
				next_state = s0;

		s1 :	if(din == 1)
				next_state = s1;
			else
				next_state = s2;

		s2 : 	if(din == 1)
				next_state = s3;
			else 
				next_state = s0;
	
		s3 : 	if(din == 1)
				next_state = s1;
			else 
				next_state = s2;

		endcase
	
	end

	assign dout = (state == s3);

endmodule
