/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech 
Bangalore - 560076

Webpage: 	www.maven-silicon.com
**********************************************************************************************/
// Import ram_pkg
import ram_pkg::*;
// class ram_trans_crt with randc constraints
class ram_trans_crt extends ram_trans;
     	randc bit [11:0]  rd_address;
	randc bit [11:0]  wr_address;
        constraint valid_random_wr {super.wr_address==wr_address;}
        constraint valid_random_rd {super.rd_address==rd_address;} 
endclass 
// Class ram_trans_cwt with constraint for data
class ram_trans_cwt extends ram_trans;
	randc bit [11:0]  rd_address;
	randc bit [11:0]  wr_address;

	constraint VALID_DATA {data inside {[1:10000]};}  
        constraint valid_random_wr1 {super.wr_address==wr_address;}
        constraint valid_random_rd1 {super.rd_address==rd_address;} 
endclass 

class test;


    //Instantiate virtual interface with Write BFM modport, 
				//Read BFM modport, 
				//Write monitor modport, 
				//Read monitor modport
    virtual ram_if.RD_BFM rd_if;
    virtual ram_if.WR_BFM wr_if; 
    virtual ram_if.RD_MON rdmon_if; 
    virtual ram_if.WR_MON wrmon_if;
    // Declare an handle for ram_env as env
    ram_env env;
    // Declare an handle for ram_trans_crt as crt_data_h
    ram_trans_crt crt_data_h;
    // Declare an handle for ram_trans_cwt as cwt_data_h
    ram_trans_cwt cwt_data_h;

// In function new
	// Pass the BFM and monitor interface as the arguments
	// Create the object for env and pass the arguments
	// for the virtual interfaces in new() function
function new( virtual ram_if.WR_BFM wr_if, 
			virtual ram_if.RD_BFM rd_if,
			virtual ram_if.WR_MON wrmon_if,
			virtual ram_if.RD_MON rdmon_if);
    		this.wr_if = wr_if;
		this.rd_if = rd_if;
		this.wrmon_if = wrmon_if;
		this.rdmon_if = rdmon_if;
    		env = new(wr_if,rd_if,wrmon_if,rdmon_if);
endfunction



// Task which builds the TB environment and runs the simulation
// for different tests
task build_and_run();
  begin
    	if($test$plusargs("TEST1"))
		begin
      		number_of_transactions = 40;
		env.build();
		env.run();
		$finish;
		end
	if($test$plusargs("TEST2"))
		begin
		crt_data_h=new;
		number_of_transactions = 50;
		env.build();
		env.gen.gen_trans= crt_data_h;
		env.run(); 
		$finish;
		end
	if($test$plusargs("TEST3"))
		begin
		cwt_data_h=new;
		number_of_transactions = 60;
		env.build();
		env.gen.gen_trans = cwt_data_h;
		env.run();
		$finish;
		end
  end

endtask
endclass


