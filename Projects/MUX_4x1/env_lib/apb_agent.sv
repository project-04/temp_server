class agent_cfg extends uvm_object;
		`uvm_object_utils(agent_cfg)
		
		virtual mux_if vif;
		uvm_active_passive_enum is_active;
		
		function new(string name = "name");
			super.new(name);
		endfunction
	endclass

	class env_cfg extends uvm_object;
		`uvm_object_utils(env_cfg)
		
		int no_of_agents;
		
		function new(string name = "name");
			super.new(name);
		endfunction
	endclass
	
	class trans extends uvm_sequence_item;
		`uvm_object_utils(trans)
		
		function new(string name = "name");
			super.new(name);
		endfunction
		
		rand logic i0,i1,i2,i3, s0,s1;
		logic d_out;
		
		function void do_print(uvm_printer printer);
			printer.print_field("i0", i0, $bits(i0), UVM_BIN);
			printer.print_field("i1", i1, $bits(i1), UVM_BIN);
			printer.print_field("i2", i2, $bits(i2), UVM_BIN);
			printer.print_field("i3", i3, $bits(i3), UVM_BIN);
			
			printer.print_field("s0", s0, $bits(s0), UVM_BIN);
			printer.print_field("s1", s1, $bits(s1), UVM_BIN);
			
			printer.print_field("d_out", d_out, $bits(d_out), UVM_BIN);
		endfunction
	endclass
	
	class seqs extends uvm_sequencer #(trans);
		`uvm_component_utils(seqs)
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class drv extends uvm_driver #(trans);
		`uvm_component_utils(drv)
		virtual mux_if.DRV_MP vif;
		static int mon_inc;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			forever begin
				seq_item_port.get_next_item(req);
				begin
					//#10;
					vif.i0 <= req.i0;
					vif.i1 <= req.i1;
					vif.i2 <= req.i2;
					vif.i3 <= req.i3;
					
					vif.s0 <= req.s0;
					vif.s1 <= req.s1;
					
					req.print();
					`uvm_info("DRV", "run end drv", UVM_LOW)
					#10;
				end
				seq_item_port.item_done();
			end
		endtask
	endclass
	
	class mon extends uvm_monitor;
		`uvm_component_utils(mon)
		uvm_analysis_port #(trans) mon_port;
		virtual mux_if.MON_MP vif;
		trans xtn;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
			mon_port = new("mon_port", this);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			forever begin
				xtn = trans::type_id::create("xtn");
				#10;
				xtn.i0 = vif.i0;
				xtn.i1 = vif.i1;
				xtn.i2 = vif.i2;
				xtn.i3 = vif.i3;
				
				xtn.s0 = vif.s0;
				xtn.s1 = vif.s1;
				
				xtn.d_out = vif.d_out;
				
				xtn.print();
				mon_port.write(xtn);
				`uvm_info("MON", "run end mon", UVM_LOW)
				//#10;
			end
		endtask
	endclass
	
	class agent extends uvm_agent;
		`uvm_component_utils(agent)
		mon monh;
		seqs seqsh;
		drv drvh;
		agent_cfg agent_cfgh;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			if(!uvm_config_db #(agent_cfg)::get(this, "", "agent_cfg", agent_cfgh))
				`uvm_fatal("ID", "FATAL in the agent geing");
			
			monh = mon::type_id::create("monh", this);
			if(agent_cfgh.is_active == UVM_ACTIVE)
			begin
				seqsh = seqs::type_id::create("seqsh", this);
				drvh = drv::type_id::create("drvh", this);
			end
		endfunction
		
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			monh.vif = agent_cfgh.vif;
			if(agent_cfgh.is_active == UVM_ACTIVE)
			begin
				drvh.seq_item_port.connect(seqsh.seq_item_export);
				drvh.vif = agent_cfgh.vif;
			end
		endfunction
	endclass
	
	class seq extends uvm_sequence #(trans);
		`uvm_object_utils(seq)
		
		function new(string name = "name");
			super.new(name);
		endfunction
		
		task body();
			repeat(6) 
			begin
				req = trans::type_id::create("req");
				start_item(req);
				//assert(req.randomize() with {i0==0; i1==0; i2==0; i3==0; s0==0; s1==0;});
				assert(req.randomize());
				finish_item(req);
			end
			
			/*begin
				req = trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {i0==1; i1==1; i2==1; i3==1; s0==1; s1==1;});
				finish_item(req);
			end*/
		endtask
	endclass
