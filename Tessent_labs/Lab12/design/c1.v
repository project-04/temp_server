module c1 (A,B,C,X,Y,Z);

input A,B,C;
output X,Y,Z;
wire a,b,c;

assign a=A;
assign b=B;
assign c=C;

assign X=a^b^c;
assign Y=(a&b)|(a&c)|(b&c); 
assign Z=(~a&b)|(~a&c)|(b&c); 

endmodule
