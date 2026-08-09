class ram_env;

virtual ram_if.WR_DRV_MP wr_drv_if;
virtual ram_if.WR_MON_MP wr_mon_if;
virtual ram_if.RD_MON_MP rd_mon_if;

mailbox#(ram_trans) gen2wdrv=new();
mailbox#(ram_trans) wmon2ref=new();
mailbox#(ram_trans) rmon2sb=new();
mailbox#(ram_trans) ref2sb=new();

ram_gen gen_h;
ram_write_drv wdrv_h;
ram_write_mon wmon_h;
ram_read_mon rmon_h;
ram_ref ref_h;
ram_sb sb_h;


function new(
virtual ram_if.WR_DRV_MP wr_drv_if,
virtual ram_if.WR_MON_MP wr_mon_if,
virtual ram_if.RD_MON_MP rd_mon_if);

this.wr_drv_if=wr_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;

endfunction

task build();
gen_h=new(gen2wdrv);
wdrv_h=new(wr_drv_if,gen2wdrv);
wmon_h=new(wr_mon_if,wmon2ref);
rmon_h=new(rd_mon_if,rmon2sb);
ref_h=new(wmon2ref,ref2sb);
sb_h=new(ref2sb,rmon2sb);
endtask

task reset_dut(); 
begin
@(wr_drv_if.wr_drv_cb);
wr_drv_if.wr_drv_cb.reset_n<=1'b0;
repeat(2)
@(wr_drv_if.wr_drv_cb);
wr_drv_if.wr_drv_cb.reset_n<=1'b1;
end
endtask

task start();
gen_h.start();
wdrv_h.start();
wmon_h.start();
rmon_h.start();
ref_h.start();
sb_h.start();
endtask

task stop();
wait(sb_h.e.triggered);
endtask

task run();
reset_dut();
start();
stop();
sb_h.report();
endtask

endclass

