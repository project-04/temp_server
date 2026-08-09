module test;
	function integer add(input integer a,input integer b); begin
		add = a+b;
	end
	endfunction
	
	initial begin:BLOCK_1
		integer i;
		i=add(5,5);
		$display(i);
		$display(add(6,6));
	end
endmodule

