class axi_test extends uvm_test;
  `uvm_component_utils(axi_test)

  // Proprties
  axi_env env_h;
  axi_env_config m_cfg;

  bit has_mast_agt =1;
  bit has_slv_agt =1;

  int no_of_mast_agt =4;
  int no_of_slv_agt =4;

  axi_mast_agt_cfg mast_cfg[];
  axi_slv_agt_cfg slv_cfg[];

  
	
  // uvm methods
  extern function new(string name ="axi_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function  void config_tb();

endclass

function axi_test :: new(string name ="axi_test", uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_test ::config_tb();
  if(has_mast_agt)
    begin
	mast_cfg = new[no_of_mast_agt];
	 foreach(mast_cfg[i])
	    begin
		mast_cfg[i] = axi_mast_agt_cfg::type_id::create($sformatf("mast_cfg[%0d]", i));
		// Get the Interface file here
		if(!uvm_config_db #(virtual axi_mif) ::get(this, "", $sformatf("axi_mif_%0d",i), mast_cfg[i].a_if))
			`uvm_fatal("TEST-CONFIGURATION", "Cannot a_mif from uvm_config_db. Have you set  it?")
		mast_cfg[i].is_active = UVM_ACTIVE;
		m_cfg.mast_cfg[i] = mast_cfg[i];
            end
    end

  if(has_slv_agt)
    begin
	slv_cfg=new[no_of_slv_agt];
	  
	  foreach(slv_cfg[i])
		begin
	          slv_cfg[i] =axi_slv_agt_cfg::type_id::create($sformatf("slv_cfg[%0d]", i));
		  // Get the interface file here
		if(!uvm_config_db #(virtual axi_sif) ::get(this, "", $sformatf("axi_sif_%0d",i), slv_cfg[i].a_if))
			`uvm_fatal("TEST-CONFIGURATION", "Cannot a_sif from uvm_config_db. Have you set  it?")
		  slv_cfg[i].is_active =UVM_ACTIVE;
		  m_cfg.slv_cfg[i] = slv_cfg[i];
		end
    end

m_cfg.has_mast_agt = has_mast_agt;
m_cfg.has_slv_agt = has_slv_agt;
m_cfg.no_of_mast_agt = no_of_mast_agt;
m_cfg.no_of_slv_agt = no_of_slv_agt;
m_cfg.has_scoreboard=1;
m_cfg.has_virtual_sequencer=1;
endfunction

function void axi_test :: build_phase(uvm_phase phase);
	
	m_cfg = axi_env_config :: type_id ::create("m_cfg");
	if(has_mast_agt)
		m_cfg.mast_cfg=new[no_of_mast_agt];
	if(has_slv_agt)
		m_cfg.slv_cfg=new[no_of_slv_agt];
	config_tb();
 
	uvm_config_db #(axi_env_config)::set(this, "*", "axi_env_config", m_cfg);

	super.build_phase(phase);

	env_h = axi_env :: type_id::create("axi_env", this);

endfunction 

//**********************************************************************************************************//

class axi_first_seq_test extends axi_test;
	`uvm_component_utils(axi_first_seq_test)
		
	// Properties
	axi_first_seq axi_seqh;
	bit [1:0] read_addr;
	bit [1:0] write_addr;
	
	// Methods
	extern function new(string name="axi_first_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_first_seq_test :: new(string name ="axi_first_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_first_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	repeat(20)
		begin
			read_addr =0;
			write_addr =0;

			uvm_config_db #(bit[1:0])::set(this, "*", "read_addr", read_addr);
			uvm_config_db #(bit[1:0])::set(this, "*", "write_addr", write_addr);
		

			axi_seqh = axi_first_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end		
	#3000;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_second_seq_test extends axi_test;
	`uvm_component_utils(axi_second_seq_test)
		
	// Properties
	axi_second_seq axi_seqh;
	bit [1:0] read_addr;
	bit [1:0] write_addr;
	
	// Methods
	extern function new(string name="axi_second_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_second_seq_test :: new(string name ="axi_second_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_second_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	repeat(2)
		begin
			read_addr =$urandom_range(0,3);
			write_addr=read_addr;

			uvm_config_db #(bit[1:0])::set(this, "*", "read_addr", read_addr);
			uvm_config_db #(bit[1:0])::set(this, "*", "write_addr", write_addr);

			axi_seqh = axi_second_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end
	#1600;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_third_seq_test extends axi_test;
	`uvm_component_utils(axi_third_seq_test)
		
	// Properties
	axi_third_seq axi_seqh;
	bit [1:0] read_addr;
	bit [1:0] write_addr;

	// Methods
	extern function new(string name="axi_third_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_third_seq_test :: new(string name ="axi_third_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_third_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	
	repeat(20)
		begin

			read_addr =1;
			write_addr =1;

			uvm_config_db #(bit[1:0])::set(this, "*", "read_addr", read_addr);
			uvm_config_db #(bit[1:0])::set(this, "*", "write_addr", write_addr);

			axi_seqh = axi_third_seq :: type_id :: create("axi_seqh");
			repeat(1)
			axi_seqh.start(env_h.v_seqrh);
		end
	#1500;
	phase.drop_objection(this);
endtask


//**********************************************************************************************************//

class axi_fourth_seq_test extends axi_test;
	`uvm_component_utils(axi_fourth_seq_test)
		
	// Properties
	axi_fourth_seq axi_seqh;
	
	// Methods
	extern function new(string name="axi_fourth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_fourth_seq_test :: new(string name ="axi_fourth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_fourth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	repeat(20)
		begin
			axi_seqh = axi_fourth_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end
	#1200;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_fifth_seq_test extends axi_test;
	`uvm_component_utils(axi_fifth_seq_test)
		
	// Properties
	axi_fifth_seq axi_seqh;
	
	// Methods
	extern function new(string name="axi_fifth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_fifth_seq_test :: new(string name ="axi_fifth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_fifth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	repeat(10)
		begin
			axi_seqh = axi_fifth_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end
	#1400;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_sixth_seq_test extends axi_test;
	`uvm_component_utils(axi_sixth_seq_test)
		
	// Properties
	axi_sixth_seq axi_seqh;
	
	// Methods
	extern function new(string name="axi_sixth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_sixth_seq_test :: new(string name ="axi_sixth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_sixth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
		repeat(10)
			begin
				axi_seqh = axi_sixth_seq :: type_id :: create("axi_seqh");
				axi_seqh.start(env_h.v_seqrh);
			end
	#1400;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_seventh_seq_test extends axi_test;
	`uvm_component_utils(axi_seventh_seq_test)
		
	// Properties
	axi_seventh_seq axi_seqh;

	bit[1:0] read_addr;
	bit[1:0] write_addr;
	
	// Methods
	extern function new(string name="axi_seventh_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_seventh_seq_test :: new(string name ="axi_seventh_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_seventh_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);

	repeat(20)
		begin

			read_addr =$urandom_range(0,3);
			write_addr =read_addr;

			uvm_config_db #(bit[1:0])::set(this, "*", "read_addr", read_addr);
			uvm_config_db #(bit[1:0])::set(this, "*", "write_addr", write_addr);

			axi_seqh = axi_seventh_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end
	#1400;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_eighth_seq_test extends axi_test;
	`uvm_component_utils(axi_eighth_seq_test)
		
	// Properties
	axi_eighth_seq axi_seqh;
	
	// Methods
	extern function new(string name="axi_eighth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_eighth_seq_test :: new(string name ="axi_eighth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_eighth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
		repeat(20)
			begin
				axi_seqh = axi_eighth_seq :: type_id :: create("axi_seqh");
				axi_seqh.start(env_h.v_seqrh);
			end
	#1400;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_ninth_seq_test extends axi_test;
	`uvm_component_utils(axi_ninth_seq_test)
		
	// Properties
	axi_ninth_seq axi_seqh;
	
	// Methods
	extern function new(string name="axi_ninth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_ninth_seq_test :: new(string name ="axi_ninth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_ninth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
		repeat(20)
			begin
				axi_seqh = axi_ninth_seq :: type_id :: create("axi_seqh");
				axi_seqh.start(env_h.v_seqrh);
			end
	#1400;
	phase.drop_objection(this);
endtask

//**********************************************************************************************************//

class axi_tenth_seq_test extends axi_test;
	`uvm_component_utils(axi_tenth_seq_test)
		
	// Properties
	axi_tenth_seq axi_seqh;

	bit[1:0] read_addr;
	bit[1:0] write_addr;
	
	// Methods
	extern function new(string name="axi_tenth_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_tenth_seq_test :: new(string name ="axi_tenth_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_tenth_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);

	repeat(20)
		begin

			read_addr =$urandom_range(0,1);
			write_addr =$urandom_range(2,3);

			uvm_config_db #(bit[1:0])::set(this, "*", "read_addr", read_addr);
			uvm_config_db #(bit[1:0])::set(this, "*", "write_addr", write_addr);

			axi_seqh = axi_tenth_seq :: type_id :: create("axi_seqh");
			axi_seqh.start(env_h.v_seqrh);
		end
	#1400;
	phase.drop_objection(this);
endtask


//**********************************************************************************************************//

class axi_eleventh_seq_test extends axi_test;
	`uvm_component_utils(axi_eleventh_seq_test)
		
	// Properties
	axi_eleventh_seq axi_seqh;

	bit[1:0] read_addr[];
	bit[1:0] write_addr[];
	
	// Methods
	extern function new(string name="axi_eleventh_seq_test", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

function axi_eleventh_seq_test :: new(string name ="axi_eleventh_seq_test", uvm_component parent);
	super.new(name, parent);
endfunction

task axi_eleventh_seq_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);

	repeat(20)
		begin
			read_addr=new[4];
			write_addr=new[4];

			for(int i=0; i<4; i++)
				begin

					read_addr[i] =$urandom_range(0,3);
					write_addr[i] =read_addr[i];

					uvm_config_db #(bit[1:0])::set(this, "*", $sformatf("read_addr[%0d]",i), read_addr[i]);
					uvm_config_db #(bit[1:0])::set(this, "*", $sformatf("write_addr[%0d]",i),  write_addr[i]);
				end

					axi_seqh = axi_eleventh_seq :: type_id :: create("axi_seqh");
					axi_seqh.start(env_h.v_seqrh);
		end
	#1400;
	phase.drop_objection(this);
endtask

