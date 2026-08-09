//`timescale 10ns/1ns

//########## TOP

module top();

bit clk;

always
	#10 clk = ~clk;

dff_if IF(clk);

dff RTL(IF);

testcase TB(IF);

endmodule


//##########  TOP
module testcase(dff_if.DUV_WITH_CB_AND_IMPROT_TASK test_if); //another modport to access the cb and task's
//module testcase(dff_if test_if); //direct connection to interface
initial
begin
        @(test_if.cb);
	test_if.sync_reset;
        @(test_if.cb);
	test_if.load_d0(1);
	test_if.load_d1(0);
	test_if.load_d0(0);
	test_if.load_d1(1);
	#100;
        $finish;
end
endmodule

