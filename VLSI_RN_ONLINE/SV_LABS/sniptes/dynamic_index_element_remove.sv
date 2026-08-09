module test();
int d[];
int temp[];

int data_da[];

int result;

//function automatic void(int index, ref int array[]);
//	foreach(i)
		
		//if(i>index && array.size()-1) array[i] = i+1;

initial begin
d=new[10];
foreach(d[i]) d[i]=i+1;
$display("d = %p",d);

//remove index 3 element
temp=new[9];
foreach(temp[i])
begin
if(i>=3) temp[i] = d[i+1];
else temp[i] = d[i];
end
d=new[9] (temp);
$display("d = %p",d);

/*
//remove 7 in the dynamic array
temp=new[8];
foreach(temp[i])
begin
if(d[i]!=7) temp[i] = d[i];
if(d[i]!=7) temp[i] = d[i+1];

else temp[i] = d[i];
end
d=new[8] (temp);
$display("d = %p",d);
*/

data_da = new[10];

foreach(data_da[i]) data_da[i] = {$random} % 20;

data_da.sort();

$display("data_da = %p",data_da);

result = data_da.sum with (int'(item>7));

$display("no. of items greater than 7 = %0d", result);

result = data_da.sum with ((item>7)*item);
			
$display("sum of items greater than 7 = %0d", result);

end
endmodule
