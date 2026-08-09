import ram_pkg::*;

class test;

virtual ram_if.WR_DRV_MP wr_drv_if;
virtual ram_if.WR_MON_MP wr_mon_if;
virtual ram_if.RD_MON_MP rd_mon_if;

ram_env eh;


function new(virtual ram_if.WR_DRV_MP wr_drv_if,virtual ram_if.WR_MON_MP wr_mon_if,virtual ram_if.RD_MON_MP rd_mon_if);

this.wr_drv_if=wr_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
eh=new(wr_drv_if,wr_mon_if,rd_mon_if);

endfunction

task build_and_run();

    no_of_transaction = 150;
    eh.build();
    eh.run();
    $finish;
  
endtask

endclass

