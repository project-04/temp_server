class count_wr_mon;

virtual count_if.WR_MON wrmon_if;

count_trans data2rm, wr_data;

mailbox #(count_trans) mon2rm;

function new(virtual count_if.WR_MON wrmon_if,mailbox #(count_trans) mon2rm);
begin
	this.wrmon_if=wrmon_if;
	this.mon2rm=mon2rm;
	this.wr_data = new;
end
endfunction

virtual task monitor();
begin
	@(wrmon_if.wr_cb);
	wr_data.up_down	= wrmon_if.wr_cb.up_down;
	wr_data.load	= wrmon_if.wr_cb.load;
	wr_data.data_in	= wrmon_if.wr_cb.data_in;
    	wr_data.resetn	= wrmon_if.wr_cb.resetn;
    	
    	wr_data.count	= wrmon_if.wr_cb.count;
    	
	wr_data.display("From Write Monitor");
end
endtask

virtual task start();
fork
forever
begin
	monitor();
	data2rm = new wr_data;
	mon2rm.put(data2rm);
	//$display("mon2rm=%p", mon2rm.peek(data2rm));
end
join_none
endtask
endclass
