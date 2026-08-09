module test;
	bit clk;
	bit valid;
	bit data;
	bit ready;

	property ppt;
		@(posedge clk)
		$rose(valid) |-> $stable(valid && data) until ready;
	endproperty

	a1:assert property(ppt);
endmodule
