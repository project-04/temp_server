
class ahb_drv extends uvm_driver#(ahb_xtn);
virtual ahb_if.SDRV_MP vif;
ahb_cfg m_cfg;

     `uvm_component_utils(ahb_drv)	
	extern function new(string name = "ahb_drv",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(ahb_xtn xtn);

endclass

function ahb_drv::new(string name = "ahb_drv",uvm_component parent);
	super.new(name,parent);
endfunction
function void ahb_drv::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(ahb_cfg)::get(this,"","ahb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction
 
function void ahb_drv::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
uvm_top.print_topology();
vif=m_cfg.vif;
endfunction

task ahb_drv::run_phase(uvm_phase phase);
super.run_phase(phase);

	@(vif.sdrv_cb);
		vif.sdrv_cb.HRESETn<=0;
	vif.sdrv_cb.HREADY<=1;

	@(vif.sdrv_cb);
	@(vif.sdrv_cb);
		vif.sdrv_cb.HRESETn<=1;
	@(vif.sdrv_cb);

 		forever
               	 begin
                        seq_item_port.get_next_item(req);
                       	    send_to_dut(req);
                        seq_item_port.item_done();

               // req.print();
                end

endtask


task ahb_drv::send_to_dut(ahb_xtn xtn);

	//@(vif.sdrv_cb);

	vif.sdrv_cb.HRESP<=0;
	vif.sdrv_cb.HGRANT<=1;
	vif.sdrv_cb.HMASTER<=1;

//	@(vif.sdrv_cb);
	
	xtn.HWRITE=vif.sdrv_cb.HWRITE;
	
	if(xtn.HWRITE==0)
	vif.sdrv_cb.HRDATA<=xtn.HRDATA;
	@(vif.sdrv_cb);
	
	vif.sdrv_cb.HREADY<=0;
	//vif.sdrv_cb.HREADY<=0;
	 //repeat($urandom_range(1,5))
	@(vif.sdrv_cb);
		
//$display("AHB DRV = %p",xtn);
endtask 
