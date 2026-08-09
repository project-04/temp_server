/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   ram_rd_monitor.sv

Description 	:	Read Monitor class for Dual Port RAM TB
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_rd_monitor from uvm_monitor
class ram_rd_monitor extends uvm_monitor;

	// Factory Registration
	`uvm_component_utils(ram_rd_monitor)

	// Declare virtual interface handle with RMON_MP as modport
 	virtual ram_if.RMON_MP vif;

	// Declare the ram_rd_agent_config handle as "m_cfg"
	ram_wr_agent_config m_cfg;

	

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_rd_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	extern function void report_phase(uvm_phase phase);


endclass 

//-----------------  constructor new method  -------------------//
function ram_rd_monitor::new(string name ="ram_rd_monitor",uvm_component parent);
	super.new(name, parent);
endfunction



//-----------------  build() phase method  -------------------//
function void ram_rd_monitor::build_phase(uvm_phase phase);
	// call super.build_phase(phase);
	super.build_phase(phase);
	// get the config object using uvm_config_db 
	if(!uvm_config_db #(ram_wr_agent_config)::get(this, "", "ram_wr_agent_config", m_cfg))
		`uvm_fatal("RAM_RD_MONITOR","geting is not working for ram_wr_agent_config");
endfunction

//-----------------  connect() phase method  -------------------//
// in connect phase assign the configuration object's virtual interface
// to the monitor's virtual interface instance(handle --> "vif")
function void ram_rd_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif = m_cfg.vif;
endfunction


//-----------------  run() phase method  -------------------//
	

// In forever loop
// Call task collect_data provided
task ram_rd_monitor::run_phase(uvm_phase phase);
	forever
		collect_data();
endtask


//Collect Reference Data from DUV IF 
task ram_rd_monitor::collect_data();

    read_xtn data_sent;
	  // Create an instance data_sent
    data_sent= read_xtn::type_id::create("data_sent");

    @(posedge vif.rmon_cb.read);
    data_sent.read = vif.rmon_cb.read;
    data_sent.address = vif.rmon_cb.rd_address;
    data_sent.xtn_type = (data_sent.address == 'd1904) ? BAD_XTN : GOOD_XTN ;
    
    repeat(2)
    @(vif.rmon_cb);
    data_sent.data = vif.rmon_cb.data_out;
    
    // Debug Print - Set Verbosity level UVM_HIGH only to debug
    `uvm_info("RAM_RD_MONITOR",$sformatf("printing from monitor \n %s", data_sent.sprint()),UVM_HIGH) 

    // increment mon_rcvd_xtn_cnt
	  m_cfg.mon_rcvd_xtn_cnt++;
    
endtask 

// UVM report_phase
// In report phase display mon_rcvd_xtn_cnt value
function void ram_rd_monitor::report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("RAM_RD_MONITOR", $sformatf("mon_rcvd_xtn_cnt = %d", m_cfg.mon_rcvd_xtn_cnt), UVM_LOW);
endfunction
     
    


