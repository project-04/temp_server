

class wr_driver extends uvm_driver#(trans);

	`uvm_component_utils(wr_driver)
	
	function new (string name = "wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wr_agent_config w_cfg;
	virtual fsm_if.wr_drv_mp v_if;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
			`uvm_fatal(get_type_name,"failed to get config")

	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	
		this.v_if = w_cfg.v_if;	
	
	endfunction 


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		reset_dut();
		forever
			begin 
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end	
		
	endtask

	task reset_dut();
		@(v_if.wr_drv_cb)
			v_if.wr_drv_cb.rst <= 1;
		@(v_if.wr_drv_cb)
			v_if.wr_drv_cb.rst <= 0;
	endtask	

	task send_to_dut(trans t1);
		begin 
		
		//	@(v_if.wr_drv_cb);	
			v_if.wr_drv_cb.din <= t1.din;
			@(v_if.wr_drv_cb);
			
			`uvm_info(get_type_name(),"sending to dut",UVM_LOW)
			t1.print();
		end
	endtask

endclass	
