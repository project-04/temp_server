 class spi_monitor extends uvm_monitor;
   `uvm_component_utils(spi_monitor)

   spi_agent_config spi_cfg;
   uvm_analysis_port #(spi_xtn) monitor_port;
   virtual spi_intf.SPI_MON_MP spi_if;

   bit [7:0] ctrl;
   bit cphase;
   bit cpol;
   bit lsb;

   extern function new(string name="spi_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect_data();
   extern function void report_phase(uvm_phase phase);
 endclass

 function spi_monitor :: new(string name="spi_monitor", uvm_component parent);
   super.new(name, parent);
   monitor_port = new("monitor_port", this);
 endfunction

 function void spi_monitor :: build_phase(uvm_phase phase);
   super.build_phase(phase);
	
   if(!uvm_config_db #(spi_agent_config)::get(this, " ", "spi_agent_config", spi_cfg))
     `uvm_fatal(get_type_name(), "Cannot get spi_cfg from uvm_config_db. Have you set it?")
 endfunction

 function void spi_monitor:: connect_phase(uvm_phase phase);
   spi_if = spi_cfg.spi_if;
 endfunction

 task spi_monitor :: run_phase(uvm_phase phase);
   forever
     collect_data();
 endtask

 task spi_monitor :: collect_data();
   spi_xtn xtn;
   xtn = spi_xtn :: type_id :: create("xtn");
	
   if(!uvm_config_db #(bit[7:0])::get(this, "", "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")
	
   `uvm_info(get_type_name(), $sformatf("SPI Slave Monitor: The ctrl value is %0b", ctrl), UVM_LOW)

   cphase = ctrl[2];
   cpol = ctrl[3];
   lsb = ctrl[0];
   
   @(spi_if.spi_mon_cb)
   wait(!spi_if.spi_mon_cb.ss)
   begin

     if(lsb)
       begin
	 for(int i=0; i<=7; i++)
	   begin
	     if(((!cphase)&&(!cpol))||(cphase && cpol))
	       begin
	         @(posedge spi_if.spi_mon_cb.sclk)
		   begin
		     xtn.miso[i] = spi_if.spi_mon_cb.miso;
		     xtn.mosi[i] = spi_if.spi_mon_cb.mosi;
		     xtn.ss = spi_if.spi_mon_cb.ss;
		     xtn.spi_inpt_req = spi_if.spi_mon_cb.spi_inpt_req;
		   end
	       end
	     else 
	       begin
		 @(negedge spi_if.spi_mon_cb.sclk)
		   begin
		     xtn.miso[i] = spi_if.spi_mon_cb.miso;
		     xtn.mosi[i] = spi_if.spi_mon_cb.mosi;
		     xtn.ss = spi_if.spi_mon_cb.ss;
		     xtn.spi_inpt_req = spi_if.spi_mon_cb.spi_inpt_req;
		   end
	       end	
	   end
       end
     else 
       begin
	 for(int i=7; i>=0; i--)
	   begin
	     if(((!cphase)&&(!cpol))||(cphase && cpol)) 
	       begin
		 @(posedge spi_if.spi_mon_cb.sclk)
	           begin
		     xtn.miso[i] = spi_if.spi_mon_cb.miso;
		     xtn.mosi[i] = spi_if.spi_mon_cb.mosi;
		     xtn.ss = spi_if.spi_mon_cb.ss;
	             xtn.spi_inpt_req = spi_if.spi_mon_cb.spi_inpt_req;
		   end
	       end
	     else
	       begin
	         @(negedge spi_if.spi_mon_cb.sclk)
		   begin
		     xtn.miso[i] = spi_if.spi_mon_cb.miso;
		     xtn.mosi[i] = spi_if.spi_mon_cb.mosi;
		     xtn.ss = spi_if.spi_mon_cb.ss;
		     xtn.spi_inpt_req = spi_if.spi_mon_cb.spi_inpt_req;
          	   end
	       end	
           end
       end
   end

   `uvm_info(get_type_name(), $sformatf("The Transaction received from SPI slave : \n %s", xtn.sprint()), UVM_LOW)
   monitor_port.write(xtn);

   spi_cfg.spi_mon_rcvd_xtn_cnt++;
   @(spi_if.spi_mon_cb);


 endtask

 function void spi_monitor :: report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("SPI MONITOR: The no of transaction received in spi monitor : %0d", spi_cfg.spi_mon_rcvd_xtn_cnt), UVM_LOW)
 endfunction
