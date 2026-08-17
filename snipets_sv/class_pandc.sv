class parent;
  int balance = 100;
endclass

class child extends parent;
  int balance = 200;
endclass
/*
class drv extends uvm_agent;
`uvm_component(drv)
function new(string name, uvm_component parent)
	super.new(name, parent)
	endfunction
endclass
*/
module tb;

  child c;
  parent p;
  initial begin
    c = new();
    p = new();
    $display("%p", c);
    $display("%p", p);
  end
endmodule
