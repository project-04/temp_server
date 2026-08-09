

class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

	function new (string name = "apb_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	virtual apb_intf.APB_MON_MP apbf;
	apb_config apb_cfg;
	apb_trans t1;
	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
			`uvm_fatal("APB_MONITOR","failed to get config");

		t1 = apb_trans::type_id::create("t1");

	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
                                                          
		apbf = apb_cfg.apbf;

	endfunction 

	task run_phase(uvm_phase phase);
		repeat(2)
			@(apbf.apb_mon_cb);	
	
	forever
		begin	
			sampling_frm_dut();

		end	
	endtask


	task sampling_frm_dut();
			

			@(apbf.apb_mon_cb);

			begin 

				wait(apbf.apb_mon_cb.PREADY === 1'b1)
			
				t1.Presetn= apbf.apb_mon_cb.PRESETn;
				t1.Paddr = apbf.apb_mon_cb.PADDR;
				t1.Pwrite = apbf.apb_mon_cb.PWRITE;
				t1.Pslverr = apbf.apb_mon_cb.PSLVERR;
				t1.Psel = apbf.apb_mon_cb.PSEL;
				t1.Penable = apbf.apb_mon_cb.PENABLE;
			
				if(apbf.apb_mon_cb.PWRITE == 1)
					t1.Pwdata = apbf.apb_mon_cb.PWDATA;
				else
					t1.Prdata = apbf.apb_mon_cb.PRDATA;

			`uvm_info(get_type_name(),"SAPMLING FRM DUT",UVM_LOW)
			t1.print();

			end
		
		
	endtask					
					
								
endclass		
