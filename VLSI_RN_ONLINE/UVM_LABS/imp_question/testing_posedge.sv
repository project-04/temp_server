module test();

	bit clk;

	class xtn;
		
		typedef struct {
			rand bit [7:0] addr;
			rand bit [3:0] data;
		} struct_dt;
		
		 rand struct_dt new_dt;
	
		constraint c1 {new_dt.addr inside{[8'h10:8'hf0]};}
		constraint c2 {new_dt.addr%2 == 0;}
		//constraint c3 {unique{new_dt.addr};}
	
		constraint c4 {new_dt.data inside{[0:4'hf]};}

		function void post_randomize();
			$display("addr=%d, data=%d", new_dt.addr, new_dt.data);
		endfunction


		covergroup cg@(posedge clk);
			coverpoint new_dt.addr{
				//bins tb = (6 => 64 => 128 => 256);
				bins tb = (46 => 94 => 112);
			}
		endgroup

		function new();
			cg = new();
		endfunction

	endclass
	
	xtn xtn_h;
	
	initial
	begin
		xtn_h=new();                                                         
		repeat(10)
		begin
			@(posedge clk);		
			assert(xtn_h.randomize());
			//xtn_h.cg.sample();
		end
		$display("coverage=%0f",xtn_h.cg.get_coverage());
	end

	initial forever #10 clk = ~clk;

	initial #1000 $finish;
endmodule
