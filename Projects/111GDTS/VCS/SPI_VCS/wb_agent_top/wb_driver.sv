class wb_driver extends uvm_driver #(wb_xtn);

	`uvm_component_utils(wb_driver)
wb_agent_config wb_cfg;
	virtual spi_if.WB_DRV vif;
extern function new(string name ="wb_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(wb_xtn xtnh);

endclass

function wb_driver::new(string name ="wb_driver", uvm_component parent);
	super.new(name,parent);
endfunction

function void wb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
`uvm_info("wb_driver","This is in WB_DRIVER",UVM_LOW)
uvm_config_db#(wb_agent_config)::get(this,"","wb_agent_config",wb_cfg);
endfunction

function void wb_driver::connect_phase(uvm_phase phase);
vif=wb_cfg.vif_0;
 super.connect_phase(phase);

endfunction


task wb_driver::run_phase(uvm_phase phase);
 // wb_xtn xtnh;
	
@(vif.wb_drv_cb);
vif.wb_drv_cb.wb_rst_i<=1'b1;
vif.wb_drv_cb.wb_stb_i<=1'b0;
vif.wb_drv_cb.wb_cyc_i<=1'b0;
@(vif.wb_drv_cb);
vif.wb_drv_cb.wb_rst_i<=1'b0;

//xtnh=wb_xtn::type_id::create("xtnh");

forever
	begin
		seq_item_port.get_next_item(req);
			send_to_dut(req);
		seq_item_port.item_done();
	end
endtask

task wb_driver::send_to_dut(wb_xtn xtnh);
 `uvm_info(get_type_name(),$sformatf("printing from driver \n %s", xtnh.sprint()),UVM_LOW)


	

	@(vif.wb_drv_cb);
		vif.wb_drv_cb.wb_stb_i<=1'b1;
		vif.wb_drv_cb.wb_cyc_i<=1'b1;	
		vif.wb_drv_cb.wb_dat_i<=xtnh.wb_dat_i;		
		vif.wb_drv_cb.wb_adr_i<=xtnh.wb_adr_i;
		vif.wb_drv_cb.wb_we_i<=xtnh.wb_we_i;
		vif.wb_drv_cb.wb_sel_i<=4'b1111;

//	@(vif.wb_drv_cb);
		while(vif.wb_drv_cb.wb_ack_o!==1)
		@(vif.wb_drv_cb)

		vif.wb_drv_cb.wb_stb_i<=1'b0;
		vif.wb_drv_cb.wb_cyc_i<=1'b0;


	/*if(xtnh.wb_we_i==0 &&(xtnh.wb_adr_i=='h00))
	begin
		wait(vif.wb_drv_cb.wb_int_o);
	end
	@(vif.wb_drv_cb);*/
endtask	
		
