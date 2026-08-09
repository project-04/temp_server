module c1 (a,b,c,d,z);

input a,b,c,d;
output z;

wire e,f,g, h, i,j;

assign f = e;
assign g = e;

or or1(h,a,f);
and and1 (e, b, c);
nor nor1 (i, g, d);
and and2 (z, h, i);


endmodule

