`include "test.sv"
module top;


parameter cycle=10;
bit clk;

ram_if DUV_IF(clk);

test t_h;

mod12counter DUV(.clk(clk),.data_in(DUV_IF.data_in),.load(DUV_IF.load),.reset_n(DUV_IF.reset_n),.up(DUV_IF.up),.data_out(DUV_IF.data_out));

initial begin
clk=1'b0;
forever #(cycle/2) clk=~clk;
end

initial begin
/*
 $fsdbDumpfile("novas.fsdb");
 $fsdbDumpvars(0, top); 
*/
t_h=new(DUV_IF,DUV_IF,DUV_IF);
t_h.build_and_run();
$finish;

end



endmodule

