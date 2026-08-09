class master_driver extends uvm_driver#(master_xtn);

//FACTORY REGISTRATION
	`uvm_component_utils(master_driver)

//VIRTUAL INTERFACE HANDEL
	virtual master_if.DRV vif;

//CONFIG HANDEL
 	master_agent_config m_cfg;


//METHODS

	extern function new(string name = "master_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(master_xtn req);
endclass
//CONSTRUCTOR
	function master_driver::new(string name = "master_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
//BUILD PHASE
	function void master_driver::build_phase(uvm_phase phase);
		if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",m_cfg))
			`uvm_fatal("MASTER_DRIVER","UNABLE TO GET CONFIG")
		
	endfunction

//CONNECT PHASE
	function void master_driver::connect_phase(uvm_phase phase);
	vif=m_cfg.vif;
	
	endfunction

//RUN_PHASE
	task master_driver::run_phase(uvm_phase phase);
			@(vif.cb_drv)
				vif.cb_drv.rst_i<=1'b1;
			@(vif.cb_drv)
				vif.cb_drv.rst_i<=1'b0;
				vif.cb_drv.stb_i<=1'b0;
				vif.cb_drv.cyc_i<=1'b0;	
		forever
		   begin
			
			seq_item_port.get_next_item(req);
			
			send_to_dut(req);
			seq_item_port.item_done();
			$display("AFTER ITEM DONE IN MASTER DRIVERRRRRRRRRRRRRRRRRR");
		   end
	endtask

//SEND TO DUT
	task master_driver::send_to_dut(master_xtn req);
		
		
	 		begin
	  			@(vif.cb_drv)
					/*if(vif.cb_drv.int_o)
						begin
							vif.cb_drv.stb_i<=1'b1;
							vif.cb_drv.cyc_i<=1'b1;
							wait(vif.cb_drv.ack_o);
							vif.cb_drv.stb_i<=1'b0;
							vif.cb_drv.cyc_i<=1'b0;
							@(vif.cb_drv)
						end*/
				
							vif.cb_drv.adr_i<=req.adr_i;
							vif.cb_drv.dat_i<=req.dat_i;
							vif.cb_drv.stb_i<=1'b1;
							vif.cb_drv.cyc_i<=1'b1;
							vif.cb_drv.sel_i<=4'b1111;
							vif.cb_drv.we_i<=req.we_i;
	   						wait(vif.cb_drv.ack_o);	
							vif.cb_drv.stb_i<=1'b0;
							vif.cb_drv.cyc_i<=1'b0; 
	

				`uvm_info(get_type_name,$sformatf("%s",req.sprint),UVM_LOW)
			$display("###########################################");
	 		end
	
	endtask
