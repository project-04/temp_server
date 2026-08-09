
class apb_monitor extends uvm_monitor;

virtual apb_if.APB_MON_MP vif;
apb_cfg m_cfg;
uvm_analysis_port#(apb_xtn) monitor_port;

	int apb_mon_rcvd_xtn_cnt=0;

     `uvm_component_utils(apb_monitor)	
	extern function new(string name = "apb_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	extern function void report_phase(uvm_phase phase);
endclass

function apb_monitor::new(string name = "apb_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction
function void apb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(apb_cfg)::get(this,"","apb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")



endfunction
  
function void apb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task apb_monitor::run_phase(uvm_phase phase);
   forever 
     begin
       collect_data();
     end
 endtask

 task apb_monitor::collect_data();

   apb_xtn xtn;
   xtn = apb_xtn::type_id::create("xtn");
   
   // wait for both PENABLE and PREADY to become high
   // collect all the address and control information
 
  wait(vif.apb_mon_cb.penable && vif.apb_mon_cb.pready)

   xtn.PRESETn = vif.apb_mon_cb.reset;
   xtn.PADDR = vif.apb_mon_cb.paddr;
   xtn.PREADY = vif.apb_mon_cb.pready;
   xtn.PWRITE = vif.apb_mon_cb.pwrite;
   xtn.PSEL = vif.apb_mon_cb.psel;
   xtn.IRQ = vif.apb_mon_cb.irq;
   xtn.PENABLE = vif.apb_mon_cb.penable;
 
  // Check for the PWRITE, if it is high collect PWDATA
   // else collect PRDATA
 
   if(vif.apb_mon_cb.pwrite)
     begin
	xtn.PWDATA = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h1 && xtn.PWRITE==1) 
	   xtn.out_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h2 && xtn.PWRITE==1)
	   xtn.oe_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h3 && xtn.PWRITE==1)
  	   xtn.inte_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h4 && xtn.PWRITE==1)
   	   xtn.ptrig_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h5 && xtn.PWRITE==1)
	   xtn.aux_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h6 && xtn.PWRITE==1)
	   xtn.ctrl_reg = vif.apb_mon_cb.pwdata[1:0];

	if(xtn.PADDR=='h7 && xtn.PWRITE==1)
	   xtn.ints_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h8 && xtn.PWRITE==1)
	   xtn.eclk_reg = vif.apb_mon_cb.pwdata;

	if(xtn.PADDR=='h9 && xtn.PWRITE==1)
	   xtn.nec_reg = vif.apb_mon_cb.pwdata;


     end
   else
	if(xtn.PADDR=='h0 && xtn.PWRITE==0)
	xtn.in_reg = vif.apb_mon_cb.prdata;
     xtn.PRDATA = vif.apb_mon_cb.prdata;

     xtn.PREADY = vif.apb_mon_cb.pready;

   `uvm_info(get_type_name(), $sformatf("The Data Collected from APB Monitor is \n %s", xtn.sprint()), UVM_LOW)
   monitor_port.write(xtn);

   apb_mon_rcvd_xtn_cnt++;
   @(vif.apb_mon_cb);

 endtask

 function void apb_monitor :: report_phase(uvm_phase phase);
 
  `uvm_info(get_type_name(), $sformatf("APB Monitor: The no of transactions collected in the APB Monitor is : %0d",apb_mon_rcvd_xtn_cnt), UVM_LOW)

 endfunction

