class src_mon extends uvm_monitor ;

	`uvm_component_utils(src_mon)
	virtual router_if.SRC_MON_MP vif;
	src_agt_config src_cfg;
	write_xtn xtn;
	uvm_analysis_port #(write_xtn) src_mon_ap;

	function new(string name = "src_mon",uvm_component parent = null);
		super.new(name,parent);
		src_mon_ap = new("src_mon_ap",this);
	endfunction 
		
	virtual function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db #(src_agt_config)::get(this,"","src_agt_config",src_cfg))
			`uvm_fatal("src_MONITOR","not able to get")
			
		super.build_phase(phase);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		vif = src_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			begin
				rcvd_from_dut(xtn);
			end
	endtask	
	
task rcvd_from_dut(output write_xtn item);
    
	
    wait(vif.src_mon_cb.pkt_valid === 1 && vif.src_mon_cb.busy ===0 );
		item = write_xtn::type_id::create("item");
		
    	item.header = vif.src_mon_cb.data_in;
		
		item.payload = new[item.header[7:2]];
	repeat(2)@(vif.src_mon_cb);

    foreach(item.payload[i])
		begin
				wait(vif.src_mon_cb.pkt_valid !== 0 && vif.src_mon_cb.busy !==1) 
				repeat(2) @(vif.src_mon_cb);
					item.payload[i] = vif.src_mon_cb.data_in;
					#5;
				
		end
		
		@(vif.src_mon_cb);
		#5;
		item.parity = vif.src_mon_cb.data_in;
		item.error = vif.src_mon_cb.error;
		item.busy = vif.src_mon_cb.busy;
    
    `uvm_info("SRC_MONITOR", $sformatf("Received transaction:\n%s", item.sprint()), UVM_MEDIUM)
	src_mon_ap.write(item);
endtask
endclass
