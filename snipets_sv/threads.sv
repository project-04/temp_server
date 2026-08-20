/*module tb;
  event started;

  initial begin
    fork
      begin:beg
        // signal parent immediately
        disable beg;
        ->started;
        // children run independently
        fork
          #10 $display("[%0t] Child1 done",$time);
          #20 $display("[%0t] Child2 done",$time);
        join
      end
    join  // parent waits for the helper thread, not the children

    @(started);
    $display("[%0t] Parent continues immediately (like join_none)", $time);

    #30 $display("[%0t] Simulation ends", $time);
  end
/*
initial
begin

$display("484984648468746874968746584");
end*i/
endmodule
*/

/*
module tb;

int a = 2;

initial begin

fork

begin

#2 a <= 7;

$display("t1 a=%0d", a);

$strobe ("t6 a=%0d", a);

end

begin

#3 a = 9;

$display("t2 a=%0d", a);

end

begin

#6 a <= 3;

$display("t3 a=%0d", a);

$monitor("t4 a=%0d", a);

end

begin

#4 a = 2; $display("t5 a=%0d", a);

end

join

end

endmodule




//fork join none to join

 module tb;


initial begin

$display("start fork");

fork

#10 $display("t1");
#20 $display("t2");
#30 $display("t3");

join_none
wait fork;

$display("end fork");
end

endmodule

//fork join any to join


 module tb;


initial begin

$display("start fork");

fork

#10 $display("t1");
#20 $display("t2");
#30 $display("t3");

join_any
wait fork;

$display("end fork");
end

endmodule

*/
//fork join to join_any
/*

module tb;

event e;
initial begin

//$display($time,"start fork");

fork

begin
#10 $display($time,"t1");
->e;
end

begin
#20 $display($time,"t2");
->e;
end	

begin
#30 $display($time,"t3");
->e;
end

begin
@(e);
$display($time,"complete one thread");
$display($time,"end fork");

end
join
end

endmodule
/*


//fork join to join_none


module tb;

event e;
initial begin

$display($time,"start fork");

fork

begin
@(e);
#10 $display($time,"t1");
end

begin
@(e);
#20 $display($time,"t2");
end

begin
@(e);
#30 $display($time,"t3");
end

begin
#10;
$display($time,"this is first ");
->e;
end
join
$display($time,"end fork");
end

endmodule


//fork join any to join none
/*
module tb;

event e;

initial
begin

$display($time,"start fork");

fork

begin
@(e);
#10;
$display($time,"t1");
end

begin
@(e);
#20;
$display($time,"t2");

end

begin
//$display("this is first");
->e;
end

join_any

$display("this is first");

end
endmodule



//fork join none to join any


module top;

event e;

initial
begin

$display($time,"start fork");


fork

begin
#10;
$display($time,"t1");
->e;
end


begin
#20;
$display($time,"t2");
->e;
end

join_none

@(e);
$display($time,"complete one thread");

end
endmodule
*/

module tb;

initial begin

for(int i =0; i<4; i++)

fork
	
	automatic int j=i;

	#1 $display($time,"value of i is %0d","value of j is %0d", i,j);


join_none

$display("EXITED LOOP");

#5 $finish;
end
endmodule
