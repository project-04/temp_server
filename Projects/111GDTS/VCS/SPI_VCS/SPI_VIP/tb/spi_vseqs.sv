class spi_vseqs extends uvm_sequence#(uvm_sequence_item);

//FACTORY
	`uvm_object_utils(spi_vseqs)


//VIRTUAL SEQUENCER HANDEL
	spi_vseqr v_seqr;

//SEQUENCERS HANDEL
	master_sequencer m_seqr;
	slave_sequencer  s_seqr;

//SEQUENCES HANDEL


//CONFIG HANDEL
spi_env_config m_cfg;

//METHODS
	extern function new(string name ="spi_vseqs");
	extern task body();

endclass

//CONSTRUCTOR
	function spi_vseqs::new(string name = "spi_vseqs");
		super.new(name);
	endfunction

//BODY
	task spi_vseqs::body();
	
		if(!uvm_config_db#(spi_env_config)::get(null,get_full_name,"spi_env_config",m_cfg))
			`uvm_fatal("CONFIG","unable to get config ")


		if(!$cast(v_seqr,m_sequencer))
			`uvm_fatal("VIRTUAL SEQUENCE","$CAST FAILED")

		if(m_cfg.has_master_agent)
			m_seqr=v_seqr.m_seqr;
		if(m_cfg.has_slave_agent);
			s_seqr=v_seqr.s_seqr;
	endtask

//*****************************************************************************************************************//

class spi_vseqs_1 extends spi_vseqs;

//FACTORY
	`uvm_object_utils(spi_vseqs_1)

//SEQUENCES HANDEL
master_seqs_1 mseqs1;
slave_seqs_1  sseqs1;

master_seqs_2 mseqs2;

//read sequenc
master_read_seqs_1 rseqs1;

//METHODS
	extern function new(string name ="spi_vseqs_1");
	extern task body();

endclass

//CONSTRUCTOR
	function spi_vseqs_1::new(string name = "spi_vseqs_1");
		super.new(name);
	endfunction

//BODY
	task spi_vseqs_1::body();
		super.body();
		mseqs1=master_seqs_1::type_id::create("mseqs1");
		sseqs1=slave_seqs_1::type_id::create("sseqs1");	
		rseqs1=master_read_seqs_1::type_id::create("rseqs1");
		$display("here");
		mseqs1.start(m_seqr);	
		sseqs1.start(s_seqr);
		rseqs1.start(m_seqr);
	endtask



//****************************************************************************************************************//

class spi_vseqs_2 extends spi_vseqs;

//FACTORY
	`uvm_object_utils(spi_vseqs_2)

//SEQUENCES HANDEL
master_seqs_2 mseqs2;
slave_seqs_1  sseqs1;


//read sequenc
master_read_seqs_2 rseqs2;

//METHODS
	extern function new(string name ="spi_vseqs_2");
	extern task body();

endclass

//CONSTRUCTOR
	function spi_vseqs_2::new(string name = "spi_vseqs_2");
		super.new(name);
	endfunction

//BODY
	task spi_vseqs_2::body();
		super.body();
		mseqs2=master_seqs_2::type_id::create("mseqs2");
		sseqs1=slave_seqs_1::type_id::create("sseqs1");	
		rseqs2=master_read_seqs_2::type_id::create("rseqs2");
		$display("here");
		mseqs2.start(m_seqr);	
		sseqs1.start(s_seqr);
		rseqs2.start(m_seqr);
	endtask

//********************************************************************************************************************//


class spi_vseqs_3 extends spi_vseqs;

//FACTORY
	`uvm_object_utils(spi_vseqs_3)

//SEQUENCES HANDEL
master_seqs_3 mseqs3;
slave_seqs_1  sseqs1;


//read sequenc
master_read_seqs_3 rseqs3;

//METHODS
	extern function new(string name ="spi_vseqs_3");
	extern task body();

endclass

//CONSTRUCTOR
	function spi_vseqs_3::new(string name = "spi_vseqs_3");
		super.new(name);
	endfunction

//BODY
	task spi_vseqs_3::body();
		super.body();
		mseqs3=master_seqs_3::type_id::create("mseqs3");
		sseqs1=slave_seqs_1::type_id::create("sseqs1");	
		rseqs3=master_read_seqs_3::type_id::create("rseqs3");
		$display("here");
		mseqs3.start(m_seqr);	
		sseqs1.start(s_seqr);
		rseqs3.start(m_seqr);
	endtask

//****************************************************************************************************************//

class spi_vseqs_4 extends spi_vseqs;

//FACTORY
	`uvm_object_utils(spi_vseqs_4)

//SEQUENCES HANDEL
master_seqs_4 mseqs4;
slave_seqs_1  sseqs1;


//read sequenc
master_read_seqs_4 rseqs4;

//METHODS
	extern function new(string name ="spi_vseqs_4");
	extern task body();

endclass

//CONSTRUCTOR
	function spi_vseqs_4::new(string name = "spi_vseqs_4");
		super.new(name);
	endfunction

//BODY
	task spi_vseqs_4::body();
		super.body();
		mseqs4=master_seqs_4::type_id::create("mseqs4");
		sseqs1=slave_seqs_1::type_id::create("sseqs1");	
		rseqs4=master_read_seqs_4::type_id::create("rseqs4");
		$display("here");
		mseqs4.start(m_seqr);	
		sseqs1.start(s_seqr);
		rseqs4.start(m_seqr);
	endtask

