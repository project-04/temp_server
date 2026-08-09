class apb_monitor extends uvm_monitor;
      `uvm_component_utils(apb_monitor)
   
      virtual apb_if.MON_MP vif;
      apb_config apb_cfg;
      uvm_analysis_port#(apb_trans) monitor_port;

      apb_trans xtn;

      bit [7:0] q_thr[$];
      bit [7:0] q_rbr[$];

      function new(string name="apb_monitor",uvm_component parent);
               super.new(name,parent);

      endfunction
  
      function void build_phase(uvm_phase phase);
	   if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
	    `uvm_fatal("MONITOR","cannot get vif to abp_cfg")

               xtn=apb_trans::type_id::create("xtn");

               monitor_port = new("monitor_port",this);

      endfunction
  
      function void connect_phase(uvm_phase phase);
                    super.connect_phase(phase);
 	            vif = apb_cfg.vif; 
      endfunction
  
      task run_phase(uvm_phase phase);
	   forever 
            begin
	       collect_data();
	    end
      endtask
  
      task collect_data();
           //repeat(2);
           @(vif.mon_cb);
 	   while(vif.mon_cb.psel!==1) //and pready is HIGH.//only need to monitor when psel is HIGH	
		@(vif.mon_cb);
        begin
	   while(vif.mon_cb.pready!==1)
		@(vif.mon_cb);
		//pclk
		xtn.PRESETn = vif.mon_cb.presetn;
		xtn.PADDR   = vif.mon_cb.paddr;
		xtn.PWDATA  = vif.mon_cb.pwdata;
		xtn.PWRITE  = vif.mon_cb.pwrite;
		xtn.PSEL    = vif.mon_cb.psel;
		xtn.PENABLE  = vif.mon_cb.penable;
		//rxd
	
		xtn.PREADY  = vif.mon_cb.pready;
		xtn.PRDATA  = vif.mon_cb.prdata;
		xtn.IRQ     = vif.mon_cb.irq;
		xtn.PSLVERR = vif.mon_cb.pslverr;
		//txd

	//DIV1 MSB--------------------------------------- 2
		if(xtn.PADDR == 8'h20 && xtn.PWRITE == 1)
		begin
			xtn.DIV2 = vif.mon_cb.pwdata;
			$display("DIV2 in MONITOR : %0h",xtn.DIV2);
		end

	//DIV1 LSB--------------------------------------- 3
		if(xtn.PADDR == 8'h1c && xtn.PWRITE == 1)
		begin
			xtn.DIV1 = vif.mon_cb.pwdata;
			$display("DIV1 in MONITOR : %0h",xtn.DIV1);
		end
	 //LCR------------------------------------------- 1
		if(xtn.PADDR == 8'hc && xtn.PWRITE == 1)
		begin
			xtn.LCR = vif.mon_cb.pwdata;
			$display("LCR in MONITOR : %0h",xtn.LCR);
		end

	//FCR-------------------------------------------- 4
		if(xtn.PADDR == 8'h8 && xtn.PWRITE == 1)
		begin
			xtn.FCR = vif.mon_cb.pwdata;
			$display("FCR in MONITOR : %0h",xtn.FCR);
		end
	//IER-------------------------------------------- 6
		if(xtn.PADDR == 8'h4 && xtn.PWRITE == 1)
		begin
			xtn.IER = vif.mon_cb.pwdata;
			$display("IER in MONITOR : %0h",xtn.IER);
		end

	//MCR-------------------------------------------- 5
		if(xtn.PADDR == 8'h10 && xtn.PWRITE == 1)
		begin
			xtn.MCR = vif.mon_cb.pwdata;
			$display("MCR in MONITOR : %0h",xtn.MCR);
		end
	//THR-------------------------------------------- 7
		if(xtn.PADDR == 8'h0 && xtn.PWRITE == 1)
		begin
		//	xtn.data_in_thr = 1'b1;
                        //if(xtn.THR.size == 0 || xtn.THR[0] != vif.mon_cb.pwdata)
                        xtn.data_in_thr=1'b1;
			xtn.THR.push_back(vif.mon_cb.pwdata);
			$display("THR in MONITOR : %0b",vif.mon_cb.pwdata);
                        q_thr.push_back(vif.mon_cb.pwdata);
		end



	//IIR-------------------------------------------- 8 
		if(xtn.PADDR == 8'h8 && xtn.PWRITE == 0)
		begin
		//	$display("%%%%%%%%%%%%%%%%%%%%%%");
			while(vif.mon_cb.irq!==1)
			  @(vif.mon_cb);
		//	$display("^^^^^^^^^^^^^^^^^^^^^^^");
			    xtn.IIR = vif.mon_cb.prdata;
			    $display("IIR in MONITOR : %0b",xtn.IIR);
		end
		
	//RBR------------------------------------------- 9
		if(xtn.PADDR == 8'h0 && xtn.PWRITE == 0)
		begin
		//	xtn.data_in_rb = 1'b1;
                        xtn.data_in_rbr=1'b1;
			xtn.RBR.push_back(vif.mon_cb.prdata);
			$display($time," RBR in MONITOR : %0b",vif.mon_cb.prdata);
                        q_rbr.push_back(vif.mon_cb.prdata);
		end


	//LSR------------------------------------------- 11
		if(xtn.PADDR == 8'h14 && xtn.PWRITE == 0)
		begin
			xtn.LSR = vif.mon_cb.prdata;
			$display("LSR in MONITOR : %0b",xtn.LSR);
		end
         // end
	//MSR------------------------------------------- 10 
		if(xtn.PADDR == 8'h18 && xtn.PWRITE == 0)
		begin
			xtn.MSR = vif.mon_cb.prdata;
			$display("MSR in MONITOR : %0b",xtn.MSR);
		end

	      //`uvm_info(get_full_name(), "Printing from APB agent monitor:", UVM_MEDIUM)
		//xtn.print();				

		monitor_port.write(xtn);

       end
  endtask

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		
		$display("\n\nextract phase start\napb q_thr = %p", q_thr);
		$display("apb q_rbr = %p\n", q_rbr);
	endfunction
endclass

