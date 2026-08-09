class base_test extends uvm_test;

        `uvm_component_utils(base_test)

        Tb envh;
        env_config e_cfg;
        ahb_agent_config ahb_cfg[];
        apb_agent_config apb_cfg[];

        bit has_ahb_agent = 1;
        bit has_apb_agent = 1;
        int no_of_ahb_agent = 1;
        int no_of_apb_agent = 1;
        int has_virtual_sequencer = 1;
        int has_scoreboard = 1;

        extern function new(string name="base_test", uvm_component parent);
        extern function void config_test;
        extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);
endclass

function base_test::new(string name="base_test", uvm_component parent);
        super.new(name,parent);
endfunction

function void base_test::config_test;

        if(has_ahb_agent)
        begin
                ahb_cfg = new[no_of_ahb_agent];
                foreach(ahb_cfg[i])
                begin
                        ahb_cfg[i] = ahb_agent_config::type_id::create($sformatf("ahb_cfg[%0d]",i));

                        if(!uvm_config_db #(virtual bridge_if)::get(this,"","vif",ahb_cfg[i].vif))
                        `uvm_fatal("VIF CONFIG WRITE","cannot get() interface vif from uvm_config_db. Have you set it?")

                        ahb_cfg[i].is_active = UVM_ACTIVE;
                        e_cfg.wcfg[i] = ahb_cfg[i];
                end
        end

        if(has_apb_agent)
        begin
                apb_cfg = new[no_of_apb_agent];
                foreach(apb_cfg[i])
                begin
                        apb_cfg[i] = apb_agent_config::type_id::create($sformatf("apb_cfg[%0d]",i));

                        if(!uvm_config_db #(virtual bridge_if)::get(this,"","vif1",apb_cfg[i].vif1))
                                `uvm_fatal("VIF CONFIG READ","cannot get() interface vif from uvm_config_db. Have you set it?")

                        apb_cfg[i].is_active = UVM_ACTIVE;
                        e_cfg.apb_cfg[i] = apb_cfg[i];
                end
        end

        e_cfg.has_ahb_agent = has_ahb_agent;
        e_cfg.has_apb_agent = has_apb_agent;
        e_cfg.no_of_ahb_agent = no_of_ahb_agent;
        e_cfg.no_of_apb_agent = no_of_apb_agent;
        e_cfg.has_scoreboard = has_scoreboard;
        e_cfg.has_virtual_sequencer = has_virtual_sequencer;

endfunction

function void base_test::build_phase(uvm_phase phase);

        super.build_phase(phase);
        e_cfg = env_config::type_id::create("e_cfg");
        if(has_ahb_agent) e_cfg.wcfg = new[no_of_ahb_agent];
        if(has_apb_agent) e_cfg.apb_cfg = new[no_of_apb_agent];

        config_test;

        uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);

        envh = Tb::type_id::create("envh",this);
endfunction

task base_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
        #100;
        phase.drop_objection(this);
endtask

/************************* INCR TRANSFER PACKET *************************/

class incr_transfer_test extends base_test;

        `uvm_component_utils(incr_transfer_test)

        ahb_incr_vseq incr_vseqs;

        extern function new(string name="incr_transfer_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

function incr_transfer_test::new(string name="incr_transfer_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void incr_transfer_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task incr_transfer_test::run_phase(uvm_phase phase);

	//repeat(3)
	begin
        	phase.raise_objection(this);
		incr_vseqs = ahb_incr_vseq::type_id::create("incr_vseqs");
	        incr_vseqs.start(envh.v_sequencer);
		#2500;
	        phase.drop_objection(this);
	end	
endtask

//-**************************UNSPECIFIED TRANSFER PACKET*************************-//

class unspecified_incr_transfer_test extends base_test;

        `uvm_component_utils(unspecified_incr_transfer_test)

        ahb_unspec_vseq unspec_vseqs;

        extern function new(string name="unspecified_incr_transfer_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

function unspecified_incr_transfer_test::new(string name="unspecified_incr_transfer_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void unspecified_incr_transfer_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task unspecified_incr_transfer_test::run_phase(uvm_phase phase);

		//repeat(3)
        phase.raise_objection(this);
		unspec_vseqs = ahb_unspec_vseq::type_id::create("unspec_vseqs");
        unspec_vseqs.start(envh.v_sequencer);
        phase.drop_objection(this);
		
endtask

//-***************************WRAP TRANSFER PACKET*************************-//

class wrap_transfer_test extends base_test;

        `uvm_component_utils(wrap_transfer_test)

        ahb_wrap_vseq wrap_vseqs;

        extern function new(string name="wrap_transfer_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

function wrap_transfer_test::new(string name="wrap_transfer_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void wrap_transfer_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task wrap_transfer_test::run_phase(uvm_phase phase);

		//repeat(4)
        phase.raise_objection(this);
	wrap_vseqs = ahb_wrap_vseq::type_id::create("wrap_vseqs");
        wrap_vseqs.start(envh.v_sequencer);
	#120;
        phase.drop_objection(this);
		
endtask

