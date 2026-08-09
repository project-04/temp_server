class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	//Configuration Object Handle and Property
	env_config m_cfg;

	ahb_xtn q[$];

	int data_verified_count;
      
	//AHB & APB Transaction Handle
	ahb_xtn ahb_mon_h;
	apb_xtn apb_mon_h;

	//Analysis FIFO
	uvm_tlm_analysis_fifo#(ahb_xtn) fifo_ahb_h[];
	uvm_tlm_analysis_fifo#(apb_xtn) fifo_apb_h[];

	//Covergroup for AHB Transaction
	covergroup ahb_fcov;
		option.per_instance = 1;
		SIZE: coverpoint ahb_mon_h.Hsize{bins add[]={0,2};}
		ADDR: coverpoint ahb_mon_h.Haddr{bins first_slave={[32'h8000_0000:32'h8000_03ff]};
						bins second_slave={[32'h8400_0000:32'h8400_03ff]};
						bins third_slave={[32'h8800_0000:32'h8800_03ff]};
						bins fourth_slave={[32'h8c00_0000:32'h8c00_03ff]};}
		TRANS:coverpoint ahb_mon_h.Htrans{bins trans[]={[0:3]};}
	endgroup
	
	//Covergroup for APB Transaction
	covergroup apb_fcov;
		option.per_instance = 1;
		
		ADDR: coverpoint apb_mon_h.Paddr{bins first_slave={[32'h8000_0000:32'h8000_03ff]};
						bins second_slave={[32'h8400_0000:32'h8400_03ff]};
						bins third_slave={[32'h8800_0000:32'h8800_03ff]};
						bins fourth_slave={[32'h8c00_0000:32'h8c00_03ff]};
										}
		SEL: coverpoint apb_mon_h.Pselx{bins first_slave={4'b0001};
						bins second_slave={4'b0010};
						bins third_slave={4'b0100};
						bins fourth_slave={4'b1000};
										}
		
	endgroup 

	//------------------------------------------
	// Methods
	// -----------------------------------------
	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);

	extern task run_phase(uvm_phase phase);
	extern function void check1(ahb_xtn ahb_mon_h,apb_xtn apb_mon_h);
	extern function void  compare(int Hdata,Pdata,Haddr,Paddr);
//	extern function void report_phase(uvm_phase phase);*/
endclass: scoreboard

//Constructor new
function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);

	ahb_fcov = new();
	apb_fcov = new();

endfunction 

function void scoreboard::build_phase(uvm_phase phase);
	//Get Configuration Object from Database
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")	
	
	super.build_phase(phase);
	
     	fifo_ahb_h = new[m_cfg.no_of_ahb_agent];
	fifo_apb_h = new[m_cfg.no_of_apb_agent];
    
	foreach(fifo_ahb_h[i])
        	fifo_ahb_h[i]=new($sformatf("fifo_ahb_h[%0d]",i),this);
        
	foreach(fifo_apb_h[i])
       		fifo_apb_h[i]=new($sformatf("fifo_apb_h[%0d]",i),this);


endfunction //build_phase

task scoreboard::run_phase(uvm_phase phase);
	fork
	begin
		forever 
		begin
			fifo_ahb_h[0].get(ahb_mon_h);
			//`uvm_info("SB","DATA FROM MASTER SCOREBOARD",UVM_LOW)
			ahb_mon_h.print;
			q.push_back(ahb_mon_h);
			//$display("SIZE OF THE QUEUE =%d",q.size);
			//ahb_fcov.sample();
        	end
   	end

	begin
		forever
		begin
		        fifo_apb_h[0].get(apb_mon_h);
			//`uvm_info("SB","DATA FROM SLAVE SCOREBOARD",UVM_LOW)
			apb_mon_h.print;
       			check1(ahb_mon_h,apb_mon_h);
			//apb_fcov.sample();
   		end
	end
	join
endtask

function void scoreboard::check1(ahb_xtn ahb_mon_h,apb_xtn apb_mon_h);
//	ahb_mon_h = ahb_xtn::type_id::create("ahb_mon_h");
//$display("i am in scorbd %p",q);

//	ahb_mon_h=q.pop_front();
$display("i am in scorbd %p",ahb_mon_h);
	if(ahb_mon_h.Hwrite)
	begin 
		case(ahb_mon_h.Hsize)
		2'b00:
		begin 
			if(ahb_mon_h.Haddr[1:0]==2'b00)
			compare(ahb_mon_h.Hwdata[7:0],apb_mon_h.Pwdata[7:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
			if(ahb_mon_h.Haddr[1:0]==2'b01)
			compare(ahb_mon_h.Hwdata[15:8],apb_mon_h.Pwdata[7:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
			if(ahb_mon_h.Haddr[1:0]==2'b10)
			compare(ahb_mon_h.Hwdata[23:16],apb_mon_h.Pwdata[7:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
			if(ahb_mon_h.Haddr[1:0]==2'b11)
			compare(ahb_mon_h.Hwdata[31:24],apb_mon_h.Pwdata[7:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		end
		
		2'b01:
		begin
			if(ahb_mon_h.Haddr[1:0]==2'b00)
			compare(ahb_mon_h.Hwdata[15:0],apb_mon_h.Pwdata[15:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
			if(ahb_mon_h.Haddr[1:0]==2'b10)
		    	compare(ahb_mon_h.Hwdata[31:16],apb_mon_h.Pwdata[15:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		end

		2'b10: compare(ahb_mon_h.Hwdata[31:0],apb_mon_h.Pwdata[31:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);	 
		endcase
	end		 
	else
	begin 
   		case(ahb_mon_h.Hsize)
		2'b00:
		begin 
			if(ahb_mon_h.Haddr[1:0]==2'b00)
		    	compare(ahb_mon_h.Hrdata[7:0],apb_mon_h.Prdata[7:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		   	if(ahb_mon_h.Haddr[1:0]==2'b01)
		    	compare(ahb_mon_h.Hrdata[7:0],apb_mon_h.Prdata[15:8],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		   	if(ahb_mon_h.Haddr[1:0]==2'b10)
		    	compare(ahb_mon_h.Hrdata[7:0],apb_mon_h.Prdata[23:16],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		   	if(ahb_mon_h.Haddr[1:0]==2'b11)
		    	compare(ahb_mon_h.Hrdata[7:0],apb_mon_h.Prdata[31:24],ahb_mon_h.Haddr,apb_mon_h.Paddr);
	    	end
		
		2'b01:
		begin
			if(ahb_mon_h.Haddr[1:0]==2'b00)
		    	compare(ahb_mon_h.Hrdata[15:0],apb_mon_h.Prdata[15:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);
			 if(ahb_mon_h.Haddr[1:0]==2'b10)
		    	compare(ahb_mon_h.Hrdata[15:0],apb_mon_h.Prdata[31:16],ahb_mon_h.Haddr,apb_mon_h.Paddr);
		end

		2'b10: compare(ahb_mon_h.Hrdata[31:0],apb_mon_h.Prdata[31:0],ahb_mon_h.Haddr,apb_mon_h.Paddr);	  
    		endcase 
	end
endfunction
 
function void scoreboard::compare(int Hdata,Pdata,Haddr,Paddr);

	if(ahb_mon_h.Haddr==apb_mon_h.Paddr)
  	`uvm_info("SB","Address compared successfully",UVM_LOW)
  	
	else
 	`uvm_info("SB","Address not compared successfully",UVM_LOW)

	if(ahb_mon_h.Hwrite)
	begin
		if(Hdata==Pdata)
		`uvm_info("SB","write data matched successfully",UVM_LOW)
  		else
		`uvm_info("SB","write data mismatched",UVM_LOW)
	end

	else
	begin
		if(Hdata==Pdata)
		`uvm_info("SB","Read data matched successfully",UVM_LOW)
		else
		`uvm_info("SB","Read data mismatched",UVM_LOW)
	end

//data_verified_count++;
  
	ahb_fcov.sample();
	apb_fcov.sample(); 

endfunction


/*function void scoreboard::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:No. of data verified in SB is %0d",data_verified_count),UVM_LOW)

endfunction*/

