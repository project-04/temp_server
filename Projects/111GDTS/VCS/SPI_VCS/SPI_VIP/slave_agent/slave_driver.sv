class slave_driver extends uvm_driver #(slave_xtn);

//FACTORY REGISTRATION
	`uvm_component_utils(slave_driver)

//VIRTUAL INTERFACE HANDEL
	virtual slave_if.DRV vif;

//CONFIG HANDEL
 	slave_agent_config m_cfg;

	slave_xtn req;

//LOCAL DATAMEMBERS
	bit[31:0]cnt_reg;
	bit[6:0]char_len;

//METHODS

	extern function new(string name = "slave_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(slave_xtn req);
endclass
//CONSTRUCTOR
	function slave_driver::new(string name = "slave_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
//BUILD PHASE
	function void slave_driver::build_phase(uvm_phase phase);
		if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",m_cfg))
			`uvm_fatal("SLAVE_DRIVER","UNABLE TO GET CONFIG")
		if(!uvm_config_db#(bit[31:0])::get(this,"","bit[31:0]",cnt_reg))
				`uvm_fatal("SLAVE_DRIVER","UNABLE TO GET CONFIG")
	//	if(cnt_reg[6:0]!=0)	
			char_len=cnt_reg[6:0];
	/*	else
		 char_len=128;*/
	endfunction
//CONNECT PHASE
	function void slave_driver::connect_phase(uvm_phase phase);
	vif=m_cfg.vif;
	
	endfunction

//RUN_PHASE
	task slave_driver::run_phase(uvm_phase phase);
	
		forever
		   begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		   end
	endtask
//SEND TO DUT
	task slave_driver::send_to_dut(slave_xtn req);
	int i;
			//wait(vif.cb_drv.ss_pad_o !==32'hffffffff);
$display("INSIDE SLAVE DRIVERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
		begin
	 		if(cnt_reg[9])
				begin
					if(cnt_reg[11])
					   begin
						for(i=0;i<char_len;i++)
							begin
							  @(posedge vif.cb_drv.sclk)
						           vif.cb_drv.miso_pad_i<=req.miso_pad_i[i];
								$display("driver %d",i);

							end
					   end
					else
					   begin
						for(i=char_len-1;i>=0;i--)
							begin
							  @(posedge vif.cb_drv.sclk)
						           vif.cb_drv.miso_pad_i<=req.miso_pad_i[i];
							$display("driver %d",i);
							end
					   end
				@(negedge vif.cb_drv.sclk);
				end
			
			else
			       begin
					if(cnt_reg[11])
					   begin
						for(i=0;i<char_len;i++)
							begin
							  @(negedge vif.cb_drv.sclk)
						           vif.cb_drv.miso_pad_i<=req.miso_pad_i[i];
								$display("driver %d",i);

							end
					   end
					else
					   begin
						for(i=char_len-1;i>=0;i--)
							begin
							  @(negedge vif.cb_drv.sclk)
						           vif.cb_drv.miso_pad_i<=req.miso_pad_i[i];
								$display("driver %d",i);

							end
					   end
				
			//	@(posedge vif.cb_drv.sclk);
				end
			`uvm_info(get_type_name,$sformatf("%s",req.sprint),UVM_LOW)
		@(vif.cb_drv);	
		@(vif.cb_drv);	
		@(vif.cb_drv);	
		@(vif.cb_drv);	

		  end
	endtask

