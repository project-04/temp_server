class test extends uvm_test;
	`uvm_component_utils(test)
	
	router_env envh;	
	env_config env_cfg;

	src_agt_config src_cfg[];
	dest_agt_config dest_cfg[];
	
	
	int no_of_src_agt = 1;
	int no_of_dest_agt= 3;

	int no_of_src_agt_top=1;
	int no_of_dest_agt_top=1;
	

	function new(string name = "test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		env_cfg = env_config::type_id::create("env_cfg");

		src_cfg = new[no_of_src_agt];
		env_cfg.src_cfg = new[no_of_src_agt];

		dest_cfg= new[no_of_dest_agt];
		env_cfg.dest_cfg= new[no_of_dest_agt];

		foreach(src_cfg[i])
			begin 
				src_cfg[i] = src_agt_config::type_id::create($sformatf("src_cfg[%0d]",i));
				if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("src_if_%0d",i),src_cfg[i].vif))
					`uvm_fatal("ENV","not able to get")
				src_cfg[i].is_active = UVM_ACTIVE;
				env_cfg.src_cfg[i] = src_cfg[i];
				
				
			end
		foreach(dest_cfg[i])
			begin 
				dest_cfg[i]= dest_agt_config::type_id::create($sformatf("dest_agt[%0d]",i));
				if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("dest_if_%0d",i),dest_cfg[i].vif))
					`uvm_fatal("ENV","not able to get")
				dest_cfg[i].is_active = UVM_ACTIVE;
				env_cfg.dest_cfg[i] = dest_cfg[i];
			end
		
		
	
		env_cfg.no_of_src_agt = no_of_src_agt;
		env_cfg.no_of_dest_agt= no_of_dest_agt;

		env_cfg.no_of_src_agt_top = no_of_src_agt_top;
		env_cfg.no_of_dest_agt_top= no_of_dest_agt_top;

	
		uvm_config_db #(env_config)::set(this,"*","env_cfg",env_cfg);

		super.build_phase(phase);
		envh = router_env::type_id::create("envh",this);

	endfunction
	
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction 
	
endclass


class small_test extends test;
	`uvm_component_utils(small_test)
	 bit[1:0] addr;
	
	small_vsequence vseq1;
	
	//small_sequence seq1;
	//read_sequence rd_seq1;
	
	function new(string name = "write_test",uvm_component parent);
		super.new(name,parent);
	endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	vseq1  = small_vsequence::type_id::create("Vseq1");                          // virtual sequece for small packet
	//seq1   = small_sequence::type_id::create("seq1");
	//rd_seq1 = read_sequence::type_id::create("rd_seq");
	
	addr = $urandom_range(0,2);
	
	uvm_config_db #(bit[1:0])::set(this,"*","bit1",addr);
	
	phase.raise_objection(this);
	/*
	repeat(20)
	begin 
		fork
		seq1.start(envh.src_agt_top_h[0].src_agth[0].src_seqrh);
		rd_seq1.start(envh.dest_agt_top_h[0].dest_agth[addr].dest_seqrh);
		join
	end*/
	vseq1.start(envh.v_seqr);                                                     //starting the virtual seqs

	phase.drop_objection(this);
endtask

endclass

class mid_test extends test;
	`uvm_component_utils(mid_test)
	 bit[1:0] addr;
	mid_vsequence vseq2;
	mid_sequence seq2;
	read_sequence rd_seq2;
	function new(string name = "mid_test",uvm_component parent);
		super.new(name,parent);
	endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	vseq2 = mid_vsequence::type_id::create("Vseq2");
	
	seq2=mid_sequence::type_id::create("seq2");
	rd_seq2 = read_sequence::type_id::create("rd_seq");
	
	addr = $urandom_range(0,2);
	
	uvm_config_db #(bit[1:0])::set(this,"*","bit2",addr);
	
	phase.raise_objection(this);
	/*repeat(5)
		begin
			fork
				seq2.start(envh.src_agt_top_h[0].src_agth[0].src_seqrh);
				rd_seq2.start(envh.dest_agt_top_h[0].dest_agth[addr].dest_seqrh);
			join
		end*/
	vseq2.start(envh.v_seqr);

	phase.drop_objection(this);
endtask

endclass

class large_test extends test;
	`uvm_component_utils(large_test)
	 bit[1:0] addr;
	large_vsequence vseq3;
	large_sequence seq3;
	read_sequence rd_seq3;
	function new(string name = "large_test",uvm_component parent);
		super.new(name,parent);
	endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	vseq3 =large_vsequence::type_id::create("Vseq3");
	
	seq3=large_sequence::type_id::create("seq3");
	rd_seq3 = read_sequence::type_id::create("rd_seq");
	
	addr = $urandom_range(0,2);
	
	uvm_config_db #(bit[1:0])::set(this,"*","bit3",addr);
	
	phase.raise_objection(this);
	/*repeat(10)
		begin
			fork
				seq3.start(envh.src_agt_top_h[0].src_agth[0].src_seqrh);
				rd_seq3.start(envh.dest_agt_top_h[0].dest_agth[addr].dest_seqrh);
			join
		end*/
	vseq3.start(envh.v_seqr);

	phase.drop_objection(this);
endtask

endclass
