

class ahb_monitor extends uvm_monitor;

	`uvm_component_utils(ahb_monitor)

	function new(string name = "ahb_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	ahb_config ahb_cfg;
	virtual ahb_if.ahb_mon_drv ahb_f;

	ahb_trans t1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
			`uvm_fatal("AHB_MONITOR","failed to get config");

	endfunction 


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		this.ahb_f = ahb_cfg.ahb_f;

	endfunction 

	task run_phase(uvm_phase phase);
		t1 = ahb_trans::type_id::create("t1");
		collect_data();
		t1.print();	
	endtask

	task collect_data();
		
		while(ahb_f.ahb_mon_cb.Hreadyout == 0) // check for hready out .. if hready is 1 thn move to next else be here in loop
			@(ahb_f.ahb_mon_cb);

		while(ahb_f.ahb_mon_cb.Htrans!==3 && ahb_f.ahb_mon_cb.Htrans!==2)
			@(ahb_f.ahb_mon_cb);
			t1.Haddr <= ahb_f.ahb_mon_cb.Haddr;
			t1.Hburst <= ahb_f.ahb_mon_cb.Hburst;
			t1.Htrans <= ahb_f.ahb_mon_cb.Htrans;
			t1.Hsize <= ahb_f.ahb_mon_cb.Hsize;
			t1.Hreadyin <= ahb_f.ahb_mon_cb.Hreadyin;
			
		@(ahb_f.ahb_mon_cb);
		while(ahb_f.ahb_mon_cb.Hreadyout === 0 )
			@(ahb_f.ahb_mon_cb);
			if(ahb_f.ahb_mon_cb.Hwrite===1)
				t1.Hwdata <= ahb_f.ahb_mon_cb.Hwdata;
			else
				t1.Hrdata <= ahb_f.ahb_mon_cb.Hrdata;
	
	endtask			
			

endclass		
