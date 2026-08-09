class base_test extends uvm_test;

	`uvm_component_utils(base_test)
spi_env env_h;
wb_agent_config wb_cfg1;
sl_agent_config sl_cfg2;
wb_sequences wbseqh;
sl_sequence slseq;
int ctrl;
wb_seq1 wbseq1;



extern function new(string name ="base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function base_test::new(string name ="base_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test::build_phase(uvm_phase phase);

wb_cfg1=wb_agent_config::type_id::create("wb_cfg1");
sl_cfg2=sl_agent_config::type_id::create("sl_cfg2");
env_h = spi_env::type_id::create("env_h",this);
	super.build_phase(phase);
`uvm_info("base_test","Iam in Test",UVM_LOW)


		////// getting vif0 from top//////
	if(!uvm_config_db #(virtual spi_if)::get(this,"","vif_0",wb_cfg1.vif_0))
				`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")


		////// getting vif_1 from top//////
	if(!uvm_config_db #(virtual spi_if)::get(this,"","vif_1",sl_cfg2.vif_1))
				`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

		////// Setting  config //////
	uvm_config_db#(wb_agent_config)::set(this,"*","wb_agent_config",wb_cfg1);
	uvm_config_db#(sl_agent_config)::set(this,"*","sl_agent_config",sl_cfg2);

	
 ctrl[6:0]='b0000_1000;    // char len
 ctrl[7]=1'b0;             //res
 ctrl[8]=1'b1;             //go busy 
 ctrl[9]=1'b1;             //rx reg
 ctrl[10]=1'b0;			// tx neg
 ctrl[11]='b1;			// lsb
 ctrl[13:12]=2'b11;		//ie, ASS
 ctrl[31:14]='b0; 			// reserved 
		/////// Setting ctrl signal ////////
	uvm_config_db#(int)::set(this,"*","int",ctrl);
endfunction


task base_test::run_phase(uvm_phase phase);
	  wbseqh=wb_sequences::type_id::create("wbseqh",this);
    wbseq1=wb_seq1::type_id::create("wbseq1",this);
slseq=sl_sequence::type_id::create("slseq",this);

//raise objection
    phase.raise_objection(this);
	//create instance for sequence
  	//start the sequence
fork 
    wbseqh.start(env_h.wb_agt_h.wbagth.seqrh);
    slseq.start(env_h.sl_agt_h.slagth.seqrh);
join
//	#2000;//drop objection
    phase.drop_objection(this);
endtask   


////////////////////////////////////////////////////////////////////////////////////test 2//////////////////////

class base_test1 extends base_test;
`uvm_component_utils(base_test1)
wb_seq1 wbseq1;
sl_sequence1 slseq1;
int ctrl1;

extern function new(string name ="base_test1",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function base_test1::new(string name ="base_test1",uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test1::build_phase(uvm_phase phase);

ctrl1[6:0]='b00000000;
 ctrl1[7]=1'b0;
 ctrl1[8]=1'b1;
 ctrl1[9]=1'b0;
 ctrl1[10]=1'b1;
 ctrl1[11]='b0;
 ctrl1[13:12]=2'b11;
 ctrl1[31:14]='b0;

uvm_config_db#(int)::set(this,"*","ctrl1",ctrl1);
super.build_phase(phase);
endfunction


task base_test1::run_phase(uvm_phase phase);
	//raise objection
    wbseq1=wb_seq1::type_id::create("wbseq1",this);
	slseq1=sl_sequence1::type_id::create("slseq1",this);
    phase.raise_objection(this);
fork
wbseq1.start(env_h.wb_agt_h.wbagth.seqrh);
slseq1.start(env_h.sl_agt_h.slagth.seqrh);
join
    phase.drop_objection(this);
endtask   


////////////////////////////////////////////////////////////////////////////////////test 3//////////////////////
class base_test2 extends base_test1;
`uvm_component_utils(base_test2)
wb_seq2 wbseq2;
sl_sequence3 slseq2;
int ctrl2;

extern function new(string name ="base_test2",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function base_test2::new(string name ="base_test2",uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test2::build_phase(uvm_phase phase);

ctrl2[6:0]='b00100000;
 ctrl2[7]=1'b0;
 ctrl2[8]=1'b1;
 ctrl2[9]=1'b1;
 ctrl2[10]=1'b0;
 ctrl2[11]='b1;
 ctrl2[13:12]=2'b11;
 ctrl2[31:14]='b0;

uvm_config_db#(int)::set(this,"*","ctrl",ctrl2);
super.build_phase(phase);
endfunction


task base_test2::run_phase(uvm_phase phase);
	//raise objection
    wbseq2=wb_seq3::type_id::create("wbseq2",this);
	slseq2=sl_sequence3::type_id::create("slseq2",this);
    phase.raise_objection(this);
fork
wbseq2.start(env_h.wb_agt_h.wbagth.seqrh);
slseq2.start(env_h.sl_agt_h.slagth.seqrh);
join
    phase.drop_objection(this);
endtask

//////////////////////////////////////////////////////////////////////////////test 4////////////////////////////////////////////////
class base_test3 extends base_test;

`uvm_component_utils(base_test3)
wb_seq3 wbseq3;
sl_sequence3 slseq3;
int ctrl3;

extern function new(string name ="base_test3",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function base_test3::new(string name ="base_test3",uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test3::build_phase(uvm_phase phase);

ctrl3[6:0]='b00010101;
 ctrl3[7]=1'b0;
 ctrl3[8]=1'b1;
 ctrl3[9]=1'b1;
 ctrl3[10]=1'b0;
 ctrl3[11]='b1;
 ctrl3[13:12]=2'b11;
 ctrl3[31:14]='b0;

uvm_config_db#(int)::set(this,"*","ctrl",ctrl3);
super.build_phase(phase);
endfunction


task base_test3::run_phase(uvm_phase phase);
	//raise objection
    wbseq3=wb_seq3::type_id::create("wbseq3",this);
	slseq3=sl_sequence3::type_id::create("slseq3",this);
    phase.raise_objection(this);
fork
wbseq3.start(env_h.wb_agt_h.wbagth.seqrh);
slseq3.start(env_h.sl_agt_h.slagth.seqrh);
join
    phase.drop_objection(this);
endtask  
