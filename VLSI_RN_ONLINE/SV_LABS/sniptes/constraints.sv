module test_test;
	class test_1;
		rand bit [7:0] temp;

	//	constraint c1 {temp%5==0;}

		function void post_randomize();
			$display("%d ",temp);
		endfunction

	endclass

	test_1 h1;

	initial
	begin
		h1=new;
		repeat(10) begin assert(h1.randomize()); end
	end
endmodule
