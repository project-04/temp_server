module test;
	//integer i;
	initial begin:BLOCK_1
		integer i;
		for(i=0; i<8; i=i+1) begin
			$display("test BLOCK_1 %d",i);
		end
	end
	initial begin:BLOCK_2
		integer i;
		for(i=0; i<8; i=i+1) begin
			$display("test BLOCK_2 %d",i);
		end
	end
endmodule

