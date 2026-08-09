module test();
int a;

function byte hello();
return 10;
endfunction;

initial begin

$display(hello());

end
endmodule
