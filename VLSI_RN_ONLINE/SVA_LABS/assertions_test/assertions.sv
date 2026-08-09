module test;
bit clock;
bit start;

property name;
	@(posedge clock) $rose(start) |-> start[*4:$];
endproperty

A: assert property(name);

endmodule
