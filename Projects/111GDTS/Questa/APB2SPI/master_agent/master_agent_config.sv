 class apb_agent_config extends uvm_object;
   `uvm_object_utils(apb_agent_config)

   static int apb_mon_rcvd_xtn_cnt=0;
   static int apb_drv_sent_xtn_cnt=0;
	
   uvm_active_passive_enum is_active = UVM_ACTIVE;
   virtual apb_intf apb_if;

   extern function new(string name="apb_agent_config");
 endclass

 function apb_agent_config :: new(string name="apb_agent_config");
	super.new(name);
 endfunction
