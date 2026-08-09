class src_drv extends uvm_driver #(write_xtn);

	`uvm_component_utils(src_drv)
	virtual router_if.SRC_DRV_MP vif;
	src_agt_config src_cfg;
	
	function new(string name = "src_drv",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
		
	virtual function void build_phase(uvm_phase phase);
	
		if(!uvm_config_db #(src_agt_config)::get(this,"","src_agt_config",src_cfg))
			`uvm_fatal("DEST_AGENT","not able to get")
			
		super.build_phase(phase);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		vif = src_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
	
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask	
	
task send_to_dut(write_xtn item);
    `uvm_info("SRC_DRIVER",$sformatf("printing from source driver \n %s", item.sprint()),UVM_LOW)
   // $display("1111111111111111111111111111111111111111111111111111111111111111111111");
	reset;

    wait(vif.src_drv_cb.busy === 0 );
    @(vif.src_drv_cb);
   // $display("222222222222222222222222222222222222222222222222222222222222222");
    vif.src_drv_cb.pkt_valid <= 1;
    vif.src_drv_cb.data_in <= item.header;
    @(vif.src_drv_cb);
  //  $display("333333333333333333333333333333333333333333333333333333333333333");
    foreach(item.payload[i]) 
		begin
		 	wait(vif.src_drv_cb.busy === 0 );
				@(vif.src_drv_cb);
		//	$display("44444444444444444444444444444444444444444444444444444");
			@(vif.src_drv_cb);
			vif.src_drv_cb.data_in <= item.payload[i];
		end
 //  $display("55555555555555555555555555555555555555555555555555555555555555555");
    @(vif.src_drv_cb);
    vif.src_drv_cb.pkt_valid <= 0;
    vif.src_drv_cb.data_in   <= item.parity;
  //  $display("666666666666666666666666666666666666666666666666666666666666666666");
endtask

task reset;
	@(vif.src_drv_cb); 
    vif.src_drv_cb.resetn <= 0;
    repeat(2)  @(vif.src_drv_cb);  
    vif.src_drv_cb.resetn <= 1;  
endtask

endclass


