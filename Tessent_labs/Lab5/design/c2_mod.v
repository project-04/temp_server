module c2(a, b, c, d, z, o1, t1, t2, tm);

input a,b,c,d;
output z;

input tm; // test_mode
input t1, t2; // test input
output o1; //observation output

wire e,f,g,h,i,j,k; 
wire s1, s2;

not NOT1(e, d);
not NOT2(f, c);
and AND1(g, a, e, f);

or OR_T1(g1, g, s1); // test point 1
and AND_T1(s1, t1, tm);

or OR_T2(i1, i, s2); // test point 2
and AND_T2(s2, t2, tm);

nand NAND1(h, b, c);
and AND_O1(o1, g, tm); // observation point
and AND2(i, f, d);
nand NAND2(j, g1, h);
nand NAND3(k, h, i1);
and AND3(z, j, k);

endmodule

