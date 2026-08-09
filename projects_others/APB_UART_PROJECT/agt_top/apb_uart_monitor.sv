class apb_uart_monitor extends uvm_monitor;

	`uvm_component_utils(apb_uart_monitor)
	
	function new (string name = "apb_uart_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_agt_config apb_uart_agt_cfg;
	virtual uart_if.MON_MP vif;
	apb_uart_trans t1;

	uvm_analysis_port#(apb_uart_trans) mon2sb;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

			if(!uvm_config_db#(apb_uart_agt_config)::get(this,"","apb_uart_agt_config",apb_uart_agt_cfg))
				`uvm_fatal("apb_uart_monitor","failed to get config");

		t1 = apb_uart_trans::type_id::create("t1");
		mon2sb = new ("mon2sb",this);


		`uvm_info("apb_uart_monitor","build phase is over",UVM_HIGH);
	endfunction 
	

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

			vif = apb_uart_agt_cfg.vif;

		`uvm_info("apb_uart_monitor","connect phase is over",UVM_HIGH);
	endfunction 

	
	virtual task run_phase(uvm_phase phase);
			mon2sb.write(t1);

	forever
		begin
			sample(t1); 
			//`uvm_info("apb_uart_monitor","monitor value",UVM_NONE);
			//t1.print();
			mon2sb.write(t1);
	
		end
		`uvm_info("apb_uart_monitor","run phase is over",UVM_HIGH);
	endtask

	task sample(apb_uart_trans t1);

			@(vif.mon_cb);

			while(vif.mon_cb.Psel !== 1 )
			@(vif.mon_cb);
			begin 
				while(vif.mon_cb.Pready !== 1)
				@(vif.mon_cb);
			
				t1.Presetn= vif.mon_cb.Presetn;
				t1.Paddr = vif.mon_cb.Paddr;
				t1.Pwrite = vif.mon_cb.Pwrite;
				t1.Pwdata = vif.mon_cb.Pwdata;
				t1.Prdata = vif.mon_cb.Prdata;
				t1.Pslverr = vif.mon_cb.Pslverr;
				t1.Psel = vif.mon_cb.Psel;
				t1.Penable = vif.mon_cb.Penable;
				t1.IRQ = vif.mon_cb.IRQ;
	

			 
			// LCR
			if (t1.Paddr == 32'hC && t1.Pwrite == 1'b1)
				begin
					t1.LCR = t1.Pwdata;
				end
	

			
			// IER
			if(t1.Paddr == 32'h4 && t1.Pwrite == 1'b1)
				begin
					t1.IER = t1.Pwdata;
				end


		
			// FCR
			if(t1.Paddr == 32'h8 && t1.Pwrite == 1'b1)
				begin
					t1.FCR = t1.Pwdata;
				end
	
			//IIR
			if(t1.Paddr == 32'h8 && t1.Pwrite == 1'b0)
				begin
					while(vif.mon_cb.IRQ !== 1)
					@(vif.mon_cb);

					t1.IIR = vif.mon_cb.Prdata;
				end
			
			//MCR
			if(t1.Paddr == 32'h10 && t1.Pwrite == 1'b1)
				begin
					t1.MCR = vif.mon_cb.Pwdata;
				end

			//LSR
			if(t1.Paddr == 32'h14 && t1.Pwrite == 1'b0)
				begin
					t1.LSR = vif.mon_cb.Prdata;
				end
				
			//div MSB
			if(t1.Paddr == 32'h20 && t1.Pwrite == 1'b1)
				begin
					t1.divisor[15:8] = t1.Pwdata;		
					t1.dl_access = 1'b1;
				end	
				
				
			//div LSB
			if (t1.Paddr == 32'h1C && t1.Pwrite == 1'b1)
				begin
					t1.divisor[7:0] = t1.Pwdata;
					t1.dl_access = 1'b1;
			 	end
	

				
			// THR
			if(t1.Paddr == 32'h0 && t1.Pwrite == 1'b1  )
				begin
					t1.data_in_thr = 1'b1;
					if(t1.THR.size() == 0)  //
						t1.THR.push_back(t1.Pwdata);
			 	end
		
			// RBR
			if(t1.Paddr == 32'h0 && t1.Pwrite == 1'b0)
			if(vif.mon_cb.Prdata !== 0)
				begin
					t1.data_in_rbr = 1'b1;
					t1.RBR.push_back(t1.Prdata);
				end

		
			end
	
	endtask		

endclass
	
