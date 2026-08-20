/*module temp;
	class test;
		rand int arr[];
		
		//constraint c1{ arr.size() == 20;}
		constraint c2{ 
			arr.sum() with (int'(item == 05)) == 3;
			arr.sum() with (int'(item == 10)) == 5;
			arr.sum() with (int'(item == 15)) == 8;
			arr.sum() with (int'(item == 20)) == 4;
		}
		constraint c2{
			10 == arr.sum() with (item%2==1);
			10 == arr.sum() with (item%2==0);
			//20 == (arr.sum() with (item%2==0) + arr.sum() with (item%2==1));
		}
		
		function void post_randomize();
			$display("arr = %p", arr);
		endfunction
	endclass

	test h1;

	initial begin
		h1 = new();
		
		repeat(3) void'(h1.randomize());
	end
endmodule
*/

module test1;
	class cls;
		randc bit[2:0] arr[];
		randc int pa[10];
		
		constraint c0 { arr.size() == 10;}
		
		//constraint c4{ arr.sum() with ((item%2 == 0)?1:0) == 10;}
		constraint c4{ arr.sum() with (int'(item%2 == 0)) == 10;}
		
		/*constraint c2 { foreach(arr[i]){
					arr[i] inside {[0:100]};
					//if(fun_prime(arr[i]) == 1) pa[i] == arr[i];
					//else pa[i] == 0;
					}
				}
		*/		
		function bit fun_prime(input int temp);
				int i;
				for(i=2; i<temp; i++)
					if(temp%i==0) return 0;
				return 1;
		endfunction
		
		function void post_randomize();
			/*foreach(arr[i])begin
				if(fun_prime(arr[i]) == 0) pa[i] = 0;
				else pa[i] = arr[i];
			end*/
			$display("arr = %p", arr);
			$display("pa  = %p", pa);
		endfunction
	endclass

	cls h1;

	initial begin
		h1 = new();
		
		repeat(1) void'(h1.randomize());
	end
endmodule






