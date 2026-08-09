class axi_mast_agt_cfg extends uvm_object;
	`uvm_object_utils(axi_mast_agt_cfg)

	// Properties
	static int mast_mon_rcvd_xtn_cnt=0;
	static int mast_drv_xtn_sent_cnt =0;
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual axi_mif a_if;
	
	//Methods
	extern function new(string name="axi_mast_agt_cfg");

endclass

function axi_mast_agt_cfg :: new(string name="axi_mast_agt_cfg");
	super.new(name);
endfunction
