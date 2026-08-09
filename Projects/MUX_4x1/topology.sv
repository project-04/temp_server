module mux_4_1(input i0, i1, i2, i3, s0, s1, output reg d_out);
	always @(*)
	begin
		case ({s1, s0})
			2'b00: d_out = i0;
			2'b01: d_out = i1;
			2'b10: d_out = i2;
			2'b11: d_out = i3;
			default: d_out = 1'bx;  // default to unknown if no match
		endcase
	end
endmodule
/*
module mux_assertions(input i0, i1, i2, i3, s0, s1, d_out);
	property p1;
		@(posedge s0)
		(s0==0 && s1==0) |-> d_out == i0;
	endproperty
	
	a1 : assert property(p1)
			$display("pass");
		else
			$display("fail");
endmodule
*/

interface mux_if();

	logic i0,i1,i2,i3, s0,s1, d_out;
	
	modport DRV_MP(
		output i0,i1,i2,i3, s0,s1, input d_out
	);
	modport MON_MP(
		input i0,i1,i2,i3, s0,s1, d_out
	);
endinterface

module top();

	import uvm_pkg::*;
	`include "uvm_macros.svh"

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
			repeat(1) 
			begin
				req = trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {s0==0; s1==0;});
				//assert(req.randomize());
				finish_item(req);
			end
		endtask
	endclass
	
	class sb extends uvm_scoreboard;
		`uvm_component_utils(sb)
		uvm_tlm_analysis_fifo #(trans) fifo0;
		uvm_tlm_analysis_fifo #(trans) fifo1;
		
		trans data0, data1, cov_data_h;
		
		covergroup covergroup_name;
			c0 : coverpoint cov_data_h.i0;
			c1 : coverpoint cov_data_h.i1;
			c2 : coverpoint cov_data_h.i2;
			c3 : coverpoint cov_data_h.i3;
			
			c4 : coverpoint cov_data_h.s0;
			c5 : coverpoint cov_data_h.s1;
			
			c6 : coverpoint cov_data_h.d_out;
		endgroup
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
			fifo0 = new("fifo0", this);
			fifo1 = new("fifo1", this);
			covergroup_name = new();
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			fifo0.get(data0);
			fifo1.get(data1);
			
			cov_data_h = data1;
			
			covergroup_name.sample();
		endtask
		
		function void report_phase(uvm_phase phase);
			super.report_phase(phase);
			
			$display("covergroup_name = %f", covergroup_name.get_coverage());
		endfunction
	endclass
	
	class agent_top extends uvm_env;
		`uvm_component_utils(agent_top)
		env_cfg env_cfgh;
		agent agenth[];
				
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", env_cfgh))
   	 			`uvm_fatal("agent_top", "Failed to get env_cfg from config_db")
			
			agenth = new[env_cfgh.no_of_agents];
			foreach(agenth[i])
				agenth[i] = agent::type_id::create($sformatf("agenth[%0d]", i), this);
		endfunction
	endclass
	
	class env extends uvm_env;
		`uvm_component_utils(env)
		env_cfg env_cfgh;
		agent_top agent_toph;
		sb sbh;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", env_cfgh))
   	 			`uvm_fatal("agent_top", "Failed to get env_cfg from config_db")
   	 			
			agent_toph = agent_top::type_id::create("agent_toph", this);
			sbh = sb::type_id::create("sbh", this);
		endfunction
		
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			
			for(int i=0; i<env_cfgh.no_of_agents; i++)
			begin
				if(i == 0)
					agent_toph.agenth[i].monh.mon_port.connect(sbh.fifo0.analysis_export);
				else
					agent_toph.agenth[i].monh.mon_port.connect(sbh.fifo1.analysis_export);
			end
			
		endfunction
	endclass
	
	class test extends uvm_test;
		`uvm_component_utils(test)
		env envh;
		env_cfg env_cfgh;
		agent_cfg agent_cfgh[];
		virtual mux_if vif;
		seq seqh;
		
		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			envh = env::type_id::create("envh", this);
			
			env_cfgh = env_cfg::type_id::create("env_cfgh");
			env_cfgh.no_of_agents = 2;
			uvm_config_db #(env_cfg)::set(this, "*", "env_cfg", env_cfgh);
			
			uvm_config_db #(virtual mux_if)::get(this, "", "mux_if", vif);
			
			agent_cfgh = new[env_cfgh.no_of_agents];
			foreach(agent_cfgh[i])
			begin
				agent_cfgh[i] = agent_cfg::type_id::create($sformatf("agent_cfgh[%0d]", i));
				agent_cfgh[i].vif = vif;
				if(i==0) 
					agent_cfgh[i].is_active = UVM_ACTIVE;
				else
					agent_cfgh[i].is_active = UVM_PASSIVE;
				uvm_config_db #(agent_cfg)::set(this, $sformatf("envh.agent_toph.agenth[%0d]*", i), "agent_cfg", agent_cfgh[i]);
			end
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			
			uvm_top.print_topology();
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			seqh = seq::type_id::create("seqh");
			
			phase.raise_objection(this);
			seqh.start(envh.agent_toph.agenth[0].seqsh);
			phase.drop_objection(this);
		endtask
	endclass
	
	mux_if vif();
	
	mux_4_1 duv(
		vif.i0,
		vif.i1,
		vif.i2,
		vif.i3,
		vif.s0,
		vif.s1,
		vif.d_out
		);
	/*mux_assertions assertions_duv(
		vif.i0,
		vif.i1,
		vif.i2,
		vif.i3,
		vif.s0,
		vif.s1,
		vif.d_out
		);*/
		
	initial begin
		uvm_top.set_report_verbosity_level(UVM_NONE);
		
		uvm_config_db #(virtual mux_if)::set(null, "*", "mux_if", vif);
		run_test("test");
		
	end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
