class count_env;

virtual count_if.DRV dr_if;
virtual count_if.WR_MON wrmon_if;
virtual count_if.RD_MON rdmon_if;

mailbox #(count_trans)gen2dr =new();
mailbox #(count_trans)rm2sb  =new();
mailbox #(count_trans)mon2sb =new();
mailbox #(count_trans)mon2rm =new();

count_gen gen_h;
count_wr_mon wrmon_h;
count_driver dri_h;
count_rd_mon rdmon_h;
count_sb sb_h;
count_model mod_h;

function new(virtual count_if.DRV dr_if,virtual count_if.WR_MON wrmon_if,virtual count_if.RD_MON rdmon_if);
	this.dr_if=dr_if;
	this.wrmon_if=wrmon_if;
	this.rdmon_if=rdmon_if;
endfunction

virtual task build();
	gen_h =new(gen2dr);
	dri_h =new(dr_if,gen2dr);
	wrmon_h=new(wrmon_if,mon2rm);
	rdmon_h=new(rdmon_if,mon2sb);
	mod_h =new(mon2rm,rm2sb);
	sb_h=new(rm2sb,mon2sb);
endtask

virtual task reset_duv();
	@(dr_if.dr_cb);
	dr_if.dr_cb.resetn<=1'b1;
	repeat(2)
		@(dr_if.dr_cb);
	dr_if.dr_cb.resetn<=1'b0;
	//@(dr_if.dr_cb);
endtask

virtual task start();
	gen_h.start;
	dri_h.start;
	wrmon_h.start;
	rdmon_h.start;
	mod_h.start;
	sb_h.start;
endtask

virtual task stop();
	wait(sb_h.DONE.triggered);
endtask

virtual task run();
	reset_duv();
	start();
	//$display("gen2dr=%p", gen2dr);
	//$display("rm2sb=%p", rm2sb);
	//$display("mon2sb=%p", mon2sb);
	//$display("mon2rm=%p", mon2rm);
	stop();
	sb_h.report();
endtask
endclass
