class master_driver extends uvm_driver#(master_xtn);

   `uvm_component_utils(master_driver)

	virtual apb_if.MDR_MP vif;
	master_config cfg;

extern function new(string name="master_driver" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

extern task run_phase(uvm_phase phase);
extern task send_to_dut(master_xtn xtn);
//extern function void report_phase(uvm_phase phase);
endclass

function master_driver ::new(string name="master_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void  master_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db #(master_config)::get(this,"","master_config",cfg))
	    `uvm_fatal("master_driver","cannot get config data ")
endfunction


function void master_driver::connect_phase(uvm_phase phase);

   vif=cfg.vif;

endfunction

task master_driver::run_phase(uvm_phase phase);
@(vif.mdrv_cb)
vif.mdrv_cb.Preset_n <= 0;
@(vif.mdrv_cb)
vif.mdrv_cb.Preset_n <= 1;

forever
begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
end
endtask
	
task master_driver::send_to_dut(master_xtn xtn);
	vif.mdrv_cb.Pwrite <= xtn.Pwrite;
	vif.mdrv_cb.transfer <= 1;
	vif.mdrv_cb.Paddr <= xtn.Paddr;
	//	@(vif.mdrv_cb);
		wait(vif.mdrv_cb.pready);
        if(xtn.Pwrite)	
		    vif.mdrv_cb.Pwdata <= xtn.Pwdata;
		@(vif.mdrv_cb);
    `uvm_info("MASTER_DRIVER",$sformatf("Printing from master driver %s\n",xtn.sprint),UVM_LOW)
			
endtask

