class s_driver extends uvm_driver#(trans);

	`uvm_component_utils(s_driver)

	virtual av_if.SDMP vif;
	trans txn;
	s_agent_config s_cfg;

	function new(string name="s_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(s_agent_config)::get(this,"","s_agent_config",s_cfg))
			`uvm_fatal("S_DRV","CANNOT GET SLAVE CONFIG IN SLAVE DRV")
		txn=trans::type_id::create("txn");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=s_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		send_data();
	endtask

	task send_data;
		bit[2:0] i;
		i=$urandom;
		txn.hready_out=1;
		repeat(i)
		@(vif.sdcb);
		
		vif.sdcb.hready_out<=txn.hready_out;
		txn.hresp=$urandom;
		$display("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa = %p",txn.hresp);
		if(!vif.sdcb.hwrite)
		begin
			txn.hrdata=$random;
			if(txn.hresp==0)
			begin
			  vif.sdcb.hrdata<=txn.hrdata;
		    	  @(vif.sdcb);
			  vif.sdcb.hresp<=txn.hresp;
			end
			else
    			 begin
		 	  vif.sdcb.hrdata<=txn.hrdata;
		    	  @(vif.sdcb);
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
			end
		end	
		else
		begin
			if(txn.hresp==0)
			begin
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
			end
			else
    			 begin
		    	  @(vif.sdcb);
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
			end
		end	
		repeat(i)
		@(vif.sdcb);
		vif.sdcb.hready_out<=0;
			
	//	`uvm_info("slave driver",$sformatf("Printing from slave driver \n %s",txn.sprint),UVM_LOW)
	endtask

endclass

