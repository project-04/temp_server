module test;
	integer i,count,a;
	initial begin
		count = 1;
	for(i=1; ; i=i+1)
	begin
		#1;
		if(count == 22)
		begin
			count = 1;
			i=1;
		end
		else
		begin
			count = count+i;
			//$display("count = ", count);

		end
	end
	end
	initial begin
		//$monitor("count = %0d, i=%0d", count,i);
		#30 $finish;
	end
	
	
	initial begin
		$monitor("%0t , a=%0d, count=%0d", $time, a, count);
		   a = count;
		#5 a = count;
		#5;
		   a = #5 count;
		#5 a = #5 count;
	end
endmodule
		
	
