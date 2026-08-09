class wr_mon extends uvm_monitor;
	`uvm_component_utils(wr_mon)
	virtual ven_if.WR_MON_MP vif;
	uvm_analysis_port #(wr_trans) mon_port;
	wr_trans xtn;
	
	function new(string name = "wr_mon", uvm_component parent);
		super.new(name, parent);
		mon_port = new("mon_port", this);
	endfunction
	
	task collect();
		xtn = wr_trans::type_id::create("xtn");
		
		@(vif.wr_mon_cb);
		
		xtn.reset = vif.wr_mon_cb.reset;
		xtn.coin_in = vif.wr_mon_cb.coin_in;
		
		mon_port.write(xtn);
		//xtn.print();
		
		`uvm_info("wr_drv", "wr_drv send_to_dut", UVM_LOW)
	endtask
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(vif.wr_mon_cb);
		@(vif.wr_mon_cb);
		
		forever
		begin
			collect();
		end
	endtask
endclass
