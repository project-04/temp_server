class apb_driver extends uvm_driver#(apb_xtn);
	
	virtual apb_if.APB_DRV_MP vif;
	apb_cfg m_cfg;

	int apb_drv_sent_xtn_cnt=0;

     `uvm_component_utils(apb_driver)	
	extern function new(string name = "apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task reset_dut();
	extern task send_to_dut(apb_xtn xtn);
	extern function void report_phase(uvm_phase phase);
	
endclass
function apb_driver::new(string name = "apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction
function void apb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(apb_cfg)::get(this,"","apb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction
 
function void apb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction

task apb_driver::run_phase(uvm_phase phase);
   reset_dut();
   forever 
     begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       seq_item_port.item_done();
     end
	
   @(vif.apb_drv_cb);
   vif.apb_drv_cb.psel <= 1'b0;
 endtask


 task apb_driver :: reset_dut();

   // Reset logic

   @(vif.apb_drv_cb);
   vif.apb_drv_cb.reset <= 1'b1;

   repeat(2)
   @(vif.apb_drv_cb);
   vif.apb_drv_cb.reset<=1'b0;
 endtask


 task apb_driver :: send_to_dut(apb_xtn xtn);

   //Drive the Control Information
   @(vif.apb_drv_cb);

   vif.apb_drv_cb.paddr <= xtn.PADDR;
   vif.apb_drv_cb.pwrite <= xtn.PWRITE;
   vif.apb_drv_cb.psel <= 1'b1;
   vif.apb_drv_cb.penable <=1'b0;

   if(xtn.PWRITE)
     vif.apb_drv_cb.pwdata <= xtn.PWDATA;
   
   // Wait for next cycle and make PENABLE as high

   @(vif.apb_drv_cb);

   vif.apb_drv_cb.penable<=1'b1;

   wait(vif.apb_drv_cb.pready)

   
   `uvm_info(get_type_name(), $sformatf("The Transaction sent to the DUT is  \n %s", xtn.sprint()), UVM_LOW)

  // @(vif.apb_drv_cb);

   apb_drv_sent_xtn_cnt++;
   vif.apb_drv_cb.penable<=1'b0;



 endtask


 function void apb_driver :: report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("APB DRIVER: The no of transactions sent from APB DRIVER are : %0d",apb_drv_sent_xtn_cnt), UVM_LOW)
 endfunction
