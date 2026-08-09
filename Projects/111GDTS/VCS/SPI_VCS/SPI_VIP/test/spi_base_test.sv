class spi_base_test extends uvm_test;

//FACTORY
	`uvm_component_utils(spi_base_test)

//CONFIG HANDEL
	spi_env_config m_cfg;
	master_agent_config master_cfg;
	slave_agent_config  slave_cfg;
//MEMBERS
	spi_env    envh;


bit [31:0]cnt_reg;


//METHODS
	extern function new(string name = "spi_base_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void configre();

endclass
//CONSTRUCTOR
	function spi_base_test::new(string name = "spi_base_test",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_base_test::build_phase(uvm_phase phase);

		m_cfg=spi_env_config::type_id::create("m_cfg");
				
		configre;

		uvm_config_db #(spi_env_config)::set(this,"*","spi_env_config",m_cfg);

		envh=spi_env::type_id::create("envh",this);	
		endfunction

//CONFIGURE
	function void spi_base_test::configre();
		master_cfg=master_agent_config::type_id::create("master_cfg");
		if(!uvm_config_db#(virtual master_if)::get(this,"","mas_if",master_cfg.vif))
		         	`uvm_fatal("test","UNABLE TO GET CONFIG form top")
		master_cfg.is_active=UVM_ACTIVE;
		m_cfg.master_cfg=master_cfg;

		slave_cfg=slave_agent_config::type_id::create("slave_cfg");
		if(!uvm_config_db#(virtual slave_if)::get(this,"","sla_if",slave_cfg.vif))
		         	`uvm_fatal("test","UNABLE TO GET CONFIG form top")
		slave_cfg.is_active=UVM_ACTIVE;
		m_cfg.slave_cfg=slave_cfg;

		endfunction

//*************************************************************************************************************//
class spi_test1 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test1)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_1 vseqs_1;

//METHODS
	extern function new(string name = "spi_test1",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test1::new(string name = "spi_test1",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test1::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=127;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=2'b01;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test1::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_1=spi_vseqs_1::type_id::create("vseqs_1");
		vseqs_1.start(envh.vseqr);
		phase.drop_objection(this);
	endtask

//*****************************************************************************************************************//

class spi_test2 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test2)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_2 vseqs_2;

//METHODS
	extern function new(string name = "spi_test2",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test2::new(string name = "spi_test2",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test2::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd127;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=2'b01;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test2::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_2=spi_vseqs_2::type_id::create("vseqs_2");
		vseqs_2.start(envh.vseqr);
		phase.drop_objection(this);
	endtask



//********************************************************************************************************************//

class spi_test3 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test3)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_3 vseqs_3;

//METHODS
	extern function new(string name = "spi_test3",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test3::new(string name = "spi_test3",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test3::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd87;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=3'b01;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd6; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test3::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_3=spi_vseqs_3::type_id::create("vseqs_3");
		vseqs_3.start(envh.vseqr);
		phase.drop_objection(this);
	endtask


//***********************************************************************************************************************//

class spi_test4 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test4)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_4 vseqs_4;

//METHODS
	extern function new(string name = "spi_test4",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test4::new(string name = "spi_test4",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test4::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd100;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=4'b01;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[14:11]=4'd6; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[41:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test4::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_4=spi_vseqs_4::type_id::create("vseqs_4");
		vseqs_4.start(envh.vseqr);
		phase.drop_objection(this);
	endtask

//*******************************************************************************************************************//
