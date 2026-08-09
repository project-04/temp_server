module temp;

class test;

  rand int a[];

  function bit fun(int temp[]);
    int max, min, count_max, count_min;

    max = temp.max()[0];
    min = temp.min()[0];

    foreach(temp[i]) begin
      if(max == temp[i]) count_max++;
      if(min == temp[i]) count_min++;
    end

    return ((count_max + count_min) == 2);
  endfunction

  constraint c1 {
    a.size() == 10;
  }

  constraint c2 {
    foreach(a[i])
      a[i] inside {[1:10]};
  }

endclass

test h;

initial begin

  h = new();

  do begin
    assert(h.randomize());
  end while (!h.fun(h.a));

  $display("%p", h.a);
  $display("%p", h.a.max()[0]);
  $display("%p", h.a.min()[0]);

end

endmodule
