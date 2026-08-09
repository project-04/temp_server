module test();
int queue[$];

initial
begin
queue={1,2,3,4,5,6,7,8,9,10};

$display("queue = ", queue);
$display("size : %queue", queue.size());

foreach(queue[i])                 
begin 
if(queue[i]%2 == 0) queue.delete(i);   //not working
end

$queueisplay("queue = ", queue);
$display("size : %queue", queue.size());


end
endmodule 
