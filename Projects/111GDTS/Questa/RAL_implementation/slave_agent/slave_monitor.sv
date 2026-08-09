class s_monitor extends uvm_monitor;

	`uvm_component_utils(s_monitor)

	virtual intf.SMMP vif;
	s_agent_config s_cfg;
	uvm_analysis_port#(trans) monitor_port;

	function new(string name="s_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(s_agent_config)::get(this,"","s_agent_config",s_cfg))
			`uvm_fatal("S_MON","CANNOT GET SLAVE CONFIG IN SLAVE MON")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=s_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		collect_data;
	endtask

	
	task collect_data;
		trans txn=trans::type_id::create("txn");
		@(vif.smcb);
		wait(vif.smcb.rst==0)
		txn.rd_en=vif.smcb.rd_en;
		txn.data_out=vif.smcb.data_out;
          if(txn.data_out!=0)
		`uvm_info("__slave_monitor__",$sformatf("Printing from slave monitor \n %s",txn.sprint),UVM_LOW)
		monitor_port.write(txn);

	endtask

endclass

