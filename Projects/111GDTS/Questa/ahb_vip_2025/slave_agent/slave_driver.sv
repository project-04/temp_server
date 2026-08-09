class s_driver extends uvm_driver#(trans);

	`uvm_component_utils(s_driver)

	virtual sl_if.SDMP vif;
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
		forever begin
			seq_item_port.get_next_item(req);
	//	`uvm_info("slave driver",$sformatf("Printing from slave driver \n %p",vif.sdcb.hready_out),UVM_LOW)
			send_data();
			seq_item_port.item_done;
		end
	endtask

	task send_data;
               
		bit[2:0] i;
		i=$urandom;
		txn.hready_out=1;
	     vif.sdcb.hrdata<={$random};
		`uvm_info("slave driver",$sformatf("slave driver reset  %p",vif.sdcb.hresetn),UVM_LOW)
          if(vif.sdcb.hresetn==0)
          begin
          
		     vif.sdcb.hready_out<=1;
	          vif.sdcb.hresp<=0;
		`uvm_info("slave driver",$sformatf("slave driver hready %p",vif.sdcb.hready_out),UVM_LOW)
		@(vif.sdcb);
          end 
          else if(vif.sdcb.hresetn==1)
          begin
               $display("HRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr  %p",vif.sdcb.hrdata);
		
		vif.sdcb.hready_out<=0;
		txn.hresp=$urandom;
		if(!vif.sdcb.hwrite)
		begin
			txn.hrdata=$random;
			if(txn.hresp==0)
			begin
	     	vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hrdata<={$random};
              // $display("\n \n \n \n \n HRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr  %p",vif.sdcb.hrdata);
		    	  @(vif.sdcb);
			  vif.sdcb.hresp<=txn.hresp;
     		vif.sdcb.hready_out<=0;
			end
			else
    			 begin
			  vif.sdcb.hrdata<={$random};
              // $display("HRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr  %p",vif.sdcb.hrdata);
		    	  @(vif.sdcb);
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
     		vif.sdcb.hready_out<=0;
			end
		end	
		else
		begin
			if(txn.hresp==0)
			begin
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
		    	  @(vif.sdcb);
     		vif.sdcb.hready_out<=0;
			end
			else
    			 begin
		    	  @(vif.sdcb);
		    	  @(vif.sdcb);
			  vif.sdcb.hready_out<=txn.hready_out;
			  vif.sdcb.hresp<=txn.hresp;
     		vif.sdcb.hready_out<=0;
			end
		end	
		end	
	//	`uvm_info("slave driver",$sformatf("Printing from slave driver \n %s",txn.sprint),UVM_LOW)
	endtask

endclass

