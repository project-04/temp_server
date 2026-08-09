module test;

class c #(type j=bit);
endclass

class d1 #(type p=real) extends c;
endclass

class d2 #(type p=longint) extends c #(int);
endclass

class d3 extends c #(d2);
endclass



d1 h1;
d2 h2;
d3 h3;
initial begin
h1 = new;
$display(h1);
end
endmodule
