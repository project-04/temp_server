class m_driver extends uvm_driver#(trans);

	`uvm_component_utils(m_driver)

	virtual intf.MDMP vif;

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
		vif.mdcb.rst<=1;
		@(vif.mdcb)	
		vif.mdcb.rst<=0;
		forever 
           begin
			seq_item_port.get_next_item(req);
			send_dut(req);
			seq_item_port.item_done;
	  	 end
	endtask
	

	task send_dut(trans txn);	
		@(vif.mdcb);
		vif.mdcb.wr_en<=txn.wr_en;
		vif.mdcb.addr<=txn.addr;
		vif.mdcb.data_in<=txn.data_in;
		`uvm_info("__master_driver__",$sformatf("THIS IS Master Driver \n %s",txn.sprint),UVM_LOW)
	endtask

endclass

