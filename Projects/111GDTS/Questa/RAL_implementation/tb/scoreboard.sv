class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	env_config m_cfg;
     uvm_status_e status;
     bit[7:0] data1,data2;
     reg_block regh;

	int addr_match_count;
	int addr_mismatch_count;
	int data_match_count;
	int data_mismatch_count;
      
	trans xtn,xtn1;

	uvm_tlm_analysis_fifo#(trans) mst_fifo;
	uvm_tlm_analysis_fifo#(trans) slv_fifo;

	//Covergroup for AHB Transaction
/*	covergroup ahb_fcov;
		option.per_instance = 1;
		//SIZE: coverpoint xtn.hsize{bins siz[]={0,2};}
		
	endgroup
	*/
	
	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);
endclass: scoreboard

function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);

	//ahb_fcov = new();

endfunction 

function void scoreboard::build_phase(uvm_phase phase);
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")	
	
	super.build_phase(phase);
	
          regh = m_cfg.regh; 
        	mst_fifo=new("mst_fifo",this);
        	slv_fifo=new("slv_fifo",this);
        


endfunction //build_phase

task scoreboard::run_phase(uvm_phase phase);
	fork
	begin
		forever 
		begin
			mst_fifo.get(xtn);
			//q.push_back(xtn);
		//	`uvm_info("master_scoreboard",$sformatf("Printing from SB of master side data %s",xtn.sprint),UVM_LOW)
        	end
   	end

	begin
		forever
		begin
		        slv_fifo.get(xtn1);
			//q1.push_back(xtn);
		//	`uvm_info("slave_scoreboard",$sformatf("Printing from SB of slave side data %s",xtn1.sprint),UVM_LOW)
          this.regh.data.read(status, data1, .path(UVM_BACKDOOR), .map(regh.map1));
          this.regh.memh.read(status,xtn.addr,data2, .path(UVM_BACKDOOR), .map(regh.map1));
          
	$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ reg_data=%p  mem = %p",data1,data2);
   		end
	end
	join

endtask


function void scoreboard::report_phase(uvm_phase phase);
	$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ reg_data=%p  mem = %p",data1,data2);
`uvm_info("Addr Pass REPORT",$sformatf(" Address match count is %0d",addr_match_count),UVM_LOW)
`uvm_info("Data Pass REPORT",$sformatf(" Data match count is %0d",data_match_count),UVM_LOW)

`uvm_info("Addr Fail Report",$sformatf(" Address mismatch count is %0d",addr_mismatch_count),UVM_LOW)
`uvm_info("Data Fail Reprot",$sformatf(" Data mismatch count is %0d",data_mismatch_count),UVM_LOW)

endfunction



