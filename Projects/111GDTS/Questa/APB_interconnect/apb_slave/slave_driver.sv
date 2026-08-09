class slave_driver extends uvm_driver#(slave_xtn);

   `uvm_component_utils(slave_driver)

	virtual apb_if.SDR_MP vif;
	slave_config cfg;

extern function new(string name="slave_driver" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

extern task run_phase(uvm_phase phase);
extern task send_to_dut(slave_xtn xtn);
//extern function void report_phase(uvm_phase phase);
endclass

function slave_driver ::new(string name="slave_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void  slave_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db #(slave_config)::get(this,"","slave_config",cfg))
	    `uvm_fatal("slave_driver","cannot get config data ")
endfunction


function void slave_driver::connect_phase(uvm_phase phase);

  vif=cfg.vif;

endfunction

task slave_driver::run_phase(uvm_phase phase);

forever
begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
end
endtask
	
task slave_driver::send_to_dut(slave_xtn xtn);
	
    wait(vif.sdrv_cb.pready)
	
    if(vif.sdrv_cb.Pwrite==0)	
    begin	
    	//vif.sdrv_cb.Pwdata <= xtn.Prdata;
        xtn.Pwrite = vif.sdrv_cb.Pwrite;
    end
    @(vif.sdrv_cb);
//    @(vif.sdrv_cb);

    `uvm_info("SLAVE_DRIVER",$sformatf("Printing from slave driver %s\n",xtn.sprint),UVM_LOW)
			
endtask

