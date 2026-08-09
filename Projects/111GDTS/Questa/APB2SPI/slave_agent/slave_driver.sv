class spi_driver extends uvm_driver #(spi_xtn);
   `uvm_component_utils(spi_driver)
	
   virtual spi_intf.SPI_DRV_MP spi_if;
   spi_agent_config spi_cfg;

   bit [7:0] ctrl;
   bit cphase;
   bit cpol;
   bit lsb;

   extern function new(string name ="spi_driver", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task drive_to_dut(spi_xtn xtn);
   extern function void report_phase(uvm_phase phase);
 endclass

 function spi_driver :: new(string name="spi_driver", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_driver :: build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db #(spi_agent_config)::get(this, "", "spi_agent_config", spi_cfg))
     `uvm_fatal(get_type_name(), "Cannot get spi_cfg from uvm_config_db. Have you set it?")
 endfunction 

 function void spi_driver :: connect_phase(uvm_phase phase);
   spi_if=spi_cfg.spi_if;
 endfunction

 task spi_driver :: run_phase(uvm_phase phase);
   forever 
     begin
       seq_item_port.get_next_item(req);
       drive_to_dut(req);
       seq_item_port.item_done();
     end
 endtask

 task spi_driver :: drive_to_dut(spi_xtn xtn);

   if(!uvm_config_db #(bit[7:0])::get(this, "", "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")

   `uvm_info(get_type_name(), $sformatf("SPI Slave Driver: The ctrl value is %0b", ctrl), UVM_LOW)

   cphase = ctrl[2];
   cpol = ctrl[3];
   lsb = ctrl[0];

   wait(!spi_if.spi_drv_cb.ss)
   begin

     if(lsb)
       begin
	 if((!cphase) && (!cpol))
	   begin
	     spi_if.spi_drv_cb.miso <= xtn.miso[0];
	     for(int i=1; i<=7; i++)
	       begin
		 @(negedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
         else if((!cphase) && (cpol))
	   begin
	     spi_if.spi_drv_cb.miso <= xtn.miso[0];
	     for(int i=1; i<=7; i++)
	       begin
	         @(posedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
	 else if((cphase) && (!cpol))
	   begin
	     for(int i=0; i<=7; i++)
	       begin
		 @(posedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
         else
	   begin
	     for(int i=0; i<=7; i++)
	       begin
	         @(negedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
       end
      else
       begin
	 if((!cphase) && (!cpol))
	   begin
	     spi_if.spi_drv_cb.miso <= xtn.miso[7];
	     for(int i=6; i>=0; i--)
	       begin
		 @(negedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
         else if((!cphase) && (cpol))
	   begin
	     spi_if.spi_drv_cb.miso <= xtn.miso[7];
	     for(int i=6; i>=0; i--)
	       begin
	         @(posedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
	 else if((cphase) && (!cpol))
	   begin
	     for(int i=7; i>=0; i--)
	       begin
		 @(posedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
	 else
	   begin
	     for(int i=7; i>=0; i--)
	       begin
		 @(negedge spi_if.spi_drv_cb.sclk)
		 spi_if.spi_drv_cb.miso <= xtn.miso[i];
	       end
	   end
       end

   end
  

 `uvm_info(get_type_name(), $sformatf("The Transaction sent dut from SPI slave : \n %s", xtn.sprint()), UVM_LOW)
   spi_cfg.spi_drv_sent_xtn_cnt++;

 endtask

 function void spi_driver :: report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("SPI DRIVER: The Transations sents from SPI Driver is :  %0d", spi_cfg.spi_drv_sent_xtn_cnt), UVM_LOW)
 endfunction
