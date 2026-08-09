class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	//Configuration Object Handle and Property
	env_config m_cfg;

	ahb_xtn q[$];

	int data_verified_count;
      
	//AHB & APB Transaction Handle
	ahb_xtn ahb_mon_h;

	//Analysis FIFO
	uvm_tlm_analysis_fifo#(ahb_xtn) fifo_ahb_h[];

	//Covergroup for AHB Transaction
	

	//------------------------------------------
	// Methods
	// -----------------------------------------
	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);

	extern task run_phase(uvm_phase phase);
	extern function void check1();
	extern function void  compare(int Hdata,Pdata,Haddr,Paddr);
//	extern function void report_phase(uvm_phase phase);*/
endclass: scoreboard

//Constructor new
function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);


endfunction 

function void scoreboard::build_phase(uvm_phase phase);
	//Get Configuration Object from Database
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")	
	
	super.build_phase(phase);
	
     	fifo_ahb_h = new[m_cfg.no_of_ahb_agent];
    
	foreach(fifo_ahb_h[i])
        	fifo_ahb_h[i]=new($sformatf("fifo_ahb_h[%0d]",i),this);
        
	
endfunction //build_phase

task scoreboard::run_phase(uvm_phase phase);
endtask

function void scoreboard::check1();
	ahb_mon_h = ahb_xtn::type_id::create("ahb_mon_h");
endfunction
 
function void scoreboard::compare(int Hdata,Pdata,Haddr,Paddr);

endfunction


/*function void scoreboard::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:No. of data verified in SB is %0d",data_verified_count),UVM_LOW)

endfunction*/

