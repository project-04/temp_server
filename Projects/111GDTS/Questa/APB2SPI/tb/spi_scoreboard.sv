class spi_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(spi_scoreboard)

   //Properties
   uvm_tlm_analysis_fifo #(apb_xtn) fifo_apb[];
   uvm_tlm_analysis_fifo #(spi_xtn) fifo_spi[];

   spi_env_config m_cfg;

   uvm_status_e status;
   bit[7:0] data;

   spi_reg_block spi_rg_blk;
   //Handles of transcaction class for the APB Host and SPI Slave coverage;
   apb_xtn apb_cov_data;
   spi_xtn spi_cov_data;

   apb_xtn a_xtn;
   spi_xtn s_xtn;

   int data_verified_cnt;

   bit reset_case;
   bit [1:0] low_pwr_case;
   bit [7:0] cntr_rg1, cntr_rg2, baud_rg, status_rg, data_rg;

   //cover Groups for APB Host;
   covergroup apb_cover_group;
     option.per_instance = 1;

     Reset	:  coverpoint apb_cov_data.PRESETn{bins rst={0,1};}
     Addr	:  coverpoint apb_cov_data.PADDR{bins addr[]={0,1,2,3,5};}//PADDR to write/read registers
     Selx	:  coverpoint apb_cov_data.PSEL{bins sel={0,1};}// APB master Slave Select
     Enable	:  coverpoint apb_cov_data.PENABLE{bins enb ={0,1};}// APB Enable
     Write	:  coverpoint apb_cov_data.PWRITE{bins wrt[]={0,1};}// Indicates write or read
     Ready	:  coverpoint apb_cov_data.PREADY{bins rdy={0,1};} //PREADY signal
     Error	:  coverpoint apb_cov_data.PSLVERR{bins err={0,1};}// PERROR Signal
     Wdata	:  coverpoint apb_cov_data.PWDATA{bins wdata_low={[8'h00:8'h0f]};
						  bins wdata_high={[8'h1f:8'hff]};} // Write data
     Rdata	:  coverpoint apb_cov_data.PRDATA{bins rdata_low={[8'h00:8'h0f]};
						  bins rdata_high={[8'h1f:8'hff]};}// Read Data

     //Crosses
     Selx_Enable: cross Selx, Enable;
     Selx_Enable_Ready: cross Selx, Enable, Ready;
   endgroup

   covergroup spi_cover_group;
     option.per_instance = 1;
		
     slave_select	: coverpoint spi_cov_data.ss{bins ss={0,1};} // SPI Slave Select
     miso_data	: coverpoint spi_cov_data.miso{bins miso_low={[8'h00:8'h0f]};
					       bins miso_high={[8'h1f:8'hff]};}	// Master In Slave Out data
     mosi_data	: coverpoint spi_cov_data.mosi{bins mosi_low={[8'h00:8'h0f]};
					       bins mosi_high={[8'h1f:8'hff]};}	// Master Out Slave In data
     spi_int_req	: coverpoint spi_cov_data.spi_inpt_req{bins inpt[]={0,1};} 
   endgroup
	
   //Methods
   extern function new(string name="spi_scoreboard", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task compare_data(apb_xtn a_xtn);
   extern task compare_data1(apb_xtn a_xtn);
   extern function void report_phase(uvm_phase phase);
 endclass

 function spi_scoreboard :: new(string name="spi_scoreboard", uvm_component parent);
   super.new(name, parent);

   apb_cov_data = new();
   spi_cov_data = new();

   apb_cover_group = new();
   spi_cover_group = new();
 endfunction	

 function void spi_scoreboard :: build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db. Have you set it?")

   fifo_apb = new[m_cfg.no_of_apb_agent];
   fifo_spi = new[m_cfg.no_of_spi_agent];

   foreach(fifo_apb[i])
     fifo_apb[i]=new($sformatf("fifo_apb[%0d]", i), this);

   foreach(fifo_spi[i])
     fifo_spi[i]=new($sformatf("fifo_spi[%0d]", i), this);	
 endfunction

 function void spi_scoreboard :: connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   spi_rg_blk = m_cfg.spi_rg_blk;
 endfunction

 task spi_scoreboard :: run_phase(uvm_phase phase);	
   fork
     begin
       forever  // Logic to get the apb transactions from the APB Monitor
         begin
	   fifo_apb[0].get(a_xtn);
	   apb_cov_data = a_xtn;
	   apb_cover_group.sample();
	   compare_data1(a_xtn);
	 end
     end
     begin
       forever	// Logic to get the spi transactions from the SPI Monitor
         begin
	   fifo_spi[0].get(s_xtn);
	   spi_cov_data = s_xtn;
	   spi_cover_group.sample();
	   `uvm_info(get_type_name(), $sformatf("Scoreboad : \n  Spi_xtn=\n%s",  s_xtn.sprint()), UVM_LOW)
	   compare_data(a_xtn);
	 end
     end
   join
 endtask

 task spi_scoreboard :: compare_data(apb_xtn a_xtn);
   /* Logic to compare the MOSI data and PWDATA (Data written into SPI Data Register */
   wait(s_xtn!=null);
   wait(a_xtn!=null);

   if(a_xtn.PWRITE && (a_xtn.PADDR == 3'b101))
     begin
       $display("********************************  Score Board Report *********************************");

       if(a_xtn.PWDATA == s_xtn.mosi)
	 `uvm_info(get_type_name(), "MOSI Data Comparision is successfull", UVM_LOW)
       else
	 `uvm_error(get_type_name(), "MOSI Data Comparision is failed")

       `uvm_info(get_type_name(), $sformatf("Scoreboad : \n Apb_xtn = \n%s,\n Spi_xtn=\n%s", a_xtn.sprint(), s_xtn.sprint()), UVM_LOW)
       $display("**************************************************************************************");
     end
   endtask

 task spi_scoreboard :: compare_data1(apb_xtn a_xtn);
   /* Comparision logic to verify 
       1. MISO data and PRDATA
       2. Registers in Reset Condition
       3. Low Power Mode */
       
   uvm_config_db #(bit)::get(this, "", "bit", reset_case);

   uvm_config_db #(bit[1:0])::get(this, "", "bit[1:0]", low_pwr_case);

   /* When reset was applied we will read the all register with backdoor method 
      and compared with their default values */
   if(reset_case)
     begin
       this.spi_rg_blk.cntr_reg1.read(status, cntr_rg1, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
       this.spi_rg_blk.cntr_reg2.read(status, cntr_rg2, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
       this.spi_rg_blk.baud_reg.read(status, baud_rg, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
       this.spi_rg_blk.status_reg.read(status, status_rg, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
       this.spi_rg_blk.data_reg.read(status, data_rg, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
			
       $display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Score Board Report @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
       if((cntr_rg1==8'b0000_0100) && (cntr_rg2==8'b0000_0000) && (baud_rg==8'b0000_0000) && (status_rg == 8'b0010_0000) && (data_rg == 8'b0000_0000) )
	 `uvm_info(get_type_name(), "Reset Comparision is successfull", UVM_LOW)
       else
	 `uvm_error(get_type_name(), "Reset Comparision is Failed")

         `uvm_info(get_type_name(), $sformatf("The Reset Values of Registers are-- Control Reg1 = %0b, Control Reg2 = %0b, Baud Register =%0b, Status Reg =%0b, Data Reg = %0b", cntr_rg1, cntr_rg2, baud_rg, status_rg, data_rg), UVM_LOW)

       data_verified_cnt++;
       $display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
     end
   
   /* Comparision logic for low power mode transactions */
   if(low_pwr_case==2'b01)
     begin
       if((!a_xtn.PWRITE) && (a_xtn.PADDR==3'b101))
         begin
	   this.spi_rg_blk.data_reg.read(status, data_rg, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
	   $display("###############################  Score Board Report #################################");

	   if(a_xtn.PRDATA == data_rg)
	     `uvm_info(get_type_name(), "Low Power Mode Data Comparision is successfull", UVM_LOW)
	   else
	     `uvm_error(get_type_name(), "Low Power Mode Data Comparision is failed")
	   $display("######################################################################################");
	 end
     end
   /* Comparison logic to compare the MISO and PRDATA */
   else
     begin
       wait(s_xtn!=null);
       if((!a_xtn.PWRITE) && (a_xtn.PADDR == 3'b101))
	 begin
	   $display("###############################  Score Board Report #################################");
           if(a_xtn.PRDATA == s_xtn.miso)
	     `uvm_info(get_type_name(), "MISO Data Comparision is successfull", UVM_LOW)
	   else
	     `uvm_error(get_type_name(), "MISO Data Comparision is failed")

	   if(s_xtn.spi_inpt_req)
	     begin
	       this.spi_rg_blk.status_reg.read(status, status_rg, .path(UVM_BACKDOOR), .map(spi_rg_blk.spi_reg_map));
	       `uvm_info(get_type_name(), $sformatf("The Value of Status Register is %0h, The reason for Interrupt Request is SPIF =%0b, SPTEF =%0b and MODF =%0b", status_rg, status_rg[7], status_rg[5], status_rg[4]), UVM_LOW)
	     end
           `uvm_info(get_type_name(), $sformatf("Scoreboad : \n Apb_xtn = \n%s,\n Spi_xtn=\n%s", a_xtn.sprint(), s_xtn.sprint()), UVM_LOW)
	   $display("######################################################################################");
	 end
     end
   data_verified_cnt++;
   endtask


 function void spi_scoreboard :: report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("SPI SCOREBOARD: The no of compared transactions in Scoreboard are %0d", data_verified_cnt), UVM_LOW)
 endfunction
