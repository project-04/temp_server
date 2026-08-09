/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   ram_virtual_seqs.sv

Description		:	Virtual Sequence class for Dual Port RAM TB
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------



//------------------------------------------------------------------------------
//
// SEQUENCE: Base RAM virtual sequence - base virtual sequence with objections from which 
// all virtual sequences can be derived
//
//------------------------------------------------------------------------------

   // Extend ram_vbase_seq from uvm_sequence parameterized by uvm_sequence_item;

class ram_vbase_seq extends uvm_sequence #(uvm_sequence_item);

	
	// Factory registration
	`uvm_object_utils(ram_vbase_seq)

	// Declare handles for ram_wr_sequencer, ram_rd_sequencer and ram_virtual_sequencer
	// as wr_seqrh, rd_seqrh, vsqrh
    	ram_wr_sequencer wr_seqrh;
    	ram_rd_sequencer rd_seqrh;
    	ram_virtual_sequencer vsqrh;
    	
	// Handles for all the sequences
	ram_single_addr_wr_xtns single_wxtns;
	ram_single_addr_rd_xtns single_rxtns;

	ram_ten_wr_xtns ten_wxtns;
	ram_ten_rd_xtns ten_rxtns;

	ram_even_wr_xtns even_wxtns;
	ram_even_rd_xtns even_rxtns;

	ram_odd_wr_xtns odd_wxtns;
	ram_odd_rd_xtns odd_rxtns;


	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_vbase_seq");
	extern task body();
	
endclass : ram_vbase_seq 

//-----------------  constructor new method  -------------------//
// Add constructor 
function ram_vbase_seq::new(string name = "ram_vbase_seq");
	super.new(name);
endfunction
//-----------------  task body() method  -------------------//
task ram_vbase_seq::body();
	// Assign virtual sequencer handle(m_sequencer) to vsqrh
	// Use $cast(vsqrh, m_sequencer)
  if($cast(vsqrh, m_sequencer))
  begin
  
	// Assign the sub-sequencer handles with the sub-sequencer handles
	// of the virtual sequencer
	  wr_seqrh = vsqrh.wr_seqrh;
    rd_seqrh = vsqrh.rd_seqrh;
  end
endtask

//------------------------------------------------------------------------------
//                 single address sequence

//------------------------------------------------------------------------------
// Extend ram_single_vseq from ram_vbase_seq
class ram_single_vseq extends ram_vbase_seq;

    // Factory registration
	  `uvm_object_utils(ram_single_vseq)

     //------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_single_vseq");
	extern task body();
	
endclass : ram_single_vseq 
 
//-----------------  constructor new method  -------------------//

// Add constructor
function ram_single_vseq::new(string name = "ram_single_vseq");
	super.new(name);
endfunction

//-----------------  task body() method  -------------------//
	// call super.body();
	// create the instance of ram_single_addr_wr_xtns & ram_single_addr_rd_xtns
	//start write and read sequences on respective sequencers
task ram_single_vseq::body();
  super.body();
  single_wxtns = ram_single_addr_wr_xtns::type_id::create("single_wxtns");
  single_rxtns = ram_single_addr_rd_xtns::type_id::create("single_rxtns");
endtask

//------------------------------------------------------------------------------
//                 ten address sequence

//------------------------------------------------------------------------------
// Extend ram_ten_vseq from uvm_sequence
class ram_ten_vseq extends ram_vbase_seq;

       // Factory registration
	  `uvm_object_utils(ram_ten_vseq)
     
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_ten_vseq");
	extern task body();
endclass : ram_ten_vseq  

//-----------------  constructor new method  -------------------//

// Add constructor 
function ram_ten_vseq::new(string name = "ram_ten_vseq");
	super.new(name);
endfunction

//-----------------  task body() method  -------------------//


	// call super.body();
	// create the instance of ram_ten_wr_xtns & ram_ten_rd_xtns
	//start write and read sequences on respective sequencers
task ram_ten_vseq::body();
  super.body();
  ten_wxtns = ram_ten_wr_xtns::type_id::create("ten_wxtns");
  ten_rxtns = ram_ten_rd_xtns::type_id::create("ten_rxtns");
endtask


//------------------------------------------------------------------------------
//                 odd sequence

//------------------------------------------------------------------------------
// Extend ram_odd_vseq from ram_vbase_seq
class ram_odd_vseq extends ram_vbase_seq;

    // Factory Registration
	  `uvm_object_utils(ram_odd_vseq)

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_odd_vseq");
	extern task body();
endclass : ram_odd_vseq  

//-----------------  constructor new method  -------------------//

// Add constructor 
function ram_odd_vseq::new(string name = "ram_odd_vseq");
	super.new(name);
endfunction
//-----------------  task body() method  -------------------//



	// call super.body();
	// create the instance of ram_odd_wr_xtns & ram_odd_rd_xtns
	//start write and read sequences on respective sequencers
task ram_odd_vseq::body();
  super.body();
  odd_wxtns = ram_odd_wr_xtns::type_id::create("odd_wxtns");
  odd_rxtns = ram_odd_rd_xtns::type_id::create("odd_rxtns");
endtask





//------------------------------------------------------------------------------
//                 even sequence

//------------------------------------------------------------------------------
// Extend ram_even_vseq from ram_vbase_seq
class ram_even_vseq extends ram_vbase_seq;

    	// Factory Registration
		  `uvm_object_utils(ram_even_vseq)

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_even_vseq");
	extern task body();
endclass : ram_even_vseq  
//-----------------  constructor new method  -------------------//

// Add constructor 
function ram_even_vseq::new(string name = "ram_even_vseq");
	super.new(name);
endfunction
//-----------------  task body() method  -------------------//



	// call super.body();
	// create the instance of ram_even_wr_xtns & ram_even_rd_xtns
	//start write and read sequences on respective sequencers
task ram_even_vseq::body();
  super.body();
  even_wxtns = ram_even_wr_xtns::type_id::create("even_wxtns");
  even_rxtns = ram_even_rd_xtns::type_id::create("even_rxtns");
endtask





