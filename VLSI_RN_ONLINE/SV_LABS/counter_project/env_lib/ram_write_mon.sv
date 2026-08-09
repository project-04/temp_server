class ram_write_mon;

virtual ram_if.WR_MON_MP wr_mon_if;

ram_trans wmon_data;
ram_trans cov_data;

mailbox#(ram_trans) wmon2ref;

covergroup mem_coverage; 
LOAD: coverpoint cov_data.load;
UP: coverpoint cov_data.up;
DATA: coverpoint cov_data.data_in{
ignore_bins COUNT = {[12:15]};
}
RESET: coverpoint cov_data.reset_n;

endgroup

function new(virtual ram_if.WR_MON_MP wr_mon_if,mailbox#(ram_trans)wmon2ref);
this.wr_mon_if=wr_mon_if;
this.wmon2ref=wmon2ref;
this.wmon_data=new();
mem_coverage=new();
endfunction


virtual task monitor();
@(wr_mon_if.wr_mon_cb);
begin
wmon_data.load=wr_mon_if.wr_mon_cb.load;
wmon_data.up=wr_mon_if.wr_mon_cb.up;
wmon_data.reset_n=wr_mon_if.wr_mon_cb.reset_n;
wmon_data.data_in=wr_mon_if.wr_mon_cb.data_in;
wmon_data.display("DATA FROM WRITE MONITOR");
end

endtask

virtual task start();
fork
forever begin
monitor();
cov_data=new wmon_data;
mem_coverage.sample();
wmon2ref.put(wmon_data);
end
join_none
endtask

endclass

