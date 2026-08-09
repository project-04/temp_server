module test();
int d[];

function automatic void add(int element, ref int array[]);
	array = new[array.size()+1] (array);
	array[array.size()-1] = element;
endfunction

initial
begin

//adding elements
d=new[10];
d={1,2,3,4,5,6,7,8,9,10};

$display("d = ", d);
$display("size : %d", d.size());

add(100, d);
//for(int i=1; i<=5; i++) add(i*100, d);

$display("d = ", d);
$display("size : %d", d.size());

end
endmodule