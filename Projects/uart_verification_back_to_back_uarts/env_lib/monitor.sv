class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)

	virtual uart_if.MON_MP vif;
 
 	agent_config agent_configh;
 	
 	trans xtn;
 
   	uvm_analysis_port #(trans) monitor_port;
	
	logic [7:0] q_thr[$];
	logic [7:0] q_rbr[$];
	//logic [15:0] divisor_latch;
	
	function new(string name ="monitor",uvm_component parent);
		super.new(name,parent);
		
		monitor_port = new("monitor_port", this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", agent_configh))
		begin
			`uvm_fatal("apb_agent", "cannot get the agent_configh form agent_config");
		end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		vif = agent_configh.vif;
	endfunction
	
	task collect_data();
 		`uvm_info("APB_AGENT_MONITOR_COLLECT_DATA_START", "START", UVM_LOW)
           
		xtn = trans::type_id::create("xtn");
		
		@(vif.mon_cb);
		
		//while(!(vif.mon_cb.PSEL)) @(vif.mon_cb);
		
		//while(!(vif.mon_cb.PREADY)) @(vif.mon_cb);
		
		/*wait(vif.mon_cb.PSEL);
		
		wait(vif.mon_cb.PREADY);
			@(vif.mon_cb);*/
		
		wait(vif.mon_cb.PSEL && vif.mon_cb.PREADY);
			@(vif.mon_cb);
				
				xtn.PRESETn = vif.mon_cb.PRESETn;
				xtn.PADDR   = vif.mon_cb.PADDR;
				xtn.PWDATA  = vif.mon_cb.PWDATA;
				xtn.PSEL    = vif.mon_cb.PSEL;
				xtn.PENABLE = vif.mon_cb.PENABLE;
				xtn.PWRITE  = vif.mon_cb.PWRITE;
				xtn.PRDATA  = vif.mon_cb.PRDATA;
				xtn.PREADY  = vif.mon_cb.PREADY;
				xtn.PSLVERR = vif.mon_cb.PSLVERR;
				xtn.IRQ     = vif.mon_cb.IRQ;
				
				//--------------------------------Divisor Latch Register MSB
				if(xtn.PADDR == 8'h20 && xtn.PWRITE == 1) 
				begin
					xtn.divisor[15:8] = vif.mon_cb.PWDATA;
          				$write(get_full_name()," %0t ",$time); $display("divisor[15:8] in Monitor----------%0b",xtn.divisor[15:8]);
				end
				
				//--------------------------------Divisor Latch Register LSB
				if(xtn.PADDR == 8'h1c && xtn.PWRITE == 1) 
				begin
					xtn.divisor[7:0] = vif.mon_cb.PWDATA;
          				$write(get_full_name()," %0t ",$time); $display("divisor[7:0] in Monitor----------%0b",xtn.divisor[7:0]);
				end
				
				//--------------------------------FIFO Control Register
				if(xtn.PADDR == 8'h8 && xtn.PWRITE == 1) 
				begin
					//divisor_latch = xtn.divisor;
					xtn.fcr = vif.mon_cb.PWDATA;
          				$write(get_full_name()," %0t ",$time); $display("fcr in Monitor----------%0b",xtn.fcr);
				end
				
				//--------------------------------Line Control Register
				if(xtn.PADDR == 8'hc && xtn.PWRITE == 1) 
				begin
					xtn.lcr = vif.mon_cb.PWDATA;
          				$write(get_full_name()," %0t ",$time); $display("lcr in Monitor----------%0b",xtn.lcr);
				end
				
				//--------------------------------Interrupt Enable Register
				if(xtn.PADDR == 8'h4 && xtn.PWRITE == 1) 
				begin
					xtn.ier = vif.mon_cb.PWDATA;
          				$write(get_full_name()," %0t ",$time); $display("ier in Monitor----------%0b",xtn.ier);
				end
				
				//--------------------------------Transimtter Holding Register
				if(xtn.PADDR == 8'h00 && xtn.PWRITE == 1) 
				begin
					xtn.data_in_thr = 1'b1;
					xtn.thr.push_back(vif.mon_cb.PWDATA);
					
					q_thr.push_back(xtn.thr[0]);
					
          				$write(get_full_name()," %0t ########## ",$time); $display("thr in Monitor----------%p\n",xtn.thr);
				end
				
				//--------------------------------Interrupt Identification Register
				if(xtn.PADDR == 8'h8 && xtn.PWRITE == 0) 
				begin
					//while(!vif.mon_cb.IRQ) @(vif.mon_cb);
					//xtn.iir = vif.mon_cb.PRDATA;
					wait(vif.mon_cb.IRQ);
     					@(vif.mon_cb);
					xtn.iir = vif.mon_cb.PRDATA;
					$display(get_full_name()," %0d----------iir in Monitor---------%0b",$time, xtn.iir); //for time %t, %d is ok.
				end
				
				//--------------------------------Receiver Buffer Register
				if(xtn.PADDR == 8'h00 && xtn.PWRITE == 0) 
				begin
					xtn.data_in_rbr = 1'b1;
					xtn.rbr.push_back(vif.mon_cb.PRDATA);
					
					q_rbr.push_back(xtn.rbr[0]);
					
          				$write(get_full_name()," %0t ##########",$time); $display("rbr in Monitor----------%p\n",xtn.rbr);
				end
				
				//--------------------------------Mode Control Register
				if(xtn.PADDR == 8'h10 && xtn.PWRITE == 1) 
				begin
					xtn.mcr = vif.mon_cb.PWDATA;
          				$write(get_full_name(),"%0t ",$time); $display("mcr in Monitor----------%0b",xtn.mcr);
				end
				
				//--------------------------------Line Status Register
				if(xtn.PADDR == 8'h14 && xtn.PWRITE == 0) 
				begin
					xtn.lsr = vif.mon_cb.PRDATA;
          				$write(get_full_name()," %0t ",$time); $display("lsr in Monitor----------%0b",xtn.lsr);
				end
				
				//xtn.print();
				monitor_port.write(xtn);
        
        			`uvm_info("APB_AGENT_MONITOR_COLLECT_DATA_END", "END", UVM_LOW)

	endtask

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		`uvm_info("APB_AGENT_MONITOR_RUN_PHASE_START", "START", UVM_LOW)
		
		
		forever
		begin
			collect_data();
		end
   		
   		`uvm_info("APB_AGENT_MONITOR_RUN_PHASE_END", "END", UVM_LOW)
	endtask
	
	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		
   		$display(get_full_name(),"q_thr = %p"  ,q_thr);
   		$display(get_full_name(),"q_rbr = %p\n",q_rbr);
	endfunction
endclass
