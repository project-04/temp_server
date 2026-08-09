class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	//Configuration Object Handle and Property
	env_config m_cfg;

	trans q[$],q1[$];

	int addr_match_count;
	int addr_mismatch_count;
	int data_match_count;
	int data_mismatch_count;
      
	//AHB & APB Transaction Handle
	trans xtn,xtn1;

	//Analysis FIFO
	uvm_tlm_analysis_fifo#(trans) mst_fifo;
	uvm_tlm_analysis_fifo#(trans) slv_fifo[];

	//Covergroup for AHB Transaction
	covergroup ahb_fcov;
		option.per_instance = 1;
		SIZE: coverpoint xtn.hsize{bins siz[]={0,2};}
		ADDR: coverpoint xtn.haddr{//bins addr= {[0:$]};}
						bins first_slave={[32'h8000_0000:32'h8000_03ff]};
						bins second_slave={[32'h8400_0000:32'h8400_03ff]};
						bins third_slave={[32'h8800_0000:32'h8800_03ff]};
						bins fourth_slave={[32'h8c00_0000:32'h8c00_03ff]};}

		TRANS:coverpoint xtn.htrans{bins Htrans[]={[1:3]};}
		HWRITE: coverpoint xtn.hwrite{bins writ[]={[0:1]};}	
		HRSP: coverpoint xtn.hresp{bins rsp[]={[0:3]};}
		HBURST: coverpoint xtn.hburst{bins burst[]={[0:7]};}	
          ADDR_SIZE:cross SIZE,ADDR,HWRITE;
	endgroup
	
	//Covergroup for APB Transaction
	
	//------------------------------------------
	// Methods
	// -----------------------------------------
	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check1(trans xtn,trans xtn1);//xtn1);
	extern function void compare(bit[31:0] mem[int],bit[31:0] mem1[int],int master_haddr,int slave_haddr);
	extern function void report_phase(uvm_phase phase);
endclass: scoreboard

//Constructor new
function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);

	ahb_fcov = new();

endfunction 

function void scoreboard::build_phase(uvm_phase phase);
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")	
	
	super.build_phase(phase);
	
    
        	mst_fifo=new("mst_fifo",this);
          slv_fifo = new[m_cfg.no_sagt];
          foreach(slv_fifo[i])
        	slv_fifo[i]=new($sformatf("slv_fifo[%0d]",i),this);
        


endfunction //build_phase

task scoreboard::run_phase(uvm_phase phase);



forever
	fork
	begin
	//	forever 
		begin
			mst_fifo.get(xtn);
			q.push_back(xtn);
		//	`uvm_info("master_scoreboard",$sformatf("Printing from SB of master side data %s",xtn.sprint),UVM_NONE)
        	end
   	end

	begin
	//	forever
		begin
               fork
		        slv_fifo[0].get(xtn1);
		        slv_fifo[1].get(xtn1);
		        slv_fifo[2].get(xtn1);
               join_any
			q1.push_back(xtn1);
			if(xtn != null)// && xtn1!=null)
			check1(xtn,xtn1);//xtn,xtn1);
	//		`uvm_info("slave_scoreboard",$sformatf("Printing from SB of slave side data %s",xtn1.sprint),UVM_NONE)
   		end
	end
	join
endtask


function void scoreboard::check1(trans xtn,trans xtn1);
//trans xtn,xtn1;

//	xtn=a.pop_front();
//	xtn1=b.pop_front();

//$display("master write = %p \t read = %p",xtn.master_write_mem[xtn.haddr],xtn.master_read_mem);
//$display("slave write = %p \t read = %p",xtn1.slave_write_mem,xtn1.slave_read_mem);
	if(xtn.hwrite)
		compare(xtn.master_write_mem,xtn1.slave_write_mem,xtn.haddr,xtn1.haddr);
	else
		compare(xtn.master_read_mem,xtn1.slave_read_mem,xtn.haddr,xtn1.haddr);
endfunction
 
function void scoreboard::compare(bit[31:0] mem[int],bit[31:0] mem1[int],int master_haddr,int slave_haddr);

       $display($time,"slave haadr = %h \n master addr = %h",master_haddr,slave_haddr);
	if(master_haddr==slave_haddr)
	  begin
  	     `uvm_info("SB","Address compared successfully",UVM_NONE)
	      addr_match_count ++;
	  if(xtn.hwrite)
	   begin
		if(xtn.master_write_mem[master_haddr]==xtn1.slave_write_mem[slave_haddr])
	          begin
		   `uvm_info("SB","write data matched successfully",UVM_NONE)
		    data_match_count ++;
		  end
		else
	  	  begin
		`uvm_info("SB","write data mismatched",UVM_NONE)	
		    data_mismatch_count ++;	
	 	 end
	   end
	  else
	     begin
		if(xtn.master_read_mem[master_haddr]==xtn1.slave_read_mem[slave_haddr])
	          begin
		   `uvm_info("SB","read data matched successfully",UVM_NONE)
		    data_match_count ++;
		  end
		else
	  	  begin
		`uvm_info("SB","read data mismatched",UVM_NONE)	
		    data_mismatch_count ++;	
	 	 end

  	    end
	end
	else
	 begin
 	`uvm_info("SB","Address not compared successfully",UVM_NONE)
	   addr_mismatch_count ++;
	  end


  
	ahb_fcov.sample();

endfunction

function void scoreboard::report_phase(uvm_phase phase);
	
`uvm_info("Addr Pass REPORT",$sformatf(" Address match count is %0d",addr_match_count),UVM_NONE)
`uvm_info("Data Pass REPORT",$sformatf(" Data match count is %0d",data_match_count),UVM_NONE)

`uvm_info("Addr Fail Report",$sformatf(" Address mismatch count is %0d",addr_mismatch_count),UVM_NONE)
`uvm_info("Data Fail Reprot",$sformatf(" Data mismatch count is %0d",data_mismatch_count),UVM_NONE)

endfunction



