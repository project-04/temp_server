class axi_virt_sequence extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(axi_virt_sequence)

	// Properties
	axi_env_config m_cfg;

	axi_virtual_sequencer v_seqrh;
	
	axi_mast_sequencer mast_seqrh[];
	axi_slv_sequencer slv_seqrh[];

	//Methods
	extern function new(string name="axi_virt_sequence");
	extern task body();

endclass

function axi_virt_sequence :: new(string name ="axi_virt_sequence");
	super.new(name);
endfunction

task axi_virt_sequence :: body();
	
	if(!uvm_config_db #(axi_env_config)::get(null,get_full_name(), "axi_env_config", m_cfg))
		`uvm_fatal("AXI_VIRTUAL_SEQUENCE", "Cannot get m_cfg from uvm_config_db. Have you set it?")

	mast_seqrh = new[m_cfg.no_of_mast_agt];
	slv_seqrh = new[m_cfg.no_of_slv_agt];

	assert($cast(v_seqrh, m_sequencer))
		else
		`uvm_error("AXI_VIRTUAL_SEQUENCE", "Error in cast of virtual sequencer")

	foreach(mast_seqrh[i])
		mast_seqrh[i] = v_seqrh.mast_seqrh[i];
	foreach(slv_seqrh[i]) 
		slv_seqrh[i] = v_seqrh.slv_seqrh[i];

endtask

// ***********************************************************************************************//

class axi_first_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_first_seq)

	// Properties
	slv_first_seq slv_seqh0;
	mast_first_seq mast_seqh0;

	bit[1:0] read_addr;
	bit[1:0] write_addr;

	// Methods
	extern function new(string name="axi_first_seq");
	extern task body();
	
endclass

function axi_first_seq :: new(string name ="axi_first_seq");
	super.new(name);
endfunction

task axi_first_seq :: body();
	super.body();
	
		mast_seqh0 = mast_first_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_first_seq :: type_id :: create("slv_seqh0");

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
			`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
			`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")
	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
			
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork            
                                      if((read_addr==0)||(write_addr==0))
					slv_seqh0.start(slv_seqrh[0]);
                                      if((read_addr==1)||(write_addr==1))
					slv_seqh0.start(slv_seqrh[1]);
                                      if((read_addr==2)||(write_addr==2))
					slv_seqh0.start(slv_seqrh[2]);
                                      if((read_addr==3)||(write_addr==3))
					slv_seqh0.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask

// ***********************************************************************************************//

class axi_second_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_second_seq)

	// Properties
	slv_first_seq slv_seqh0;
	mast_first_seq mast_seqh0;
	slv_first_seq slv_seqh1;
	slv_first_seq slv_seqh2;
	slv_first_seq slv_seqh3;

	bit[1:0] read_addr;
	bit[1:0] write_addr;



	// Methods
	extern function new(string name="axi_second_seq");
	extern task body();
	
endclass

function axi_second_seq :: new(string name ="axi_second_seq");
	super.new(name);
endfunction

task axi_second_seq :: body();
	super.body();

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
			`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
			`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")


	
		mast_seqh0 = mast_first_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_first_seq :: type_id :: create("slv_seqh0");
		slv_seqh1 = slv_first_seq :: type_id :: create("slv_seqh1");
		slv_seqh2 = slv_first_seq :: type_id :: create("slv_seqh2");
		slv_seqh3 = slv_first_seq :: type_id :: create("slv_seqh3");

	
		
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
			
			join
		end	
	end
	
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				if((read_addr==0)||(write_addr==0))
					slv_seqh0.start(slv_seqrh[0]);

				if((read_addr==1)||(write_addr==1))
					slv_seqh1.start(slv_seqrh[1]);

				if((read_addr==2)||(write_addr==2))
					slv_seqh2.start(slv_seqrh[2]);

				if((read_addr==3)||(write_addr==3))
					slv_seqh3.start(slv_seqrh[3]);

			join
		end
	end
	
	join


endtask


// ***********************************************************************************************//

class axi_third_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_third_seq)

	// Properties
	slv_second_seq slv_seqh0;
	mast_second_seq mast_seqh0;
	slv_second_seq slv_seqh1;
	mast_second_seq mast_seqh1;
	slv_second_seq slv_seqh2;
	mast_second_seq mast_seqh2;
	slv_second_seq slv_seqh3;
	mast_second_seq mast_seqh3;

	bit[1:0] read_addr;
	bit[1:0] write_addr;

	// Methods
	extern function new(string name="axi_third_seq");
	extern task body();
	
endclass

function axi_third_seq :: new(string name ="axi_third_seq");
	super.new(name);
endfunction

task axi_third_seq :: body();
	super.body();
	
		
		mast_seqh0 = mast_second_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_second_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_second_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_second_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_second_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_second_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_second_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_second_seq :: type_id :: create("slv_seqh3");

	
		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
			`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
			`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")

	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				if((read_addr==0)||(write_addr==0))
					slv_seqh0.start(slv_seqrh[0]);
				if((read_addr==1)||(write_addr==1))
					slv_seqh1.start(slv_seqrh[1]);
				if((read_addr==2)||(write_addr==2))
					slv_seqh2.start(slv_seqrh[2]);
				if((read_addr==3)||(write_addr==3))
					slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask



// ***********************************************************************************************//

class axi_fourth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_fourth_seq)

	// Properties
	slv_third_seq slv_seqh0;
	mast_third_seq mast_seqh0;
	slv_fourth_seq slv_seqh1;
	mast_fourth_seq mast_seqh1;
	slv_fifth_seq slv_seqh2;
	mast_fifth_seq mast_seqh2;
	slv_sixth_seq slv_seqh3;
	mast_sixth_seq mast_seqh3;


	// Methods
	extern function new(string name="axi_fourth_seq");
	extern task body();
	
endclass

function axi_fourth_seq :: new(string name ="axi_fourth_seq");
	super.new(name);
endfunction

task axi_fourth_seq :: body();
	super.body();
	
		mast_seqh0 = mast_third_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_third_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_fourth_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_fourth_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_fifth_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_fifth_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_sixth_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_sixth_seq :: type_id :: create("slv_seqh3");

	
	fork
	begin
		if(m_cfg.has_mast_agt)
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				slv_seqh0.start(slv_seqrh[0]);
				slv_seqh1.start(slv_seqrh[1]);
				slv_seqh2.start(slv_seqrh[2]);
				slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask



// ***********************************************************************************************//

class axi_fifth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_fifth_seq)

	// Properties
	slv_sixth_seq slv_seqh0;
	mast_sixth_seq mast_seqh0;
	slv_fifth_seq slv_seqh1;
	mast_fifth_seq mast_seqh1;
	slv_fourth_seq slv_seqh2;
	mast_fourth_seq mast_seqh2;
	slv_third_seq slv_seqh3;
	mast_third_seq mast_seqh3;


	// Methods
	extern function new(string name="axi_fifth_seq");
	extern task body();
	
endclass

function axi_fifth_seq :: new(string name ="axi_fifth_seq");
	super.new(name);
endfunction

task axi_fifth_seq :: body();
	super.body();
	
		mast_seqh0 = mast_sixth_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_sixth_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_fifth_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_fifth_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_fourth_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_fourth_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_third_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_third_seq :: type_id :: create("slv_seqh3");


	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				slv_seqh0.start(slv_seqrh[0]);
				slv_seqh1.start(slv_seqrh[1]);
				slv_seqh2.start(slv_seqrh[2]);
				slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask



// ***********************************************************************************************//

class axi_sixth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_sixth_seq)

	// Properties
	slv_seventh_seq slv_seqh0;
	mast_seventh_seq mast_seqh0;
	slv_thirteenth_seq slv_seqh1;
	mast_seventh_seq mast_seqh1;


	mast_thirteenth_seq mast_seqh2;
	mast_thirteenth_seq mast_seqh3;



	// Methods
	extern function new(string name="axi_sixth_seq");
	extern task body();
	
endclass

function axi_sixth_seq :: new(string name ="axi_sixth_seq");
	super.new(name);
endfunction

task axi_sixth_seq :: body();
	super.body();
		
		mast_seqh0 = mast_seventh_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_seventh_seq :: type_id :: create("slv_seqh0");
		
		mast_seqh1 = mast_seventh_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_thirteenth_seq :: type_id :: create("slv_seqh1");
		
		mast_seqh2 = mast_thirteenth_seq :: type_id :: create("mast_seqh2");
		
		mast_seqh3 = mast_thirteenth_seq :: type_id :: create("mast_seqh3");


	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				slv_seqh0.start(slv_seqrh[0]);
				slv_seqh1.start(slv_seqrh[1]);
			join
		end
	end
	join


endtask

// ***********************************************************************************************//

class axi_seventh_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_seventh_seq)

	// Properties
	slv_second_seq slv_seqh0;
	mast_second_seq mast_seqh0;
	slv_second_seq slv_seqh1;
	mast_second_seq mast_seqh1;
	slv_second_seq slv_seqh2;
	mast_second_seq mast_seqh2;
	slv_second_seq slv_seqh3;
	mast_second_seq mast_seqh3;

	bit[1:0] read_addr;
	bit[1:0] write_addr;


	// Methods
	extern function new(string name="axi_seventh_seq");
	extern task body();
	
endclass

function axi_seventh_seq :: new(string name ="axi_seventh_seq");
	super.new(name);
endfunction

task axi_seventh_seq :: body();
	super.body();
	
		mast_seqh0 = mast_second_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_second_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_second_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_second_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_second_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_second_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_second_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_second_seq :: type_id :: create("slv_seqh3");

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
			`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
			`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")
	

	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				if((read_addr==0)||(write_addr==0))
					slv_seqh0.start(slv_seqrh[0]);
				if((read_addr==1)||(write_addr==1))
					slv_seqh1.start(slv_seqrh[1]);
				if((read_addr==2)||(write_addr==2))
					slv_seqh2.start(slv_seqrh[2]);
				if((read_addr==3)||(write_addr==3))
					slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask


// ***********************************************************************************************//

class axi_eighth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_eighth_seq)

	// Properties
	slv_eighth_seq slv_seqh0;
	mast_eighth_seq mast_seqh0;
	slv_eighth_seq slv_seqh1;
	mast_eighth_seq mast_seqh1;
	slv_ninth_seq slv_seqh2;
	mast_ninth_seq mast_seqh2;
	slv_ninth_seq slv_seqh3;
	mast_ninth_seq mast_seqh3;




	// Methods
	extern function new(string name="axi_eighth_seq");
	extern task body();
	
endclass

function axi_eighth_seq :: new(string name ="axi_eighth_seq");
	super.new(name);
endfunction

task axi_eighth_seq :: body();
	super.body();
	
		mast_seqh0 = mast_eighth_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_eighth_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_eighth_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_eighth_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_ninth_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_ninth_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_ninth_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_ninth_seq :: type_id :: create("slv_seqh3");


	
	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				slv_seqh0.start(slv_seqrh[3]);
				slv_seqh3.start(slv_seqrh[0]);
			join
		end
	end
	join


endtask

// ***********************************************************************************************//

class axi_ninth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_ninth_seq)

	// Properties
	slv_tenth_seq slv_seqh0;
	mast_tenth_seq mast_seqh0;
	slv_tenth_seq slv_seqh1;
	mast_tenth_seq mast_seqh1;

	slv_eleventh_seq slv_seqh2;
	mast_eleventh_seq mast_seqh2;
	slv_eleventh_seq slv_seqh3;
	mast_eleventh_seq mast_seqh3;



	// Methods
	extern function new(string name="axi_ninth_seq");
	extern task body();
	
endclass

function axi_ninth_seq :: new(string name ="axi_ninth_seq");
	super.new(name);
endfunction

task axi_ninth_seq :: body();
	super.body();
	
		mast_seqh0 = mast_tenth_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_tenth_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_tenth_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_tenth_seq :: type_id :: create("slv_seqh1");	
		mast_seqh2 = mast_eleventh_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_eleventh_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_eleventh_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_eleventh_seq :: type_id :: create("slv_seqh3");


	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				slv_seqh0.start(slv_seqrh[0]);
				slv_seqh1.start(slv_seqrh[1]);
				slv_seqh2.start(slv_seqrh[2]);
				slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask

// ***********************************************************************************************//

class axi_tenth_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_tenth_seq)

	// Properties
	slv_second_seq slv_seqh0;
	mast_second_seq mast_seqh0;
	slv_second_seq slv_seqh1;
	mast_second_seq mast_seqh1;
	slv_second_seq slv_seqh2;
	mast_second_seq mast_seqh2;
	slv_second_seq slv_seqh3;
	mast_second_seq mast_seqh3;

	bit[1:0] read_addr;
	bit[1:0] write_addr;

	// Methods
	extern function new(string name="axi_tenth_seq");
	extern task body();
	
endclass

function axi_tenth_seq :: new(string name ="axi_tenth_seq");
	super.new(name);
endfunction

task axi_tenth_seq :: body();
	super.body();
	
		
		mast_seqh0 = mast_second_seq :: type_id :: create("mast_seqh0");
		slv_seqh0 = slv_second_seq :: type_id :: create("slv_seqh0");
		mast_seqh1 = mast_second_seq :: type_id :: create("mast_seqh1");
		slv_seqh1 = slv_second_seq :: type_id :: create("slv_seqh1");
		mast_seqh2 = mast_second_seq :: type_id :: create("mast_seqh2");
		slv_seqh2 = slv_second_seq :: type_id :: create("slv_seqh2");
		mast_seqh3 = mast_second_seq :: type_id :: create("mast_seqh3");
		slv_seqh3 = slv_second_seq :: type_id :: create("slv_seqh3");

	
		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
			`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

		if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
			`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")

	
	fork
	begin
		if(m_cfg.has_mast_agt)
		begin
			fork
				mast_seqh0.start(mast_seqrh[0]);
				mast_seqh1.start(mast_seqrh[1]);
				mast_seqh2.start(mast_seqrh[2]);
				mast_seqh3.start(mast_seqrh[3]);				
			join
		end
	end
		
	begin
		if(m_cfg.has_slv_agt)
		begin
			fork
				if((read_addr==0)||(write_addr==0))
					slv_seqh0.start(slv_seqrh[0]);
				if((read_addr==1)||(write_addr==1))
					slv_seqh1.start(slv_seqrh[1]);
				if((read_addr==2)||(write_addr==2))
					slv_seqh2.start(slv_seqrh[2]);
				if((read_addr==3)||(write_addr==3))
					slv_seqh3.start(slv_seqrh[3]);
			join
		end
	end
	join


endtask

// ***********************************************************************************************//

class axi_eleventh_seq extends axi_virt_sequence;
	`uvm_object_utils(axi_eleventh_seq)

	// Properties

	bit[1:0] read_addr[];
	bit[1:0] write_addr[];

	mast_twelveth_seq mast_seqh[];

	slv_twelveth_seq slv_seqh0;
	slv_twelveth_seq slv_seqh1;
	slv_twelveth_seq slv_seqh2;
	slv_twelveth_seq slv_seqh3;


	// Methods
	extern function new(string name="axi_eleventh_seq");
	extern task body();
	
endclass

function axi_eleventh_seq :: new(string name ="axi_eleventh_seq");
	super.new(name);
endfunction

task axi_eleventh_seq :: body();
	super.body();
	
		
	read_addr = new[4];
	write_addr= new[4];

	mast_seqh= new[4];

	for(int i=0; i<4; i++)
		begin
			mast_seqh[i] = mast_twelveth_seq :: type_id :: create($sformatf("mast_seqh[%0d]", i));
		//	slv_seqh[i] = slv_twelveth_seq :: type_id :: create($sformatf("slv_seqh[%0d]", i));

		slv_seqh0 = slv_twelveth_seq :: type_id :: create("slv_seqh0");
		slv_seqh1 = slv_twelveth_seq :: type_id :: create("slv_seqh1");
		slv_seqh2 = slv_twelveth_seq :: type_id :: create("slv_seqh2");
		slv_seqh3 = slv_twelveth_seq :: type_id :: create("slv_seqh3");


			if(!uvm_config_db #(bit[1:0]) :: get(null, get_full_name(), $sformatf("read_addr[%0d]",i), read_addr[i]))
				`uvm_fatal(get_type_name(), " Cannot get read_addr from uvm_config_db. Kindly Check")

			if(!uvm_config_db #(bit[1:0]) :: get(null, get_full_name(), $sformatf("write_addr[%0d]",i), write_addr[i]))
				`uvm_fatal(get_type_name(),  "Cannot get write_addr from uvm_config_db. Kindly Check")

			
			uvm_config_db #(bit[1:0]) :: set(null, "*", "read_slave", read_addr[i]);
			uvm_config_db #(bit[1:0]):: set(null, "*", "write_slave", write_addr[i]);

			fork
				begin
					if(m_cfg.has_mast_agt)
						mast_seqh[i].start(mast_seqrh[i]);
				end
				
				begin
					if(m_cfg.has_slv_agt)
						begin
							fork
								if((read_addr[i]===2'b00)||(write_addr[i]===2'b00))
									slv_seqh0.start(slv_seqrh[0]);
								if((read_addr[i]===2'b01)||(write_addr[i]===2'b01))
									slv_seqh1.start(slv_seqrh[1]);
								if((read_addr[i]===2'b10)||(write_addr[i]===2'b10))
									slv_seqh2.start(slv_seqrh[2]);
								if((read_addr[i]===2'b11)||(write_addr[i]===2'b11))
									slv_seqh3.start(slv_seqrh[3]);
							join

						end
				end
			join

			
		end
endtask







