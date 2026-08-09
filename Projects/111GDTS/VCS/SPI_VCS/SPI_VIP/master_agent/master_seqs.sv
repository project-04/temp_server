class master_seqs extends uvm_sequence#(master_xtn);

//FACTORY
	`uvm_object_utils(master_seqs);

//DATA MEMBERS
	bit[31:0]cnt_reg;

//METHODS
	extern function new(string name = "master_seqs");
	extern task body();
endclass


//CONSTRUCTOR
	function master_seqs::new(string name= "master_seqs");
		super.new(name);
	endfunction

//BODY
	task master_seqs::body();
			if(!uvm_config_db#(bit[31:0])::get(null,get_full_name,"bit[31:0]",cnt_reg))
				`uvm_fatal("MASTER_sequence","UNABLE TO GET CONFIG")


	endtask
//***********************************************************************************************************//


class master_seqs_1 extends master_seqs;
//FACTORY
	`uvm_object_utils(master_seqs_1);

//DATA MEMBERS


//METHODS
	extern function new(string name = "master_seqs_1");
	extern task body();
endclass


//CONSTRUCTOR
	function master_seqs_1::new(string name= "master_seqs_1");
		super.new(name);
	endfunction

//BODY
	task master_seqs_1::body();
 	
	super.body;

       	  //WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h0;we_i==1'b1;dat_i%2==1;});
		finish_item(req);

	  //WRITING IN SLAVE REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h18;we_i==1'b1;dat_i==32'b00000001;});
		finish_item(req);


	  //WRITING IN DIVIDER REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h14;we_i==1'b1;dat_i==32'd1;});
		finish_item(req);

	  //WRITING IN CONTROL REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
        	assert(req.randomize() with {adr_i==5'h10;we_i==1'b1;dat_i==cnt_reg;});
		finish_item(req);


 
	endtask

//*********************************************************************************************************************************//


class master_seqs_2 extends master_seqs;
//FACTORY
	`uvm_object_utils(master_seqs_2);

//DATA MEMBERS


//METHODS
	extern function new(string name = "master_seqs_2");
	extern task body();
endclass


//CONSTRUCTOR
	function master_seqs_2::new(string name= "master_seqs_2");
		super.new(name);
	endfunction

//BODY
	task master_seqs_2::body();
 	super.body();


       	  //WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h0;we_i==1'b1;});
		finish_item(req);

	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h4;we_i==1'b1;});
		finish_item(req);


	  //WRITING IN SLAVE REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h18;we_i==1'b1;dat_i==32'b00000010;});
		finish_item(req);


	  //WRITING IN DIVIDER REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h14;we_i==1'b1;dat_i==32'd1;});
		finish_item(req);

	  //WRITING IN CONTROL REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
        	assert(req.randomize() with {adr_i==5'h10;we_i==1'b1;dat_i==cnt_reg;});
		finish_item(req);

	endtask

//******************************************************************************************************************************************//

class master_seqs_3 extends master_seqs;
//FACTORY
	`uvm_object_utils(master_seqs_3);

//DATA MEMBERS


//METHODS
	extern function new(string name = "master_seqs_3");
	extern task body();
endclass


//CONSTRUCTOR
	function master_seqs_3::new(string name= "master_seqs_3");
		super.new(name);
	endfunction

//BODY
	task master_seqs_3::body();
 	
	super.body();

       	  //WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h0;we_i==1'b1;});
		finish_item(req);

	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h4;we_i==1'b1;});
		finish_item(req);
		$display("INSIDE SEQUENCEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);

		assert(req.randomize() with {adr_i==5'h8;we_i==1'b1;});
		finish_item(req);


	  //WRITING IN SLAVE REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h18;we_i==1'b1;dat_i==32'b00000100;});
		finish_item(req);


	  //WRITING IN DIVIDER REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h14;we_i==1'b1;dat_i==32'd1;});
		finish_item(req);

	  //WRITING IN CONTROL REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
        	assert(req.randomize() with {adr_i==5'h10;we_i==1'b1;dat_i==cnt_reg;});
		finish_item(req);

	endtask

//****************************************************************************************************************************************************//

class master_seqs_4 extends master_seqs;
//FACTORY
	`uvm_object_utils(master_seqs_4);

//DATA MEMBERS


//METHODS
	extern function new(string name = "master_seqs_4");
	extern task body();
endclass


//CONSTRUCTOR
	function master_seqs_4::new(string name= "master_seqs_4");
		super.new(name);
	endfunction

//BODY
	task master_seqs_4::body();
 	
	super.body();

       	  //WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h0;we_i==1'b1;});
		finish_item(req);

	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h4;we_i==1'b1;});
		finish_item(req);

	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h8;we_i==1'b1;});
		finish_item(req);

	//WRITING IN TX REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'hc;we_i==1'b1;});
		finish_item(req);


	  //WRITING IN SLAVE REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h18;we_i==1'b1;dat_i==32'b00001000;});
		finish_item(req);


	  //WRITING IN DIVIDER REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {adr_i==5'h14;we_i==1'b1;dat_i==32'd4;});
		finish_item(req);

	  //WRITING IN CONTROL REGISTER
		req=master_xtn::type_id::create("req");
		start_item(req);
        		assert(req.randomize() with {adr_i==5'h10;we_i==1'b1;dat_i==cnt_reg;});
		finish_item(req);

	endtask

//*************************************************************************************************************************************************//
