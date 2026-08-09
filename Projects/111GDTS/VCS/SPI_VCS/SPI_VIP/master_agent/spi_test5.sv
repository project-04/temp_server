class spi_test5 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test5)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_1 vseqs_1;

//METHODS
	extern function new(string name = "spi_test1",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test5::new(string name = "spi_test5",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test5::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=10;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=2'b10;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test5::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_1=spi_vseqs_1::type_id::create("vseqs_1");
		vseqs_1.start(envh.vseqr);
		phase.drop_objection(this);
	endtask

//*****************************************************************************************************************//

class spi_test6 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test6)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_1 vseqs_1;

//METHODS
	extern function new(string name = "spi_test6",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test6::new(string name = "spi_test6",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test6::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=10;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=2'b01;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test6::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_1=spi_vseqs_1::type_id::create("vseqs_1");
		vseqs_1.start(envh.vseqr);
		phase.drop_objection(this);
	endtask

//*****************************************************************************************************************//



class spi_test6 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test6)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_2 vseqs_2;

//METHODS
	extern function new(string name = "spi_test6",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test6::new(string name = "spi_test6",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test6::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd63;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=2'b10;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test6::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_2=spi_vseqs_2::type_id::create("vseqs_2");
		vseqs_2.start(envh.vseqr);
		phase.drop_objection(this);
	endtask



//********************************************************************************************************************//

class spi_test7 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test7)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_3 vseqs_3;

//METHODS
	extern function new(string name = "spi_test7",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test7::new(string name = "spi_test7",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test7::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd89;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=3'b10;  //TX_NEG ==1 AND RX_NEG==0  
		cnt_reg[13:11]=3'd6; // ASS=1 IE=1 MSB/LSB =1
		cnt_reg[31:14]=0;    //RESERVED BIT
	
		uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",cnt_reg);

	endfunction

//RUN PHASE
	task spi_test7::run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqs_3=spi_vseqs_3::type_id::create("vseqs_3");
		vseqs_3.start(envh.vseqr);
		phase.drop_objection(this);
	endtask


//***********************************************************************************************************************//

class spi_test8 extends spi_base_test;


//FACTORY
	`uvm_component_utils(spi_test8)

//VIRTUAL SEQUENCE HANDEL
spi_vseqs_4 vseqs_4;

//METHODS
	extern function new(string name = "spi_test8",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass
//CONSTRUCTOR
	function spi_test8::new(string name = "spi_test8",uvm_component parent);
		super.new(name,parent);
	endfunction

//BUILD PHASE
	function void spi_test8::build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		cnt_reg[6:0]=7'd100;  //CHAR LENGHT==10
		cnt_reg[7]=0;	     //RESERVED BIT  
		cnt_reg[8]=1;	     // GO BUSY
		cnt_reg[10:9]=4'b10;  //TX_NEG ==1 AND RX_NEG==0  
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
