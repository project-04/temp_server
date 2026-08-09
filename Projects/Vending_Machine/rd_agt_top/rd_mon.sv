class rd_mon extends uvm_monitor;
	`uvm_component_utils(rd_mon)
	virtual ven_if.RD_MON_MP vif;
	uvm_analysis_port #(rd_trans) mon_port;
	rd_trans xtn;
	
	function new(string name = "rd_mon", uvm_component parent);
		super.new(name, parent);
		mon_port = new("mon_port", this);
	endfunction
	
	task collect();
		xtn = rd_trans::type_id::create("xtn");
		
		@(vif.rd_mon_cb);
		
		xtn.done_out = vif.rd_mon_cb.done_out;
		xtn.lsb7seg_out = vif.rd_mon_cb.lsb7seg_out;
		xtn.msb7seg_out = vif.rd_mon_cb.msb7seg_out;
		
		mon_port.write(xtn);
		//xtn.print();
		
		`uvm_info("wr_drv", "wr_drv send_to_dut", UVM_LOW)
	endtask
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(vif.rd_mon_cb);
		@(vif.rd_mon_cb);
		
		
		@(vif.rd_mon_cb);
		forever
		begin
			collect();
		end
	endtask
endclass
