class s_monitor extends uvm_monitor;

	`uvm_component_utils(s_monitor)

	virtual sl_if.SMMP vif;
	s_agent_config s_cfg;
	uvm_analysis_port#(trans) monitor_port;

	function new(string name="s_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(s_agent_config)::get(this,"","s_agent_config",s_cfg))
			`uvm_fatal("S_MON","CANNOT GET SLAVE CONFIG IN SLAVE MON")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=s_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		@(vif.smcb);
		forever
		collect_data;
	endtask

	
	task collect_data;
		trans txn=trans::type_id::create("txn");
		wait(vif.smcb.hready_out && vif.smcb.haddr!=0)
		txn.hwrite=vif.smcb.hwrite;
		txn.haddr=vif.smcb.haddr;
		txn.hsize=vif.smcb.hsize;
		txn.hresp=vif.smcb.hresp;
		@(vif.smcb);
		wait(vif.smcb.hready_out)
	    if(txn.hwrite)
		begin
		  if(txn.hsize==0)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[7:0];
		        else if(txn.haddr[1:0]==2'b01)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[15:8];
			else if(txn.haddr[1:0]==2'b10)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[23:16];
			else if(txn.haddr[1:0]==2'b11)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[31:24];
		    end

		else if(txn.hsize==1)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[15:0];
		        else if(txn.haddr[1:0]==2'b10)
			     txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[31:16];
		    end
		else if(txn.hsize==2)
	               txn.slave_write_mem[txn.haddr]=vif.smcb.hwdata[31:0];
		
		end
	   else
		begin
		  if(txn.hsize==0)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[7:0];
		        else if(txn.haddr[1:0]==2'b01)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[15:8];
			else if(txn.haddr[1:0]==2'b10)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[23:16];
			else if(txn.haddr[1:0]==2'b11)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[31:24];
		    end
		else if(txn.hsize==1)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[15:0];
		        else if(txn.haddr[1:0]==2'b10)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata[31:16];
		    end
		else if(txn.hsize==2)
			     txn.slave_read_mem[txn.haddr]=vif.smcb.hrdata;
		
		end
		monitor_port.write(txn);
		if(txn.hwrite)	
		 $display($time, "slave monitor write operation mem[%0h]= %h",txn.haddr,txn.slave_write_mem[txn.haddr]);
	        else
		$display($time, "slave monitor read operation mem[%0h]= %h",txn.haddr,txn.slave_read_mem[txn.haddr]);
		`uvm_info("slave monitor",$sformatf("Printing from slave monitor \n %s",txn.sprint),UVM_LOW)

	endtask

endclass

