module exp();

int q1[$];
int q2[$];
int q3[$];
int temp;
initial begin
q1={1,2};
q2={3,4};
q3={5,6};
$display("q1=%p \n q2=%p \n q3=%p", q1,q2,q3);

//without method
q1={q1,q2};
$display("q1=%p \n q2=%p \n q3=%p", q1,q2,q3);

/*//with method pop and push
for(int i=0; i<2; i++)
begin
	temp = q3.pop_front();
	q1.push_back(temp);
end
$display("q1=%p \n q2=%p \n q3=%p", q1,q2,q3);
*/

//with method insert
for(int i=0; i<q3.size(); i++)
begin
	temp = q3.pop_front();
	q1.insert(i+4,temp);
end

$display("q1=%p \n q2=%p \n q3=%p", q1,q2,q3);


end
endmodule
