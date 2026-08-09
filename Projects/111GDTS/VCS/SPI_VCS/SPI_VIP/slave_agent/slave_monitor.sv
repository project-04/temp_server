class slave_monitor extends uvm_monitor;

//FACTORY REGISTRATION
	`uvm_component_utils(slave_monitor)

//VIRTUAL INTERFACE HANDEL
	virtual slave_if.MON vif;

//CONFIG HANDEL
 	slave_agent_config m_cfg;

	slave_xtn req;


bit[31:0]cnt_reg;
	bit[6:0]char_len;


//ANALYSIS PORT
	uvm_analysis_port #(slave_xtn) monitor_port; 
//METHODS

	extern function new(string name = "slave_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_dut();



endclass
//CONSTRUCTOR
	function slave_monitor::new(string name = "slave_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port=new("monitor_port",this);
	endfunction
//BUILD PHASE
	function void slave_monitor::build_phase(uvm_phase phase);
		if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",m_cfg))
			`uvm_fatal("SLAVE_MONITOR","UNABLE TO GET CONFIG")

		if(!uvm_config_db#(bit[31:0])::get(this,"","bit[31:0]",cnt_reg))
				`uvm_fatal("SLAVE_MONITOR","UNABLE TO GET CONFIG")
			//if(cnt_reg[6:0]!=0)
			char_len=cnt_reg[6:0];
		/*	else 
			char_len =128;*/


	endfunction
//CONNECT PHASE
	function void slave_monitor::connect_phase(uvm_phase phase);
	vif=m_cfg.vif;
	
	endfunction

//RUN PHASE
	task slave_monitor::run_phase(uvm_phase phase);
	req=slave_xtn::type_id::create("req");

		forever
			collect_dut();
	endtask

//COLLECT FROM DUT
	task slave_monitor::collect_dut();

	int i;
	@(vif.cb_mon);
	@(vif.cb_mon);
//	wait(vif.cb_mon.ss_pad_o !==32'hffffffff);
		begin
	 		if(cnt_reg[9])
				begin
					if(cnt_reg[11])
					   begin
						for(i=0;i<char_len;i++)
							begin
							  @(negedge vif.cb_mon.sclk)
						           begin
				                           	req.mosi_pad_o[i]=vif.cb_mon.mosi_pad_o;							
						          	req.miso_pad_i[i]=vif.cb_mon.miso_pad_i;
							   end
					                 end							
					   end
					else
					   begin
						for(i=char_len-1;i>=0;i--)
							begin
							@(negedge vif.cb_mon.sclk)
						           begin
				                           	req.mosi_pad_o[i]=vif.cb_mon.mosi_pad_o;							
						          	req.miso_pad_i[i]=vif.cb_mon.miso_pad_i;
							//	$display("monitor %d miso%d mosi%d",i,req.miso_pad_i[i],req.mosi_pad_o[i]);	
							   end
							end
					   end
				end
			else
			       begin
					if(cnt_reg[11])
					   begin
						for(i=0;i<char_len;i++)
							begin
						   @(negedge vif.cb_mon.sclk)
						           begin
				                           	req.mosi_pad_o[i]=vif.cb_mon.mosi_pad_o;							
						          	req.miso_pad_i[i]=vif.cb_mon.miso_pad_i;
							   end
							end
					   end
					else
					   begin
						for(i=char_len-1;i>=0;i--)
							begin
						@(negedge vif.cb_mon.sclk)
						           begin
				                           	req.mosi_pad_o[i]=vif.cb_mon.mosi_pad_o;							
						          	req.miso_pad_i[i]=vif.cb_mon.miso_pad_i;
							   end
							end
					   end
				end
			`uvm_info(get_type_name,$sformatf("%s",req.sprint),UVM_LOW)
			monitor_port.write(req);

		  end
		
	endtask

