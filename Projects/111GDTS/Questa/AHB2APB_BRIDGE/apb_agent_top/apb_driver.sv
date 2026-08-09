class apb_driver extends uvm_driver#(apb_xtn);

 `uvm_component_utils(apb_driver) 
 
	apb_agent_config cfg_h1;             
	apb_xtn xtn;                    
	virtual bridge_if.SDR_MP vif1; 

	extern function new(string name ="apb_driver",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task send_to_dut();
endclass


function apb_driver::new(string name ="apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction


function void apb_driver::build_phase(uvm_phase phase);
//get configuration object from APB agent
	if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",cfg_h1))
	`uvm_fatal("APB_DRIVER","Cannot get vif from APB Agent")
	super.build_phase(phase);
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
  vif1 = cfg_h1.vif1;
endfunction

task apb_driver::run_phase(uvm_phase phase);
	forever
		send_to_dut();
endtask


task apb_driver::send_to_dut();

	wait(vif1.sdr_cb.Pselx != 0);
	if(!vif1.sdr_cb.Pwrite)	vif1.sdr_cb.Prdata <= $random;
	//$display("prdata=%p",vif1.sdr_cb.Prdata);
	//vif.mdr_cb.Hrdata = vif1.sdr_cb.Prdata;
	wait(vif1.sdr_cb.Penable);
	@(vif1.sdr_cb);
	$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----%p@@@@@@@@@@@",vif1);
	
//	apb_cfg.dr_data_count++;
endtask


/*function void apb_driver::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:Driver sent %0d transaction",apb_cfg.dr_data_count),UVM_LOW)

endfunction */


