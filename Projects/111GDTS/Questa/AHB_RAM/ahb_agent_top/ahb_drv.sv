class ahb_drv extends uvm_driver;

`uvm_component_utils(ahb_drv)
virtual bridge_if.MDR_MP vif;
ahb_agent_config hcfg;

extern function new(string name="ahb_drv" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

extern task run_phase(uvm_phase phase);
extern task send_to_dut(ahb_xtn xtn);
//extern function void report_phase(uvm_phase phase);
endclass
function ahb_drv ::new(string name="ahb_drv",uvm_component parent);
super.new(name, parent);
endfunction

function void  ahb_drv::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_top",hcfg))
`uvm_fatal("ahb_drv","cannot get config data ")
endfunction

function void ahb_drv::connect_phase(uvm_phase phase);

vif=hcfg.vif;
super.connect_phase(phase);

endfunction

task ahb_drv::run_phase(uvm_phase phase);
@(vif.mdr_cb)
vif.mdr_cb.Hresetn <= 0;
@(vif.mdr_cb)
vif.mdr_cb.Hresetn <=1;
forever
begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
end
endtask
	
task ahb_drv::send_to_dut(ahb_xtn xtn);

	vif.mdr_cb.Hsize <= xtn.Hsize;
	vif.mdr_cb.Hsel <= xtn.Hsel;
	vif.mdr_cb.Hburst <= xtn.Hburst;
	vif.mdr_cb.Htrans <= xtn.Htrans;
	vif.mdr_cb.Hwrite <= xtn.Hwrite;
	vif.mdr_cb.length <= xtn.length;
	vif.mdr_cb.Hreadyin <=xtn.Hready_in;
		
		vif.mdr_cb.Haddr <= xtn.Haddr;
		@(vif.mdr_cb);
		wait(vif.mdr_cb.Hreadyout);
		if(xtn.Hwrite==1'b1)	
		vif.mdr_cb.Hwdata <= xtn.Hwdata;
		xtn.Hresp=vif.mdr_cb.Hresp;
	`uvm_info("ahb_drv",$sformatf("Printing from driver /n %s",xtn.sprint()),UVM_LOW)
endtask



