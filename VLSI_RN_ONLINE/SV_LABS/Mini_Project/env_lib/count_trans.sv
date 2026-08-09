class count_trans;
	rand logic [3:0]data_in;
	rand logic load;
	rand logic up_down;
	rand logic resetn;
	logic [3:0]count;

	constraint C1 {data_in inside {[0:11]};}
	constraint C2 {resetn dist {1:=30, 0:=70};}
	constraint C3 {load dist {1:=30,0:=70};}
	constraint C4 {up_down dist {0:=30,1:=70};}

	virtual function void display(input string s);
	begin
		$display("..........................%s................",s);
		$display("Time    = %0t", $time);
		$display("Up_down = %0d",up_down);
		$display("load    = %0d",load);
		$display("data_in = %0d",data_in);
		$display("resetn  = %0d",resetn);
		$display("count   = %0d",count);
		$display("............................................");
	end
	endfunction

	function void  post_randomize();
		this.display("rand data");
	endfunction
endclass

class count_trans2 extends count_trans;

	constraint t2_c1{data_in == 10;}
endclass





