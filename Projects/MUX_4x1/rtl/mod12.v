module mux_4_1(input i0, i1, i2, i3, s0, s1, output reg d_out);
	always @(*)
	begin
		case ({s1, s0})
			2'b00: d_out = i0;
			2'b01: d_out = i1;
			2'b10: d_out = i2;
			2'b11: d_out = i3;
			default: d_out = 1'bx;  // default to unknown if no match
		endcase
	end
endmodule
