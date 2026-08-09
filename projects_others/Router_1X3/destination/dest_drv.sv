class dest_drv extends uvm_driver #(read_xtn);

	`uvm_component_utils(dest_drv)
	virtual router_if.DEST_DRV_MP vif;
	dest_agt_config dest_cfg;
	int rd_count = 0;
	//uvm_seq_item_pull_port #(read_xtn) seq_item_port;

	
	function new(string name = "dest_drv",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
		
	virtual function void build_phase(uvm_phase phase);
	
		if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",dest_cfg))
			`uvm_fatal("DEST_DRIVER","not able to get")
			
		super.build_phase(phase);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		vif = dest_cfg.vif;
	endfunction
		
	task run_phase(uvm_phase phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask	
	
    task send_to_dut(read_xtn item);
        `uvm_info("DEST_DRIVER",$sformatf("printing from destination driver \n %s", item.sprint()),UVM_LOW) 
       	 $display("/////////////////////////////////////",item.count);
		wait(vif.dest_drv_cb.valid_out===1)
			repeat(item.count)
				@(vif.dest_drv_cb);
					vif.dest_drv_cb.read_enb <= 1;
				
		wait(vif.dest_drv_cb.valid_out===0)
			@(vif.dest_drv_cb);
				vif.dest_drv_cb.read_enb <= 0;
		
    endtask

endclass
