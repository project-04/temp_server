class wb_monitor extends uvm_monitor;

	`uvm_component_utils(wb_monitor)
	virtual spi_if.WB_MON vif;
	uvm_analysis_port #(wb_xtn) monitor_port;
	wb_xtn wbxtnh;
wb_agent_config wb_cfg;
extern function new(string name ="wb_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();

endclass

function wb_monitor::new(string name ="wb_monitor", uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);
endfunction

function void wb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

	wbxtnh=wb_xtn::type_id::create("wbxtnh");
`uvm_info("wb_monitor","This is in WB_MONITOR",UVM_LOW)
uvm_config_db#(wb_agent_config)::get(this,"","wb_agent_config",wb_cfg);

endfunction

function void wb_monitor::connect_phase(uvm_phase phase);
	// Connect Vif with Static IF
vif=wb_cfg.vif_0;
 super.connect_phase(phase);		
endfunction

task wb_monitor::run_phase(uvm_phase phase);
	
		forever
			collect_data();
endtask

task wb_monitor::collect_data();
	@(vif.wb_mon_cb);
	while(vif.wb_mon_cb.wb_ack_o!==1)
	@(vif.wb_mon_cb);
	
	wbxtnh.wb_we_i = vif.wb_mon_cb.wb_we_i;
	wbxtnh.wb_adr_i = vif.wb_mon_cb.wb_adr_i;
	begin
		if(vif.wb_mon_cb.wb_adr_i=='h0 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.TX0=vif.wb_mon_cb.wb_dat_i;

		else if(vif.wb_mon_cb.wb_adr_i=='h04 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.TX1=vif.wb_mon_cb.wb_dat_i;	

	      else if(vif.wb_mon_cb.wb_adr_i=='h08 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.TX2=vif.wb_mon_cb.wb_dat_i;	

		else if(vif.wb_mon_cb.wb_adr_i=='h0c && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.TX3=vif.wb_mon_cb.wb_dat_i;

		else if(vif.wb_mon_cb.wb_adr_i=='h14 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.DIVIDER=vif.wb_mon_cb.wb_dat_i;

		else if(vif.wb_mon_cb.wb_adr_i=='h18 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.SS=vif.wb_mon_cb.wb_dat_i;

		else if(vif.wb_mon_cb.wb_adr_i=='h10 && vif.wb_mon_cb.wb_we_i==1'b1)
			wbxtnh.CTRL=vif.wb_mon_cb.wb_dat_i;
//end
/////////////////Writing in to the RX0/////////////

		 else if (vif.wb_mon_cb.wb_adr_i=='h0 && vif.wb_mon_cb.wb_we_i==1'b0)
		wbxtnh.RX0=vif.wb_mon_cb.wb_dat_o;

/////////////////Writing in to the RX1/////////////

		else if(vif.wb_mon_cb.wb_adr_i=='h04 && vif.wb_mon_cb.wb_we_i==1'b0)
			wbxtnh.RX1=vif.wb_mon_cb.wb_dat_o;

/////////////////Writing in to the RX2/////////////

		else if(vif.wb_mon_cb.wb_adr_i=='h08 && vif.wb_mon_cb.wb_we_i==1'b0)
			wbxtnh.RX2=vif.wb_mon_cb.wb_dat_o;

/////////////////Writing in to the RX3/////////////

		else if(vif.wb_mon_cb.wb_adr_i=='h0C && vif.wb_mon_cb.wb_we_i==1'b0)
			wbxtnh.RX3=vif.wb_mon_cb.wb_dat_o;
//`uvm_info("wb_monitor",$sformatf("Printing it from the WB_MONITOR %s",wbxtnh.sprint()),UVM_LOW)


	end

		///////////////Sending the data to the Scoreboard///////////////////////////
`uvm_info("wb_monitor",$sformatf("Printing it from the WB_MONITOR %s",wbxtnh.sprint()),UVM_LOW)

	monitor_port.write(wbxtnh);							
endtask
