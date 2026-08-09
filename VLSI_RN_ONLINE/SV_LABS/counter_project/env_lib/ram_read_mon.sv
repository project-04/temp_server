class ram_read_mon;

virtual ram_if.RD_MON_MP rd_mon_if;

ram_trans data2sb;

mailbox#(ram_trans) rmon2sb;

function new(virtual ram_if.RD_MON_MP rd_mon_if,mailbox#(ram_trans)rmon2sb);
this.rd_mon_if=rd_mon_if;
this.rmon2sb=rmon2sb;
this.data2sb=new();
endfunction

task monitor();
@(rd_mon_if.rd_mon_cb);
begin
data2sb.data_out=rd_mon_if.rd_mon_cb.data_out;
data2sb.display("DATA FROM READ MONITOR");
end

endtask

virtual task start();
fork
forever begin
monitor();
rmon2sb.put(data2sb);
end
join_none
endtask

endclass


