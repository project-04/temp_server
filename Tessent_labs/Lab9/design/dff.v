module dflipflop_design(input clock, reset, din, 
                        output reg q, output qb);

always@(posedge clock)
begin
if(reset)
q <= 0;
else
q <=din;
end

assign qb = ~q;

endmodule


