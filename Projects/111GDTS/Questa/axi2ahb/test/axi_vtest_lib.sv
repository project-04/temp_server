class axi_base_test extends uvm_test;

    axi_env_config env_cfg_h;
    master_config mst_cfg_h;
    ahb_cfg slv_cfg_h;
;

    int no_of_master=1;
    int no_of_slave=1;

    bit has_master_agent=1;
    bit has_slave_agent=1;
    bit has_scoreboard=1;
        bit has_virtual_sequencer=1;
    axi_env env_h;

    `uvm_component_utils(axi_base_test)

    extern function new(string name="axi_base_test",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass

    function axi_base_test::new(string name="axi_base_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void axi_base_test::build_phase(uvm_phase phase);

         env_cfg_h=axi_env_config::type_id::create("env_cfg_h");
         if(has_master_agent)
             begin
                 mst_cfg_h=master_config::type_id::create("mst_cfg_h");
                 mst_cfg_h.is_active=UVM_ACTIVE;
                 if(!uvm_config_db #(virtual axi_if)::get(this,"","axi_if",mst_cfg_h.mif))
                     `uvm_fatal("axi_base_test","Unable to get axi interface, have you set it?")
                 env_cfg_h.mst_cfg_h=mst_cfg_h;
             end

        if(has_slave_agent)
            begin
                slv_cfg_h=ahb_cfg::type_id::create("slv_cfg_h");
                slv_cfg_h.is_active=UVM_ACTIVE;
                if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",slv_cfg_h.vif))
                    `uvm_fatal("axi_base_test","Unable to get axi interface, have you set it?")
                env_cfg_h.m_cfg=slv_cfg_h;
            end
         env_cfg_h.has_master_agent=has_master_agent;
         env_cfg_h.has_slave_agent=has_slave_agent;
         env_cfg_h.has_scoreboard=has_scoreboard;
       //  slv_cfg_h.no_of_slave=no_of_slave;
         //mst_cfg_h.no_of_master=no_of_master;
         uvm_config_db#(axi_env_config)::set(this,"*","axi_env_config",env_cfg_h);
         super.build_phase(phase);
         env_h=axi_env::type_id::create("env_h",this);
    endfunction


class fixed_seq_test extends axi_base_test;
    `uvm_component_utils(fixed_seq_test)
    vseq_fixed vseq;
    extern function new(string name="fixed_seq_test",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function fixed_seq_test::new(string name="fixed_seq_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void fixed_seq_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task fixed_seq_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
            vseq=vseq_fixed::type_id::create("vseq");
            vseq.start(env_h.vseqr_h);
          #25000;
        phase.drop_objection(this);
    endtask
	
class incr_seq_test extends axi_base_test;
    `uvm_component_utils(incr_seq_test)
    vseq_incr vseq;
    extern function new(string name="incr_seq_test",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function incr_seq_test::new(string name="incr_seq_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void incr_seq_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task incr_seq_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
            vseq=vseq_incr::type_id::create("vseq");
            vseq.start(env_h.vseqr_h);
           #25000;
        phase.drop_objection(this);
    endtask

class wrap_seq_test extends axi_base_test;
    `uvm_component_utils(wrap_seq_test)
    vseq_wrap vseq;
    extern function new(string name="wrap_seq_test",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function wrap_seq_test::new(string name="wrap_seq_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void wrap_seq_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task wrap_seq_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
            vseq=vseq_wrap::type_id::create("vseq");
            vseq.start(env_h.vseqr_h);
           #25000;
        phase.drop_objection(this);
    endtask
	
	
class random_seq_test extends axi_base_test;
    `uvm_component_utils(random_seq_test)
    vseq_random vseq;
    extern function new(string name="random_seq_test",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function random_seq_test::new(string name="random_seq_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void random_seq_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task random_seq_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
            vseq=vseq_random::type_id::create("vseq");
            vseq.start(env_h.vseqr_h);
           #25000;
        phase.drop_objection(this);
    endtask

class rsize2_seq_test extends axi_base_test;
    `uvm_component_utils(rsize2_seq_test)
    vseq_rsize2 vseq1;
    extern function new(string name="rsize2_seq_test",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function rsize2_seq_test::new(string name="rsize2_seq_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void rsize2_seq_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task rsize2_seq_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
            vseq1=vseq_rsize2::type_id::create("vseq1");
            vseq1.start(env_h.vseqr_h);
           #25000;
        phase.drop_objection(this);
    endtask

