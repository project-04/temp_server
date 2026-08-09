 class axi_monitor extends uvm_monitor;
   `uvm_component_utils(axi_monitor)

   uvm_analysis_port #(axi_trans) axi_monitor_port;
   uvm_analysis_port #(axi_trans) axi_write_data_monitor_port;
   uvm_analysis_port #(axi_trans) axi_read_data_monitor_port;

   axi_trans axi_xtn,axi_xtn1,axi_xtn2,axi_xtn3,axi_xtn4,axi_write_data,axi_read_data;
   axi_trans q1[$],q2[$];
   //write channels semaphore
   semaphore sem1=new(); //created semaphore with zero key
   semaphore sem2=new();
   semaphore sem3=new(1);	//created semaphore with one key
   semaphore sem4=new(1);
   semaphore sem5=new(1);
   //read channels seamphore
   semaphore sem6=new();
   semaphore sem7=new(1);
   semaphore sem8=new(1);

   axi_agent_config axi_cfg;
	
   virtual axi_if.AXI_MON_MP vif;

   extern function new(string name="axi_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect();

   extern task write_address_channel();
   extern task write_data_channel(axi_trans axi_xtn);
   extern task write_response_channel(axi_trans axi_xtn1);

   extern task read_address_channel();
   extern task read_data_channel(axi_trans axi_xtn3);
 endclass
 //----------------------- new ------------------
 function axi_monitor:: new(string name="axi_monitor",uvm_component parent);	
   super.new(name,parent);
   axi_monitor_port=new("axi_monitor_port",this);
   axi_write_data_monitor_port=new("axi_write_data_monitor_port",this);
   axi_read_data_monitor_port=new("axi_read_data_monitor_port",this);
 endfunction
 //---------------------- build phase --------------
 function void axi_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(axi_agent_config)::get(this,"","axi_agent_config",axi_cfg))
     `uvm_fatal(get_type_name(),"configuration is not get properly in axi monitor")
 endfunction
 //-------------------------- connect phase ------------------
 function void axi_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif=axi_cfg.vif;
 endfunction
 //--------------------------- run phase ------------------------
 task axi_monitor::run_phase(uvm_phase phase);
   begin
     forever 
       collect();
   end
 endtask
 //------------------------ collect task --------------------------
 task axi_monitor::collect();
   axi_xtn=axi_trans::type_id::create("axi_xtn",this);
   fork 
     begin
       sem3.get(1);
       write_address_channel();
       `uvm_info(get_type_name(),"after write address channel",UVM_LOW)
       sem1.put(1);	
       sem3.put(1);
     end
     begin
       sem4.get(1);
       sem1.get(1);
       write_data_channel(q1.pop_front());
       `uvm_info(get_type_name(),"after write data channel",UVM_LOW)
       sem2.put(1);
       sem4.put(1);
     end
     begin
       sem5.get(1);
       sem2.get(1);
       write_response_channel(q1.pop_front());
       `uvm_info(get_type_name(),"after write response channel",UVM_LOW)
       sem5.put(1);			
     end
     begin
       sem7.get(1);
       read_address_channel();
       `uvm_info(get_type_name(),"after read address channel",UVM_LOW)
       sem6.put(1);	
       sem7.put(1);
     end
     begin
       sem8.get(1);
       sem6.get(1);
       read_data_channel(q2.pop_front());
       `uvm_info(get_type_name(),"after read data  channel",UVM_LOW)
       sem8.put(1);
     end
   join_any			
 endtask	
 //------------------- write address channel ----------------------
 task axi_monitor::write_address_channel();
  // axi_xtn = axi_trans::type_id::create("axi_xtn");
 
   wait((vif.axi_mon_cb.awvalid)&&(vif.axi_mon_cb.awready))	

   axi_xtn.AWID  = vif.axi_mon_cb.awid;
   axi_xtn.AWVALID  = vif.axi_mon_cb.awvalid;
   axi_xtn.AWREADY  = vif.axi_mon_cb.awready;
   axi_xtn.AWADDR = vif.axi_mon_cb.awaddr;
   axi_xtn.AWLEN = vif.axi_mon_cb.awlen;
   axi_xtn.AWSIZE  = vif.axi_mon_cb.awsize;  
   axi_xtn.AWBURST = vif.axi_mon_cb.awburst; 
   q1.push_back(axi_xtn);
   @(vif.axi_mon_cb);
 endtask
 //---------------- write data channel ----------------------
 task axi_monitor::write_data_channel(axi_trans axi_xtn);
   axi_xtn1 = axi_trans::type_id::create("axi_xtn1");	
   axi_xtn1 = axi_xtn;
   axi_xtn1.WDATA=new[axi_xtn1.AWLEN+1];
   axi_xtn1.WSTRB=new[axi_xtn1.AWLEN+1];
   foreach(axi_xtn1.WDATA[i])
     begin	
       wait((vif.axi_mon_cb.wvalid==1'b1)&&(vif.axi_mon_cb.wready==1'b1))				

       axi_write_data=axi_trans::type_id::create("axi_write_data");	
 
       axi_xtn.WREADY  = vif.axi_mon_cb.wready;
       axi_xtn.WVALID  = vif.axi_mon_cb.wvalid;
       axi_xtn1.WID = vif.axi_mon_cb.wid;
       axi_xtn1.WDATA[i] = vif.axi_mon_cb.wdata;                	
       axi_write_data.temp_wdata[7:0]=vif.axi_mon_cb.wstrb[0]?vif.axi_mon_cb.wdata[7:0]:8'b00000000;
       axi_write_data.temp_wdata[15:8]=vif.axi_mon_cb.wstrb[1]?vif.axi_mon_cb.wdata[15:8]:8'b00000000;
       axi_write_data.temp_wdata[23:16]=vif.axi_mon_cb.wstrb[2]?vif.axi_mon_cb.wdata[23:16]:8'b00000000;
       axi_write_data.temp_wdata[31:24]=vif.axi_mon_cb.wstrb[3]?vif.axi_mon_cb.wdata[31:24]:8'b00000000;
       axi_write_data.temp_wdata[39:32]=vif.axi_mon_cb.wstrb[4]?vif.axi_mon_cb.wdata[39:32]:8'b00000000;
       axi_write_data.temp_wdata[47:40]=vif.axi_mon_cb.wstrb[5]?vif.axi_mon_cb.wdata[47:40]:8'b00000000;
       axi_write_data.temp_wdata[55:48]=vif.axi_mon_cb.wstrb[6]?vif.axi_mon_cb.wdata[55:48]:8'b00000000;
       axi_write_data.temp_wdata[63:56]=vif.axi_mon_cb.wstrb[7]?vif.axi_mon_cb.wdata[63:56]:8'b00000000;

       $display(" temp_data = %d \n strb = %b",axi_write_data.temp_wdata,vif.axi_mon_cb.wstrb);

       axi_xtn1.WSTRB[i] = vif.axi_mon_cb.wstrb;
$display("strb= %b",axi_xtn1.WSTRB[i]);
       if(i==(axi_xtn1.WDATA.size-1))
	 axi_xtn1.WLAST = vif.axi_mon_cb.wlast;
       @(vif.axi_mon_cb);			
       axi_write_data_monitor_port.write(axi_write_data);
     end
   `uvm_info(get_type_name(),$sformatf("axi_trans :\n %p",axi_xtn1.sprint()),UVM_LOW)
   q1.push_back(axi_xtn1);			
 endtask
 //----------------------- write response channel ----------------------
 task axi_monitor::write_response_channel(axi_trans axi_xtn1);
   axi_xtn2 = axi_trans::type_id::create("axi_xtn2");
   axi_xtn2 = axi_xtn1;
   wait((vif.axi_mon_cb.bvalid)&&(vif.axi_mon_cb.bready)) 

   axi_xtn.bvalid  = vif.axi_mon_cb.bvalid;
   axi_xtn.bready  = vif.axi_mon_cb.bready;
   axi_xtn2.bid = vif.axi_mon_cb.bid;
   axi_xtn2.bresp = vif.axi_mon_cb.bresp;
   axi_xtn2.bvalid = vif.axi_mon_cb.bvalid;
   axi_monitor_port.write(axi_xtn2);
   `uvm_info(get_type_name(),$sformatf("axi_trans:\n %p",axi_xtn1.sprint()),UVM_LOW)
   @(vif.axi_mon_cb);
 endtask
 //------------------------- read address channel ---------------------
 task axi_monitor::read_address_channel();
   axi_xtn3 = axi_trans::type_id::create("axi_xtn3");
   @(vif.axi_mon_cb);
   wait((vif.axi_mon_cb.arvalid)&&(vif.axi_mon_cb.arready))

   axi_xtn3.arid  = vif.axi_mon_cb.arid;
   axi_xtn3.arready  = vif.axi_mon_cb.arready;
   axi_xtn3.arvalid  = vif.axi_mon_cb.arvalid;
   axi_xtn3.araddr = vif.axi_mon_cb.araddr;
   axi_xtn3.arlen = vif.axi_mon_cb.arlen;
   axi_xtn3.arsize  = vif.axi_mon_cb.arsize;  
   axi_xtn3.arburst = vif.axi_mon_cb.arburst;
   @(vif.axi_mon_cb);
   q2.push_back(axi_xtn3);
 endtask
 //------------------------ read data channel -----------------------
 task axi_monitor::read_data_channel(axi_trans axi_xtn3);
bit a;
   axi_xtn4 = axi_trans::type_id::create("axi_xtn4");
   axi_xtn4=axi_xtn3;		
   axi_xtn4.rdata=new[axi_xtn4.arlen+1];		
   foreach(axi_xtn4.rdata[i])
     begin
       wait((vif.axi_mon_cb.rvalid)&&(vif.axi_mon_cb.rready))
       axi_read_data=axi_trans::type_id::create("axi_read_data");
       axi_xtn4.rid = vif.axi_mon_cb.rid;
       axi_xtn4.rvalid = vif.axi_mon_cb.rvalid;
       axi_xtn4.rready = vif.axi_mon_cb.rready;
       axi_xtn4.rdata[i] = vif.axi_mon_cb.rdata;
       axi_xtn4.rresp[i] = vif.axi_mon_cb.rresp;                
       axi_read_data.temp_rdata=vif.axi_mon_cb.rdata;						
       if(i==(axi_xtn4.rdata.size-1))
	begin
	 axi_xtn4.rlast = vif.axi_mon_cb.rlast;
	 a= vif.axi_mon_cb.rlast;
	end
	$display("lastttttttttttttttttttttt = %b",vif.axi_mon_cb.rlast);
       @(vif.axi_mon_cb);					
       axi_read_data_monitor_port.write(axi_read_data);
     end
   axi_monitor_port.write(axi_xtn4);
   `uvm_info(get_type_name(),$sformatf("axi_trans :\n %p",axi_xtn4.sprint()),UVM_LOW)	
 endtask
