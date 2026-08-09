class m_driver extends uvm_driver#(trans);

	`uvm_component_utils(m_driver)

	virtual av_if.MDMP vif;

	m_agent_config m_cfg;

	function new(string name="m_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(m_agent_config)::get(this,"","m_agent_config",m_cfg))
			`uvm_fatal("M_DRV","CANNOT GET MASTER CONFIG IN MASTER DRV")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(vif.mdcb)	
		vif.mdcb.hresetn<=0;
		@(vif.mdcb)	
		vif.mdcb.hresetn<=1;
		@(vif.mdcb)	
		forever begin
			seq_item_port.get_next_item(req);
			send_dut(req);
			seq_item_port.item_done;
		end
	endtask
	

	task send_dut(trans txn);	
		//wait(vif.mdcb.hready_out)
		vif.mdcb.htrans<=txn.htrans;
		vif.mdcb.hwrite<=txn.hwrite;
		vif.mdcb.haddr<=txn.haddr;
		vif.mdcb.hsize<=txn.hsize;
		vif.mdcb.hburst<=txn.hburst;
		vif.mdcb.hlen<=txn.hlen;
		@(vif.mdcb);
		wait(vif.mdcb.hready_out)
		if(txn.hwrite)
			vif.mdcb.hwdata<=txn.hwdata;
		`uvm_info("MASTER DRV",$sformatf("THIS IS AHB DRIVER \n %s",txn.sprint),UVM_LOW)
	endtask

endclass

