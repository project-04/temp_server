class spi_agent_config extends uvm_object;
   `uvm_object_utils(spi_agent_config)

   // Properties
   static int spi_mon_rcvd_xtn_cnt=0;
   static int spi_drv_sent_xtn_cnt=0;
	
   uvm_active_passive_enum is_active = UVM_ACTIVE;
   virtual spi_intf spi_if;

   //Methods
   extern function new(string name="spi_agent_config");
 endclass

 function spi_agent_config :: new(string name="spi_agent_config");
   super.new(name);
 endfunction
