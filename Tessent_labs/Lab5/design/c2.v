module c2 (a, b, c, d, z);

input a,b,c,d;
output z;

wire e,f,g,h,i,j,k;

not NOT1(e, d);
not NOT2(f, c);
and AND1(g, a, e, f);
nand NAND1(h, b, c);
and AND2(i, f, d);
nand NAND2(j, g, h);
nand NAND3(k, h, i);
and AND3(z, j, k);

endmodule

