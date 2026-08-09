class cls;
	rand int a[10];
	
	constraint c1{	foreach(a[i]){
				a[i] inside{[0:99]};
				if(i<$size(a)/2) {
					a.sum() with (int'(item == a[i])) == 2;
					unique{a[0:($size(a)/2)-1]};
				}
			}
		}
endclass

class cls1;
	rand int a[10];
	rand int temp[5];
	constraint c1{	foreach(temp[i]){
				temp[i] inside{[0:99]};
				unique{temp};
				a.sum() with (int'(item == temp[i])) == 2;
			}
		}
endclass

cls h;
cls1 h1;

module test;

	initial begin
		h=new();
		//repeat(10)
		begin
			h.randomize();
			$display("%p",h.a);
		end
		
		
		h1=new();
		//repeat(10)
		begin
			h1.randomize();
			$display("%p",h1.a);
		end
	end
endmodule
