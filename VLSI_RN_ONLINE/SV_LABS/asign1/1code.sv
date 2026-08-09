module que1_code();
	int d[];
 	int temp, i, j; 
initial 
begin
d=new[10];

 foreach(d[i])
  d[i]={$random} % 100;

$display("aray data = %p", d);

 d.sort() with (item) ;
 $display("sorted array using with method =%p ", d);


 foreach(d[i])
  d[i]={$random} % 100;
 $display("array data = %p", d);

for(i = 0; i < d.size(); i++) begin
 for(j = 0; j < d.size() -i -1; j++); begin
  if(d[j] > d[j+1]) begin
   temp = d[j];
   d[j] = d[j+1];
   d[j+1] = temp;
  end 
 end
end
$display("sorted array without method = ", d);


end
endmodule
