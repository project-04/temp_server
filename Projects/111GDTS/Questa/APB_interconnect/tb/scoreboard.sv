class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	//Configuration Object Handle and Property
	env_config m_cfg;


	int data_verified_count;
      
	master_xtn mxtn;
	slave_xtn sxtn;

	//Analysis FIFO
	uvm_tlm_analysis_fifo#(master_xtn) mst_fifo[];
	uvm_tlm_analysis_fifo#(slave_xtn) slv_fifo[];

	covergroup ahb_fcov;
		//option.per_instance = 1;
		//SIZE: coverpoint mxtn.Hsize{bins add[]={0,2};}
	endgroup
	
		

	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);

	extern task run_phase(uvm_phase phase);
	extern function void  compare(int Hdata,Pdata,Haddr,Paddr);
//	extern function void report_phase(uvm_phase phase);*/
endclass: scoreboard

function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);

	ahb_fcov = new();

endfunction 

function void scoreboard::build_phase(uvm_phase phase);

	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")	
	
	super.build_phase(phase);
	
     	mst_fifo = new[m_cfg.no_of_master_agent];
	slv_fifo = new[m_cfg.no_of_slave_agent];
    
	foreach(mst_fifo[i])
        	mst_fifo[i]=new($sformatf("mst_fifo[%0d]",i),this);
        
	foreach(slv_fifo[i])
       		slv_fifo[i]=new($sformatf("slv_fifo[%0d]",i),this);


endfunction //build_phase

task scoreboard::run_phase(uvm_phase phase);
/*	fork
	begin
		forever 
		begin
			mst_fifo[0].get(mxtn);
        	end
   	end

	begin
		forever
		begin
		        slv_fifo[0].get(sxtn);
       			check1(mxtn,sxtn);
   		end
	end
	join*/
endtask

function void scoreboard::compare(int Hdata,Pdata,Haddr,Paddr);


endfunction


/*function void scoreboard::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:No. of data verified in SB is %0d",data_verified_count),UVM_LOW)

endfunction*/


