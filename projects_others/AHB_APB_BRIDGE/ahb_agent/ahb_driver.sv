

class ahb_driver extends uvm_driver#(ahb_trans);

	`uvm_component_utils(ahb_driver)

	function new (string name = "ahb_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

	ahb_config ahb_cfg;
	virtual ahb_if.ahb_drv_mp ahb_f;
	
	ahb_trans t1;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
			`uvm_fatal("AHB_DRIVER","failed to get config");

	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		this.ahb_f =ahb_cfg.ahb_f;

	endfunction 
	
	task run_phase(uvm_phase phase);
		reset_dut();
			forever
				begin 
					seq_item_port.get_next_item(req);
					send_to_dut(req);
					req.print();
					seq_item_port.item_done;
				end
	endtask	
	

	task reset_dut();
		@(ahb_f.ahb_drv_cb);
		ahb_f.ahb_drv_cb.Hresetn <= 0;
		@(ahb_f.ahb_drv_cb);
		ahb_f.ahb_drv_cb.Hresetn <= 1;
	endtask
	
	task send_to_dut(input ahb_trans t1);
		begin 



		//addy phase
		while(ahb_f.ahb_drv_cb.Hreadyout === 1'b0) // check for hreadyout if it is 0 thn stay here... else go to the next line 
			@(ahb_f.ahb_drv_cb);
			ahb_f.ahb_drv_cb.Haddr	<= t1.Haddr;
			ahb_f.ahb_drv_cb.Htrans <= t1.Htrans;
			ahb_f.ahb_drv_cb.Hsize <= t1.Hsize;
			ahb_f.ahb_drv_cb.Hwrite <= t1.Hwrite;
			ahb_f.ahb_drv_cb.Hreadyin <= 1;
		
		//data_phase
		while(ahb_f.ahb_drv_cb.Hreadyout == 1'b10) // again you have to check with hreadyout ..
			@(ahb_f.ahb_drv_cb);
		if(t1.Hwrite == 1)			// and check whether its write opt .. if yes thn send the data
			ahb_f.ahb_drv_cb.Hwdata <= t1.Hwdata;
		else
			ahb_f.ahb_drv_cb.Hwdata <= 0;
			
					
			

		end
	endtask		

endclass	
