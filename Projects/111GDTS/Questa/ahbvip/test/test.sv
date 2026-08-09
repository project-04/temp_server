class test extends uvm_test;

	`uvm_component_utils(test)

	env env_h;
	env_config env_cfg;
	bit has_sb=1;
	bit has_magt=1;
	bit has_sagt=1;
	int no_magt=1;
	int no_sagt=3;
	m_agent_config magt_cfg[];
	s_agent_config sagt_cfg[];
     rand bit[31:0]haddr;
 
     constraint c1 {haddr inside {[32'h8000_0000:32'h8000_03FF], [32'h8400_0000:32'h8400_03FF],
					     [32'h8800_0000:32'h8800_03FF]};}

	function new(string name="test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_cfg=env_config::type_id::create("env_cfg");

		if(has_magt)
			magt_cfg=new[no_magt];

		if(has_sagt)
			sagt_cfg=new[no_sagt];

		config_data;
		uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
		env_h=env::type_id::create("env_h",this);


	endfunction



     function void ctrl_randomize();
     this.randomize();
         env_cfg.haddr = this.haddr;
     endfunction

	function void config_data;

			if(has_magt)
				begin
					magt_cfg=new[no_magt];
					env_cfg.magt_cfg=new[no_magt];
					foreach(magt_cfg[i])
						begin
							
							magt_cfg[i]=m_agent_config::type_id::create($sformatf("magt_cfg[%0d]",i));
							if(!uvm_config_db#(virtual av_if)::get(this,"","vif",magt_cfg[i].vif))
								`uvm_fatal("TEST","CANNOT GET MAGT_CFG.VIF CHECK IF U HAVE SET IT?")
							magt_cfg[i].is_active=UVM_ACTIVE;
							env_cfg.magt_cfg[i]=magt_cfg[i];

						end
				end
			
			if(has_sagt)
				begin
					sagt_cfg=new[no_sagt];
					env_cfg.sagt_cfg=new[no_sagt];
					foreach(sagt_cfg[i])
						begin
							sagt_cfg[i]=s_agent_config::type_id::create($sformatf("sagt_cfg[%0d]",i));
							if(!uvm_config_db#(virtual av_if)::get(this,"",$sformatf("vif%0d",i),sagt_cfg[i].vif))
								`uvm_fatal("TEST","CANNOT GET SAGT_CFG.VIF CHECK IF U HAVE SET IT?")
							sagt_cfg[i].is_active=UVM_ACTIVE;
							env_cfg.sagt_cfg[i]=sagt_cfg[i];
						end
				end
			env_cfg.has_magt=has_magt;
			env_cfg.has_sagt=has_sagt;
			env_cfg.no_magt=no_magt;
			env_cfg.no_sagt=no_sagt;


	endfunction


endclass



class test1 extends test;

	`uvm_component_utils(test1)

	single_seq s1;

	function new(string name="test1",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		s1=single_seq::type_id::create("s1");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		//repeat(5)
		begin
		phase.raise_objection(this);
		s1.start(env_h.m_agt[0].m_seqr);
		#30;
		phase.drop_objection(this);
		end
	endtask

endclass



class test2 extends test;

	`uvm_component_utils(test2)

	inc_seq s2;
     ok_seq slv1,slv2,slv3;

	function new(string name="test2",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		s2=inc_seq::type_id::create("s2");
          slv1=ok_seq::type_id::create("slv1");
		slv2=ok_seq::type_id::create("slv2");
		slv3=ok_seq::type_id::create("slv3");

	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
	    fork
          begin
     		s2.start(env_h.m_agt[0].m_seqr);
          end
	
          begin
               if(haddr > 32'h8000_0000 && haddr < 32'h8000_03FF)
     		     slv1.start(env_h.s_agt[0].s_seqr);
               if(haddr > 32'h8400_0000 && haddr < 32'h8400_03FF)
          		slv2.start(env_h.s_agt[1].s_seqr);
               if(haddr > 32'h8800_0000 && haddr < 32'h8800_03FF)
          		slv3.start(env_h.s_agt[2].s_seqr);
           end   
          join      
		phase.drop_objection(this);
	endtask

endclass



class test3 extends test;

	`uvm_component_utils(test3)

	wrap_seq s3;

	function new(string name="test3",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		s3=wrap_seq::type_id::create("s1");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		//repeat(5)
		begin
		phase.raise_objection(this);
		s3.start(env_h.m_agt[0].m_seqr);
		#30;
		phase.drop_objection(this);
		end
	endtask

endclass

