module test();
int q1[$];

initial
begin
q1={12,36,47,54};
$display("q1 = ", q1);

$display("size : %d", q1.size());

//foreach(q1[i])                    begin $display("i = %d, q1_element = %d", i, q1.pop_back()); end   //not working
//for(int i=0; i<=q1.size(); i=i+1) begin $display("i = %d, q1_element = %d", i, q1.pop_back()); end   //not working


//for(int i=0; i<4; i=i+1) begin $display("i = %d, q1_element = %d", i, q1.pop_back()); end   //working
//for(int i=0; q1.size()!=0 ; i=i+1) begin $display("i = %d, q1_element = %d", i, q1.pop_back()); end   //working

$display("q1 = ", q1);

end
endmodule    
