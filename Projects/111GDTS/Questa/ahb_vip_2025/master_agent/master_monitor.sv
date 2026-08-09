class m_monitor extends uvm_monitor;

	`uvm_component_utils(m_monitor)

	virtual av_if.MMMP vif;

	m_agent_config m_cfg;
	trans txn;
	uvm_analysis_port#(trans)monitor_port;

	function new(string name="m_monitor",uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(m_agent_config)::get(this,"","m_agent_config",m_cfg))
			`uvm_fatal("M_MON","CANNOT GET MASTER CONFIG IN MASTER MON")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
			collect_data(txn);
	endtask
	

	task collect_data(trans txn);
		txn=trans::type_id::create("txn");
		wait(vif.mmcb.hready_out==1 && vif.mmcb.haddr!=0)
		txn.hsize=vif.mmcb.hsize;
		txn.htrans=vif.mmcb.htrans;
		txn.hwrite=vif.mmcb.hwrite;
		txn.haddr=vif.mmcb.haddr;
		txn.hburst=vif.mmcb.hburst;
		txn.hresp=vif.mmcb.hresp;
		@(vif.mmcb);
		wait(vif.mmcb.hready_out==1)
          $display($time,"MM @@@@@@@@@@@@@@@@@@@@@@@  - %p",vif.mmcb.hwdata);
		if(txn.hwrite)
		begin

		  if(txn.hsize==0)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[7:0];
		        else if(txn.haddr[1:0]==2'b01)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[15:8];
			else if(txn.haddr[1:0]==2'b10)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[23:16];
			else if(txn.haddr[1:0]==2'b11)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[31:24];
		    end

		else if(txn.hsize==1)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[15:0];
		        else if(txn.haddr[1:0]==2'b10)
			     txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[31:16];
		    end
		else if(txn.hsize==2)
	               txn.master_write_mem[txn.haddr]=vif.mmcb.hwdata[31:0];
		
			txn.hresp=vif.mmcb.hresp;
		end
	   else
		begin
		  if(txn.hsize==0)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[7:0];
		        else if(txn.haddr[1:0]==2'b01)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[15:8];
			else if(txn.haddr[1:0]==2'b10)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[23:16];
			else if(txn.haddr[1:0]==2'b11)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[31:24];
		    end
		else if(txn.hsize==1)
		    begin
			if(txn.haddr[1:0]==2'b00)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[15:0];
		        else if(txn.haddr[1:0]==2'b10)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata[31:16];
		    end
		else if(txn.hsize==2)
			     txn.master_read_mem[txn.haddr]=vif.mmcb.hrdata;
		
		 //$display($time, "master monitor read operation mem[%0h]=%0d",txn.haddr,txn.master_write_mem[txn.haddr]);
		txn.hresp=vif.mmcb.hresp;
		end

		`uvm_info("master monitor",$sformatf("Printing from master monitor \n %s",txn.sprint),UVM_LOW)
		if(txn.hwrite)
		 $display($time, "master monitor write operation mem[%0h]=%h",txn.haddr,txn.master_write_mem[txn.haddr]);
		else
		 $display("master monitor read operation mem[%0d]=%h",txn.haddr,txn.master_read_mem[txn.haddr]);
		monitor_port.write(txn);
	endtask

endclass

