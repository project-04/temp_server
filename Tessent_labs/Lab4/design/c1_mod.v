module c1 (a, c, d, z);

input a,c,d;
output z;

wire f,g,i,j,k;

//not NOT1(e, d);
not NOT2(f, c);
and AND1(g, a, f);
//nand NAND1(h, b, c);
and AND2(i, f, d);
not NOT3(j, g);
not NOT4(k, i);
and AND3(z, j, k);


endmodule

