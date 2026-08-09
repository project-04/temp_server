module duv_rtl(
	input clk, rst, write,
	input [3:0] a, b,
	output reg out
	);

	reg [8:0] internal_reg;

	always @(posedge clk or posedge rst) begin
	    	if (rst) begin
			internal_reg <= 9'h0;
			out          <= 1'b0;
	    	end
		else if(write) begin
			internal_reg <= {a,b};
			out          <= 1'b1;
	   	 end
	    	else begin
	    		out              <= 1'b0;
		end
	end
endmodule


interface inter_face(input clk);
	logic rst, write;
	logic [3:0] a, b;
	logic out;
	
	clocking drv_cb@(posedge clk);
		default input #1 output #1;
		
		output rst, write, a, b;
		input out;
	endclocking
	clocking mon_cb@(posedge clk);
		default input #1 output #1;
		
		input rst, write, a, b;
		input out;
	endclocking
	
	modport DRV(clocking drv_cb);
	modport MON(clocking mon_cb);
endinterface

package ral_back_door;
	
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	
	class register_one extends uvm_reg;
	
		rand uvm_reg_field lsb_4bits;   //[3:0]
		rand uvm_reg_field msb_4bits;	//[7:4]
		uvm_reg_field reserved;		//[8]
		
		`uvm_object_utils(register_one)
		
		function new(string name="register_one");
			super.new(name, 9, UVM_NO_COVERAGE); //9-bit register, no coverage for now
		endfunction
		
		virtual function void build();
			lsb_4bits = uvm_reg_field::type_id::create("lsb_4bits");
			lsb_4bits.configure(this,
						4,	//size
						0,	//lsb_pos
						"RW",	//access
						0,	//volatile
						4'h0,	//reset value
						1,	//has_reset
						0,	//is_rand
						1);	//individually accessible (cover_on)
			
			msb_4bits = uvm_reg_field::type_id::create("msb_4bits");
			msb_4bits.configure(this, 4, 4,	"RW", 0, 4'h0, 1, 0, 1);
			
			reserved = uvm_reg_field::type_id::create("reserved", , get_full_name());
			reserved.configure(this,  1, 8, "RW", 0, 1'b0, 1, 0, 0);
		endfunction
		
	endclass
	
	class reg_block extends uvm_reg_block;

		rand register_one reg_1;
		`uvm_object_utils(reg_block)

		function new(string name = "reg_block");
		        super.new(name,UVM_NO_COVERAGE);
		endfunction

		virtual function void build();
		        // create registers
		        reg_1 = register_one :: type_id ::create("reg_1");

		        //build registers
		        reg_1.configure(this,null,"");
		        reg_1.build();

		        //create default address map
		        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN, 1);
		        default_map.add_reg(reg_1 , 'h0C, "RW");

		        reg_1.add_hdl_path_slice("internal_reg", 0, 9);

		        //set backdoor root(DUT path)
		        add_hdl_path("top.DUV", "RTL");
		        
		        lock_model();
		endfunction
	endclass
		
	class agt_config extends uvm_object;
		`uvm_object_utils(agt_config)
		
		uvm_active_passive_enum is_active;
		virtual inter_face vif;
		
		function new(string name="agt_config");
			super.new(name);
		endfunction
	endclass
	
	class env_config extends uvm_object;
		`uvm_object_utils(env_config)
		
		int no_of_agents;
		reg_block reg_blk;
		
		function new(string name="env_config");
			super.new(name);
		endfunction
	endclass
	
	
	class xtn extends uvm_sequence_item;
		`uvm_object_utils(xtn)
		
		localparam int size_of_array = 40;
		
		     logic       rst   [size_of_array];
		rand logic       write [size_of_array];
		rand logic [3:0] a     [size_of_array];
		rand logic [3:0] b     [size_of_array];
		     logic       out   [size_of_array];
		
		constraint c1{ foreach(write[i]){
					write[i] dist{0:=5, 1:=3};
				}
			}
		
		constraint c2{ foreach(a[i]){
					a[i] dist{0:=4, 4:=3};
				}
			}
		constraint c3{ foreach(b[i]){
					b[i] inside{[1:9]};
				}
			}
		
		function new(string name="xtn");
			super.new(name);
		endfunction
		
		function void print_pkt(input string str);
			$display("----------------------");
			$display("Printing PKT form %0s",str);
			$display("rst   = %p", this.rst);
			$display("write = %p", this.write);
			$display("a     = %p", this.a);
			$display("b     = %p", this.b);
			$display("out   = %p", this.out);
			$display("----------------------\n");
		endfunction
	endclass
	
	class drv extends uvm_driver #(xtn);
		`uvm_component_utils(drv)
		
		agt_config agt_configh;
		virtual inter_face.DRV vif;

		function new(string name="drv", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(agt_config)::get(this, "", "agt_config", agt_configh))
				`uvm_fatal("agt", "can't get agt_config")
		endfunction
		
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			vif = agt_configh.vif;
		endfunction
		
		task run_phase(uvm_phase phase);
			forever
			       begin
				    seq_item_port.get_next_item(req);
				    
				    req.print_pkt("DRIVER");
				    
				    @(vif.drv_cb);
				    vif.drv_cb.rst <= 1;
				    @(vif.drv_cb);
				    vif.drv_cb.rst <= 0;
				    @(vif.drv_cb);
				    
				    foreach(req.write[i])
				    begin
				    	vif.drv_cb.write <= req.write[i];
				    	vif.drv_cb.a     <= req.a[i];
				    	vif.drv_cb.b     <= req.b[i];
				    	@(vif.drv_cb);
				    end
				    
				    seq_item_port.item_done();
			       end
			       
		endtask
	endclass
	
	class mon extends uvm_monitor;
		`uvm_component_utils(mon)
		
		agt_config agt_configh;
		virtual inter_face.MON vif;
		xtn mon_pkt;
		uvm_analysis_port #(xtn) monitor_port;
	
		function new(string name="mon", uvm_component parent);
			super.new(name, parent);
			monitor_port = new("monitor_port", this);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(agt_config)::get(this, "", "agt_config", agt_configh))
				`uvm_fatal("agt", "can't get agt_config")
		endfunction
		
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			vif = agt_configh.vif;
		endfunction
		
		task run_phase(uvm_phase phase);
			forever
			       begin
					mon_pkt = xtn::type_id::create("mon_pkt");
				    	
				    	@(vif.mon_cb);
				    	@(vif.mon_cb);
				    	@(vif.mon_cb);
				    foreach(mon_pkt.write[i])
				    begin
				    	@(vif.mon_cb);
				    	mon_pkt.rst[i]   = vif.mon_cb.rst;
				    	mon_pkt.write[i] = vif.mon_cb.write;
				    	mon_pkt.a[i]     = vif.mon_cb.a;
				    	mon_pkt.b[i]     = vif.mon_cb.b;
				    	mon_pkt.out[i]   = vif.mon_cb.out;
					monitor_port.write(mon_pkt);
				    end
				    
				    mon_pkt.print_pkt("MONITOR");
			       end
		endtask
	endclass
	
	class seqr extends uvm_sequencer #(xtn);
		`uvm_component_utils(seqr)
		
		function new(string name="seqr", uvm_component parent);
			super.new(name, parent);
		endfunction
	endclass
	
	class seq extends uvm_sequence #(xtn);
		`uvm_object_utils(seq)
		
		function new(string name="seq");
			super.new(name);
		endfunction
	endclass
	class pkt_seq extends seq;
		`uvm_object_utils(pkt_seq)

		function new(string name="pkt_seq");
			super.new(name);
		endfunction
		
		task body();
		//repeat(2)
		  	begin
		  	     req = xtn::type_id::create("req");
			     start_item(req);
			     assert(req.randomize());
		  	     finish_item(req);
			end
	  	endtask
	endclass 
	
	class agt extends uvm_agent;
		`uvm_component_utils(agt)
		
		drv  drvh;
		mon  monh;
		seqr seqrh;
		agt_config agt_configh;
		
		function new(string name="agt", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(agt_config)::get(this, "", "agt_config", agt_configh))
				`uvm_fatal("agt", "can't get agt_config")
			
			monh = mon::type_id::create("monh", this);
			if(agt_configh.is_active == UVM_ACTIVE)
			begin
				drvh = drv::type_id::create("drvh", this);
				seqrh = seqr::type_id::create("seqrh", this);
			end
		endfunction
		
		function void connect_phase(uvm_phase phase);
		if(agt_configh.is_active == UVM_ACTIVE)
		begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
		end
	
		endfunction
	endclass
	
	class scoreboard extends uvm_scoreboard;
		`uvm_component_utils(scoreboard)

		env_config m_cfg;
		reg_block reg_blk;

		uvm_status_e status;

		logic [8:0] sb_reg_1[40];
		logic [4:0] msb [40];   // bits [7:4] are 4 bits wide
		logic [4:0] lsb [40];   // bits [3:0] are 4 bits wide
		
		xtn xtn_pkt;

		uvm_tlm_analysis_fifo #(xtn) tlm_fifo;
		
		function new(string name = "scoreboard",uvm_component parent);
			super.new(name,parent);

			tlm_fifo = new("tlm_fifo",this);
		endfunction

		function void build_phase(uvm_phase phase);
        		super.build_phase(phase);

  			if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
    				`uvm_fatal("CONFIG", "Cannot get env_config")

  			reg_blk = m_cfg.reg_blk;
  		endfunction
  		
  		task run_phase(uvm_phase phase);
        		super.run_phase(phase);

			foreach(sb_reg_1[i])
			begin
                        	tlm_fifo.get(xtn_pkt);
                	   reg_blk.reg_1.read(status, sb_reg_1[i], UVM_BACKDOOR, .map(reg_blk.default_map));
                	end

			foreach(msb[i])
   				msb[i] = sb_reg_1[i][8:4];

    			foreach(lsb[i])
    				lsb[i] = sb_reg_1[i][3:0];

			//$display("msb   = %p", msb);
			//$display("lsb   = %p", lsb);

                	`uvm_info("SB REG_ONE",$sformatf("\nmsb   = %p \nlsb   = %p \nreg_1 = %p" ,msb, lsb, sb_reg_1),UVM_NONE)
        	endtask
	endclass

	class env extends uvm_env;
		`uvm_component_utils(env)
		
		agt agth[];
		env_config env_configh;
		scoreboard sb;
		
		function new(string name="env", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			
			if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
				`uvm_fatal("env", "can't get env_config")
			
			agth = new[env_configh.no_of_agents];
			
			foreach(agth[i])
			begin
				agth[i] = agt::type_id::create($sformatf("agth[%0d]",i), this);
			end
			
			sb = scoreboard::type_id::create("sb", this);
		endfunction
		
		function void connect_phase(uvm_phase phase);
			agth[0].monh.monitor_port.connect(sb.tlm_fifo.analysis_export);
		endfunction
	endclass

	class test extends uvm_test;
		`uvm_component_utils(test)
		
		env envh;
		env_config env_configh;
		agt_config agt_configh[];
		reg_block reg_blk;
		
		function new(string name="test", uvm_component parent);
			super.new(name, parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
                                
			env_configh = env_config::type_id::create("env_configh");
			env_configh.no_of_agents = 1;
			uvm_config_db #(env_config)::set(this, "*", "env_config", env_configh);
			
			reg_blk = reg_block::type_id::create("reg_blk");
			reg_blk.build();
			reg_blk.lock_model();
			env_configh.reg_blk = this.reg_blk;
			
			agt_configh = new[env_configh.no_of_agents];
			foreach(agt_configh[i])
			begin
				agt_configh[i] = agt_config::type_id::create($sformatf("agt_configh[%0d]",i));
				if(i==0)
					agt_configh[i].is_active = UVM_ACTIVE;
				else
					agt_configh[i].is_active = UVM_PASSIVE;
			
           			if(! uvm_config_db #(virtual inter_face)::get(this, "", "inter_face", agt_configh[i].vif))
                                	`uvm_fatal(get_type_name(),"Have you set the config correctly?");
			end
			
			foreach(agt_configh[i])
			begin
				uvm_config_db #(agt_config)::set(this, $sformatf("*.agth[%0d]*",i), "agt_config", agt_configh[i]);
			end
			
			envh = env::type_id::create("envh", this);
		endfunction
		
		function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			
			uvm_factory::get().print();
			uvm_top.print_topology();
		endfunction
	endclass
	class pkt_test extends test;
	      `uvm_component_utils(pkt_test)
	     
		pkt_seq pkt_seqh;

	 	function new(string name = "pkt_test", uvm_component parent);
			 super.new(name, parent);
	  	endfunction

		function void build_phase(uvm_phase phase);
		 	super.build_phase(phase);
		endfunction
	       
		task run_phase(uvm_phase phase);
		     	phase.raise_objection(this);

		     	pkt_seqh= pkt_seq::type_id ::create("pkt_seqh");
	 	     	pkt_seqh.start(envh.agth[0].seqrh);
	 	     	
			phase.drop_objection(this);
			
			$display("\n################################################ TEST ################################################\n");
	  	endtask
	endclass
endpackage

module top;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	
	import ral_back_door::*;
	
	bit clk;
	
	always #10 clk = ~clk;

	inter_face if_1(clk);

	duv_rtl DUV(	.clk(clk),
			.rst(if_1.rst),
			.write(if_1.write),
			.a(if_1.a),
			.b(if_1.b),
			.out(if_1.out)
			);

	initial begin
		//qverilog -vopt +acc ../ral_back_door.sv; vsim work.top -voptargs=+acc
		//qverilog -vopt +acc ../ral_back_door.sv
		//qverilog ral_back_door.sv
		//vcs -sverilog -ntb_opts uvm ral_back_door.sv; ./simv
		
		uvm_config_db #(virtual inter_face)::set(null,"*","inter_face",if_1);
		//uvm_top.set_report_verbosity_level(UVM_NONE);		
		run_test("pkt_test");
	end
endmodule
