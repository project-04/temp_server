class master_monitor extends uvm_monitor;

//FACTORY REGISTRATION
	`uvm_component_utils(master_monitor)

//VIRTUAL INTERFACE HANDEL
	virtual master_if.MON vif;

//CONFIG HANDEL
 	master_agent_config m_cfg;

//XTN CLASS HANDEL
	master_xtn req;

//ANALYSIS PORT
	uvm_analysis_port #(master_xtn) monitor_port; 

	bit [6:0] char_len;
	int unsigned cnt_reg,i;
//METHODS

	extern function new(string name = "master_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_dut();
endclass
//CONSTRUCTOR
	function master_monitor::new(string name = "master_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port=new("monitor_port",this);
	endfunction

//BUILD PHASE
	function void master_monitor::build_phase(uvm_phase phase);
		if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",m_cfg))
			`uvm_fatal("MASTER_MONITOR","UNABLE TO GET CONFIG")
		if(!uvm_config_db#(bit[31:0])::get(this,"","bit[31:0]",cnt_reg))
				`uvm_fatal("SLAVE_MONITOR","UNABLE TO GET CONFIG")
		char_len=cnt_reg[6:0];
		
		if(char_len==0)
			char_len='d128;


	endfunction

//CONNECT PHASE
	function void master_monitor::connect_phase(uvm_phase phase);
		vif=m_cfg.vif;
	endfunction

//RUN PHASE
	task master_monitor::run_phase(uvm_phase phase);
	
	req=master_xtn::type_id::create("req");

		forever
			collect_dut();
	endtask

//COLLECT FROM DUT
	task master_monitor::collect_dut();

		begin
	  		@(vif.cb_mon)
				wait(vif.cb_mon.ack_o)
				begin
		 				req.adr_i=vif.cb_mon.adr_i;
						req.we_i=vif.cb_mon.we_i;
						if(req.adr_i==5'h0 && req.we_i)
								for(i=0;i<char_len;i++) 
									begin
									req.tx0[i]=vif.cb_mon.dat_i[i];
									$display(i);
									end
						else if(req.adr_i==5'h4 && req.we_i)
								for(i=0;i<char_len-32;i++) 

									req.tx1[i]=vif.cb_mon.dat_i[i];

						else if(req.adr_i==5'h8 && req.we_i)
								for(i=0;i<char_len-64;i++) 
									req.tx2[i]=vif.cb_mon.dat_i[i];
			     			
						else if(req.adr_i==5'hc && req.we_i)
								for(i=0;i<char_len-96;i++) 
									req.tx3[i]=vif.cb_mon.dat_i[i];

						else if(req.adr_i==5'h10 && req.we_i)
									begin
									req.control_reg=vif.cb_mon.dat_i;
									monitor_port.write(req);
									end

						else if(req.adr_i==5'h14 && req.we_i)
									req.divider_reg=vif.cb_mon.dat_i;

						else if(req.adr_i==5'h18 && req.we_i)
									req.ss_reg=vif.cb_mon.dat_i;




						else if(req.adr_i==5'h0 && !req.we_i)
									begin
										for(i=0;i<char_len;i++) 
												req.rx0[i]=vif.cb_mon.dat_o[i];
									monitor_port.write(req);
									end
						else if(req.adr_i==5'h4 && !req.we_i)
									begin
										for(i=0;i<char_len-32;i++) 
												req.rx1[i]=vif.cb_mon.dat_o[i];
									monitor_port.write(req);
									end


						else if(req.adr_i==5'h8 && !req.we_i)
									begin
										for(i=0;i<char_len-64;i++) 
												req.rx2[i]=vif.cb_mon.dat_o[i];
									monitor_port.write(req);
									end

						else if(req.adr_i==5'hc && !req.we_i)
										begin
										for(i=0;i<char_len-96;i++) 

												req.rx3[i]=vif.cb_mon.dat_o[i];
									monitor_port.write(req);
									end
											
										    



				end

				`uvm_info(get_type_name,$sformatf("%s",req.sprint),UVM_LOW)


				
	 	end
	endtask 

