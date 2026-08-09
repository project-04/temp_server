/*
ACTIVE REGION
1. wait(event.triggered) //block the execution
2. ->event
3. @event //block the execution


NBA REGION
1. ->>event


REACTIVE REGION
1. wait(event.triggered) //will unblock the execution or resume the execution
2. @event //will unblock the execution or resume the execution


so, in inactive #0 and in NBA <=(non-blocking) statments will not execute. if they are like this 
@event;
#0 a = 10; (InActive)
b <= 10; (NBA)
#0 c <= 10; (NBA)
10 not assiged to a;
10 not assiged to b;
10 not assiged to c;  
*/

// #0 <=, will execute in NBA region


module test1;
	event ev;
	initial begin
	    #5 -> ev;  // triggers event at time 5
	end

	initial begin
	    $display(" ######### Waiting @ev at time %0t", $time);
	    @ev;
	    $display(" ######### Triggered @ev at time %0t", $time);
	end

	initial begin
	    $display(" ######### Waiting wait(ev.triggered) at time %0t", $time);
	    wait(ev.triggered);
	    $display(" ######### Triggered wait(ev.triggered) at time %0t", $time);
	end
endmodule



module test1;
	event ev;
	initial begin
	    #5;
	    -> ev;  // triggers event at time 5
	end

	initial begin
	    #5;
	    $display(" ######### Waiting @ev at time %0t", $time);
	    @ev;
	    $display(" ######### Triggered @ev at time %0t", $time);
	end

	initial begin
	    #5;
	    $display(" ######### Waiting wait(ev.triggered) at time %0t", $time);	
	    wait(ev.triggered);
	    $display(" ######### Triggered wait(ev.triggered) at time %0t", $time);
	end
endmodule



module test1;
	event ev;
	int a,b;
	initial begin
	    #5;
	    -> ev;  // triggers event at time 5
	end

	initial begin
	    #5;
	    $display(" ######### Waiting @ev at time %0t", $time);
	    @ev;
	    a <= 5;
	    $display(" ######### Triggered @ev at time %0t a=%0d", $time, a);
	end

	initial begin
	    $strobe(ev);	
	    #5;
	    $display(" ######### Waiting wait(ev.triggered) at time %0t", $time);
	    
	    $strobe("b S",ev);
	    $display("b D",ev);
	    wait(ev.triggered);
	    b <= 20;
	    #0 b <= 10;
	    $strobe(" ######### s Triggered wait(ev.triggered) at time %0t b=%0d", $time,b);
	    $strobe("S",ev);
	    $display("D",ev);
	    
	    $display(" ######### d Triggered wait(ev.triggered) at time %0t b=%0d", $time,b);
	end
endmodule
