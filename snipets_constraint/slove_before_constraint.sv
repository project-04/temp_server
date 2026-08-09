class cls1;
	rand bit  temp;
	rand bit [5:0] a;
	rand bit [8:0] b;
	
	constraint c1 { a==0 -> b==0;} //if(a==0) b==0;}
	constraint c2 { solve a before b;} // if you uncomment this it take so much time to give output
	
	covergroup cg1;
		option.per_instance = 1;
		c1 : coverpoint a iff (!temp) {
			bins b1 = {'b0};
		}
		c2 : coverpoint b{
			bins b1 = {'b0};
		}
	endgroup
	
	covergroup cg2;
		option.per_instance = 1;
		c1 : coverpoint a{
			bins b1 = {'b1111};
		}
	endgroup
	
	function new();
		cg1 = new();
		cg2 = new();
	endfunction
	
	function s();
		cg1.sample();
		cg2.sample();
	endfunction
	
endclass
	
cls1 h1;

module test;
	initial begin
		h1 = new;
		
		while(h1.cg1.get_inst_coverage < 100)
		begin
			assert(h1.randomize());
			h1.s();
			$display("a=%d, b=%d, temp=%d", h1.a, h1.b, h1.temp);
		end
	
		$display("h1.cg1.get_coverage = %0.2f", h1.cg1.get_coverage);
		//$display("h1.cg1.get_inst_coverage = %0.2f", h1.cg1.get_inst_coverage);
		
		//$display("h1.cg2.get_coverage = %0.2f", h1.cg2.get_coverage);
		//$display("h1.cg2.get_inst_coverage = %0.2f", h1.cg2.get_inst_coverage);
	end
endmodule
	
