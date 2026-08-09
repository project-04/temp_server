class base_test extends uvm_test;

        `uvm_component_utils(base_test)

        env envh;
        env_config e_cfg;
        master_config mcfg[];
        slave_config scfg[];

        bit has_master_agent = 1;
        bit has_slave_agent = 1;
        int no_of_master_agent = 1;
        int no_of_slave_agent = 4;
        int has_virtual_sequencer = 1;
        int has_scoreboard = 1;

        rand bit[31:0] Paddr;

        constraint c1{ Paddr inside {[32'h0000_0000:32'h0000_0fff]};}

        extern function new(string name="base_test", uvm_component parent);
        extern function void config_test;
        extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function base_test::new(string name="base_test", uvm_component parent);
        super.new(name,parent);
endfunction

function void base_test::config_test;

        if(has_master_agent)
        begin
                mcfg = new[no_of_master_agent];
                foreach(mcfg[i])
                begin
                        mcfg[i] = master_config::type_id::create($sformatf("mcfg[%0d]",i));

                        if(!uvm_config_db #(virtual apb_if)::get(this,"","vif",mcfg[i].vif))
                        `uvm_fatal("VIF CONFIG WRITE","cannot get() interface vif from uvm_config_db. Have you set it?")

                        mcfg[i].is_active = UVM_ACTIVE;
                        e_cfg.mcfg[i] = mcfg[i];
                end
        end

        if(has_slave_agent)
        begin
                scfg = new[no_of_slave_agent];
                foreach(scfg[i])
                begin
                        scfg[i] = slave_config::type_id::create($sformatf("scfg[%0d]",i));

                        if(!uvm_config_db #(virtual apb_if)::get(this,"","vif",scfg[i].vif))
                                `uvm_fatal("VIF CONFIG READ","cannot get() interface vif from uvm_config_db. Have you set it?")

                        scfg[i].is_active = UVM_ACTIVE;
                        e_cfg.scfg[i] = scfg[i];
                end
        end

        e_cfg.has_master_agent = has_master_agent;
        e_cfg.has_slave_agent = has_slave_agent;
        e_cfg.no_of_master_agent = no_of_master_agent;
        e_cfg.no_of_slave_agent = no_of_slave_agent;
        e_cfg.has_scoreboard = has_scoreboard;
        e_cfg.has_virtual_sequencer = has_virtual_sequencer;

endfunction

function void base_test::build_phase(uvm_phase phase);

        super.build_phase(phase);
        e_cfg = env_config::type_id::create("e_cfg");

        if(has_master_agent)
	 e_cfg.mcfg = new[no_of_master_agent];

        if(has_slave_agent)
	 e_cfg.scfg = new[no_of_slave_agent];

        config_test;

        uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);

        envh = env::type_id::create("envh",this);
endfunction

task base_test::run_phase(uvm_phase phase);
endtask

/**********************************   TEST1  *****************************/
class test1 extends base_test;

    `uvm_component_utils(test1);
    
    vseq1 seq1;

    function new(string name = "test1", uvm_component parent);
        super.new(name,parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
    
        super.randomize();
        uvm_config_db#(bit[31:0])::set(this,"*","Paddr",Paddr);

        seq1 = vseq1::type_id::create("seq1");

        phase.raise_objection(this);

        seq1.start(envh.v_sequencer);
        #200; 
        phase.drop_objection(this);

endtask

endclass
