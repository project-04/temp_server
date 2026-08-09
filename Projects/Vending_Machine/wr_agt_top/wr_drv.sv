class wr_drv extends uvm_driver #(wr_trans);
	`uvm_component_utils(wr_drv)
	virtual ven_if.WR_DRV_MP vif;
	
	function new(string name = "wr_drv", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task send_to_dut(wr_trans xtn);
		
		//vif.wr_drv_cb.reset <= xtn.reset;
		vif.wr_drv_cb.reset <= 0;
		vif.wr_drv_cb.coin_in <= xtn.coin_in;
		
		@(vif.wr_drv_cb);
		//xtn.print();
		
		`uvm_info("wr_drv", "wr_drv send_to_dut", UVM_LOW)
	endtask
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(vif.wr_drv_cb);
		vif.wr_drv_cb.reset <= 1;
		@(vif.wr_drv_cb);
		vif.wr_drv_cb.reset <= 0;
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
	endtask
endclass
