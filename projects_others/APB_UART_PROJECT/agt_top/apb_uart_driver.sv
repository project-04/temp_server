class apb_uart_driver extends uvm_driver#(apb_uart_trans);

	`uvm_component_utils(apb_uart_driver)
	
	function new (string name = "apb_uart_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_agt_config apb_uart_agt_cfg;
	virtual uart_if.DRV_MP vif;


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

			if(!uvm_config_db#(apb_uart_agt_config)::get(this,"","apb_uart_agt_config",apb_uart_agt_cfg))
				`uvm_fatal("apb_uart_monitor","failed to get config");
	endfunction 
	

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

				vif = apb_uart_agt_cfg.vif;
	endfunction 

	
	virtual task run_phase(uvm_phase phase);
	reset_dut();
		forever
			begin 
				seq_item_port.get_next_item(req);
				drive(req);
			//	`uvm_info("apb_uart_driver","driver value",UVM_LOW)
			//	req.print();
				seq_item_port.item_done();
			end
		endtask


	task reset_dut();
		begin 
			@(vif.drv_cb);
			vif.drv_cb.Presetn <= 0;
			@(vif.drv_cb);
			vif.drv_cb.Presetn <= 1;
		end
	endtask

			

	task drive(apb_uart_trans t1);

			@(vif.drv_cb);
			vif.drv_cb.Paddr <= t1.Paddr;
			vif.drv_cb.Pwdata <= t1.Pwdata;
			vif.drv_cb.Pwrite <= t1.Pwrite;
			vif.drv_cb.Psel <= 1;
			vif.drv_cb.Penable <= 0;


			@(vif.drv_cb);
			vif.drv_cb.Penable <= 1;

			while(vif.drv_cb.Pready === 0)
			@(vif.drv_cb);

			if(t1.Paddr === 32'h8 && t1.Pwrite === 0)
				begin 
					while(vif.drv_cb.IRQ === 0)
					@(vif.drv_cb);

					t1.IIR = vif.drv_cb.Prdata;

					seq_item_port.put_response(t1);

				end	
	endtask

endclass
	
