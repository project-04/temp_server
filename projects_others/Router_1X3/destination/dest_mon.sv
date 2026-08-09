class dest_mon extends uvm_monitor;

	`uvm_component_utils(dest_mon)
	virtual router_if.DEST_MON_MP vif;
	dest_agt_config dest_cfg;
	read_xtn xtn;
	uvm_analysis_port #(read_xtn) dest_mon_ap;
	function new(string name = "dest_mon",uvm_component parent = null);
		super.new(name,parent);
		dest_mon_ap = new("dest_mon_ap",this);
	endfunction 
		
	virtual function void build_phase(uvm_phase phase);
	
		if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",dest_cfg))
			`uvm_fatal("DEST_MONITOR","not able to get")
			
		super.build_phase(phase);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		vif = dest_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			begin
				//xtn = read_xtn::type_id::create("xtn");
				rcvd_from_dut(xtn);
			end
	endtask	
	
task rcvd_from_dut(output read_xtn item);

    wait(vif.dest_mon_cb.valid_out === 1 && vif.dest_mon_cb.read_enb === 1);
		item = read_xtn::type_id::create("item");
	
		item.header = vif.dest_mon_cb.data_out;
		
			item.payload = new[item.header[7:2]];
    
			foreach(item.payload[i]) 
				begin
					wait(vif.dest_mon_cb.read_enb === 1);
					repeat(2) @(vif.dest_mon_cb);
						item.payload[i] = vif.dest_mon_cb.data_out;
				end
		
			@(vif.dest_mon_cb);
			item.parity = vif.dest_mon_cb.data_out;
			if(item.header >=1)
				begin 
					`uvm_info("DEST_MON", $sformatf(" transaction from destination monitor \n%s", item.sprint()), UVM_LOW)
					dest_mon_ap.write(item);
				end
endtask
	
endclass

         
