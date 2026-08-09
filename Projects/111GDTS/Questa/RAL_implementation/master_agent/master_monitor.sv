class m_monitor extends uvm_monitor;

	`uvm_component_utils(m_monitor)

	virtual intf.MMMP vif;

	m_agent_config m_cfg;
	trans txn;
	uvm_analysis_port#(trans)monitor_port;

	function new(string name="m_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(m_agent_config)::get(this,"","m_agent_config",m_cfg))
			`uvm_fatal("M_MON","CANNOT GET MASTER CONFIG IN MASTER MON")
		txn=trans::type_id::create("txn");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
			collect_data(txn);
	endtask
	

	task collect_data(trans txn);
		@(vif.mmcb);
          wait(vif.mmcb.rst==0)
		txn.wr_en=vif.mmcb.wr_en;
		txn.addr=vif.mmcb.addr;
		txn.data_in=vif.mmcb.data_in;
          if(txn.addr!=0)
          `uvm_info("__master_monitor__",$sformatf("THIS IS Master Monitor \n %s",txn.sprint),UVM_LOW)
		monitor_port.write(txn);
	endtask

endclass

