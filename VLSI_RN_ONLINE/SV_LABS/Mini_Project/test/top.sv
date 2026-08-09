module top();

	import count_pkg::*;

	reg clock;

	count_if DUV_IF(clock);

	test t_h;
	test2 t_h2;

	counter DUV(.clock(clock),.data_in(DUV_IF.data_in),.load(DUV_IF.load),.up_down(DUV_IF.up_down),.resetn(DUV_IF.resetn),.count(DUV_IF.count));

	initial
	begin
		clock=1'b0;
		forever 
			#10 clock=~clock;
	end

	initial
	begin
		 
	    `ifdef VCS
		$fsdbDumpvars(0, top);
	    `endif
	    
	if($test$plusargs("TEST1"))
            begin
		t_h=new(DUV_IF,DUV_IF,DUV_IF);
		no_of_transaction=30;
		t_h.build();
		t_h.run();
		   $finish;
            end
		
	if($test$plusargs("TEST2"))
            begin	
		t_h2=new(DUV_IF,DUV_IF,DUV_IF);
		no_of_transaction=10;
		t_h2.build();
		t_h2.run();
		$finish;
	end
end
endmodule	

