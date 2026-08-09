class axi_slv_agt_cfg extends uvm_object;
	`uvm_object_utils(axi_slv_agt_cfg)

	// Properties
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	static int slv_mon_rcvd_xtn_cnt = 0;
	static int slv_drv_xtn_sent_cnt = 0;

	virtual axi_sif a_if;

	// Methods
	extern function new(string name ="axi_slv_agt_cfg");

endclass

function axi_slv_agt_cfg :: new(string name="axi_slv_agt_cfg");
	super.new(name);
endfunction
