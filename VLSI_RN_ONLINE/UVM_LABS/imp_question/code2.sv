module module_test;

class test;
	
	rand int d[];

	constraint c1{d.size == 10;}

	constraint c2{foreach(d[i]){
			if(i<5) d[i] == 9-(i*2);
			//if(i<5) d[i] == 10-((i*2)+1);
			else    d[i] == (i*2)-10;
			}
		}

	function void post_randomize();
		$display("d =%p", d);
	endfunction
endclass

test h1;
	
	initial begin
		h1=new();
		assert(h1.randomize());
	end
endmodule
