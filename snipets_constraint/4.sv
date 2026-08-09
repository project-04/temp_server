module test;
class con;
	rand bit [8:0] data;
	bit pos_1;
	
	constraint c1{ data[1] == pos_1;}
	
	function void pre_randomize();
	begin
		pos_1 = data[1];
	end
	endfunction
	
	function void post_randomize();
	begin
		$display("%b",data);
	end
	endfunction
endclass

con h1;
initial begin
	h1 = new;
	h1.data[1] = 1;
	repeat(5)
	void'(h1.randomize());
	$display;
	h1.data[1] = 0;
	repeat(5)
	void'(h1.randomize());
end
endmodule


	
	
