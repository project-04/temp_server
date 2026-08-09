class wb_sequences extends uvm_sequence#(wb_xtn);

	`uvm_object_utils(wb_sequences)
	 wb_xtn wb_xtnh;
int ctrl;
	extern function new(string name="wb_sequences");
	extern task body();
endclass

function wb_sequences:: new(string name="wb_sequences");
	super.new(name);
endfunction

task wb_sequences::body();
if(!uvm_config_db#(int)::get(null,get_full_name(),"int",ctrl))
`uvm_fatal("ctrl","unable to get the ctrl signal in wb_sequence")

		req=wb_xtn::type_id::create("req");
//repeat(4)
begin
	////////////////////Writing in to TX0/////////////////////
			start_item(req);
			req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b1;
						wb_dat_i=='b0100;};
			finish_item(req);
	/////////////////Writing in to TX1 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h04;
                                                wb_we_i==1'b1;
                                                wb_dat_i=='b1100;};
                        finish_item(req);
	/////////////////Writing in to TX2 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h08;
                                                wb_we_i==1'b1;
                                                wb_dat_i=='b1111;};
                        finish_item(req);
	/////////////////Writing in to TX3 ///////////////////////	

			start_item(req);
                        req.randomize() with {wb_adr_i=='h0c;
                                                wb_we_i==1'b1;
                                                wb_dat_i=='b01001;};
                        finish_item(req);

	/////////////////Writing in to DIVIDER ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h14;
                                                wb_we_i==1'b1;
                                                wb_dat_i[15:0]=='b00010;wb_dat_i[31:16]=='h0000;} ;
                        finish_item(req);
	
	/////////////////Writing in to SS ///////////////////////

			 start_item(req);
                        req.randomize() with {wb_adr_i=='h18;
                                                wb_we_i==1'b1;
                                                wb_dat_i[7:0]=='b00000001;wb_dat_i[31:8]=='h000000;};
                        finish_item(req);

	/////////////////Writing in to CTRL ///////////////////////
	

	
			start_item(req);
                        req.randomize() with {wb_adr_i=='h10;
                                                wb_we_i==1'b1;
							wb_dat_i==ctrl;};
                       finish_item(req);

	start_item(req);
				req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b0;};
			finish_item(req);
		
			start_item(req);
				req.randomize() with {wb_adr_i=='h04;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h08;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h0C;
						wb_we_i==1'b0;};
			finish_item(req);


end
endtask

///////////////////////////////////////////////////////////////////////wb_seq3/////////////////////////////////////////////////

class wb_seq1 extends wb_sequences;
int ctrl1;
	`uvm_object_utils(wb_seq1)
	extern function new(string name="wb_seq1");
	extern task body();
endclass


function wb_seq1:: new(string name="wb_seq1");
	super.new(name);
endfunction

task wb_seq1::body();
if(!uvm_config_db#(int)::get(null,get_full_name(),"ctrl1",ctrl1))
`uvm_fatal("ctrl1","unable to get the ctrl signal in wb_sequence=1111111")

begin	
		req=wb_xtn::type_id::create("req");
////////////////////Writing in to TX0/////////////////////
			start_item(req);
			req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b1;
						wb_dat_i==32'hab118;};
			finish_item(req);
	/////////////////Writing in to TX1 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h04;
                                                wb_we_i==1'b1;
                                                wb_dat_i=='b1100;};
                        finish_item(req);
	/////////////////Writing in to TX2 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h08;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'ha1001;};
                        finish_item(req);
	/////////////////Writing in to TX3 ///////////////////////	

			start_item(req);
                        req.randomize() with {wb_adr_i=='h0c;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'hac311;};
                        finish_item(req);

	/////////////////Writing in to DIVIDER ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h14;
                                                wb_we_i==1'b1;
                                                wb_dat_i[15:0]=='b0111;wb_dat_i[31:16]=='h0000;} ;
                        finish_item(req);
	
	/////////////////Writing in to SS ///////////////////////

			 start_item(req);
                        req.randomize() with {wb_adr_i=='h18;
                                                wb_we_i==1'b1;
                                                wb_dat_i[7:0]=='b01000000;wb_dat_i[31:8]=='h000000;};
                        finish_item(req);

	/////////////////Writing in to CTRL ///////////////////////
	

		
			start_item(req);
                        req.randomize() with {wb_adr_i=='h10;
                                                wb_we_i==1'b1;
							wb_dat_i==ctrl1;};
                       finish_item(req);

			
			start_item(req);
				req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b0;};
			finish_item(req);
		
			start_item(req);
				req.randomize() with {wb_adr_i=='h04;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h08;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h0C;
						wb_we_i==1'b0;};
			finish_item(req);



end
 `uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW) 
endtask


///////////////////////////////////////////////////////////////////////wb_seq3/////////////////////////////////////////////////
class wb_seq2 extends wb_seq1;
int ctrl2;
	`uvm_object_utils(wb_seq2)
	extern function new(string name="wb_seq2");
	extern task body();
endclass


function wb_seq2:: new(string name="wb_seq2");
	super.new(name);
endfunction

task wb_seq2::body();
if(!uvm_config_db#(int)::get(null,get_full_name(),"ctrl",ctrl2))
`uvm_fatal("ctrl2","unable to get the ctrl signal in wb_sequence 222222222222")

begin	
		req=wb_xtn::type_id::create("req");
////////////////////Writing in to TX0/////////////////////
			start_item(req);
			req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b1;
						wb_dat_i==32'hab118;};
			finish_item(req);
	/////////////////Writing in to TX1 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h04;
                                                wb_we_i==1'b1;
                                                wb_dat_i=='b1100;};
                        finish_item(req);
	/////////////////Writing in to TX2 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h08;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'ha1001;};
                        finish_item(req);
	/////////////////Writing in to TX3 ///////////////////////	

			start_item(req);
                        req.randomize() with {wb_adr_i=='h0c;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'hac311;};
                        finish_item(req);

	/////////////////Writing in to DIVIDER ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h14;
                                                wb_we_i==1'b1;
                                                wb_dat_i[15:0]=='b0100;wb_dat_i[31:16]=='h0000;} ;
                        finish_item(req);
	
	/////////////////Writing in to SS ///////////////////////

			 start_item(req);
                        req.randomize() with {wb_adr_i=='h18;
                                                wb_we_i==1'b1;
                                                wb_dat_i[7:0]=='b0100000;wb_dat_i[31:8]=='h000000;};
                        finish_item(req);

	/////////////////Writing in to CTRL ///////////////////////
	

		
			start_item(req);
                        req.randomize() with {wb_adr_i=='h10;
                                                wb_we_i==1'b1;
							wb_dat_i==ctrl2;};
                       finish_item(req);

			
			start_item(req);
				req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b0;};
			finish_item(req);
		
			start_item(req);
				req.randomize() with {wb_adr_i=='h04;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h08;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h0C;
						wb_we_i==1'b0;};
			finish_item(req);



end
 `uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW) 
endtask


///////////////////////////////////////////////////////////////////////////////////seq4////////////////////////////////

class wb_seq3 extends wb_seq2;
int ctrl3;
	`uvm_object_utils(wb_seq3)
	extern function new(string name="wb_seq3");
	extern task body();
endclass


function wb_seq3:: new(string name="wb_seq3");
	super.new(name);
endfunction

task wb_seq3::body();
if(!uvm_config_db#(int)::get(null,get_full_name(),"ctrl",ctrl3))
`uvm_fatal("ctrl3","unable to get the ctrl signal in wb_sequence=333333333333333333")

begin	
		req=wb_xtn::type_id::create("req");
////////////////////Writing in to TX0/////////////////////
			start_item(req);
			req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b1;
						wb_dat_i==32'h123456;};
			finish_item(req);
	/////////////////Writing in to TX1 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h04;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'habcd;};
                        finish_item(req);
	/////////////////Writing in to TX2 ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h08;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'haabb;};
                        finish_item(req);
	/////////////////Writing in to TX3 ///////////////////////	

			start_item(req);
                        req.randomize() with {wb_adr_i=='h0c;
                                                wb_we_i==1'b1;
                                                wb_dat_i==32'hccdd;};
                        finish_item(req);

	/////////////////Writing in to DIVIDER ///////////////////////
			start_item(req);
                        req.randomize() with {wb_adr_i=='h14;
                                                wb_we_i==1'b1;
                                                wb_dat_i[15:0]=='b0100;wb_dat_i[31:16]=='h0000;} ;
                        finish_item(req);
	
	/////////////////Writing in to SS ///////////////////////

			 start_item(req);
                        req.randomize() with {wb_adr_i=='h18;
                                                wb_we_i==1'b1;
                                                wb_dat_i[7:0]=='b0100000;wb_dat_i[31:8]=='h000000;};
                        finish_item(req);

	/////////////////Writing in to CTRL ///////////////////////
	

		
			start_item(req);
                        req.randomize() with {wb_adr_i=='h10;
                                                wb_we_i==1'b1;
							wb_dat_i==ctrl3;};
                       finish_item(req);

			
			start_item(req);
				req.randomize() with {wb_adr_i=='h00;
						wb_we_i==1'b0;};
			finish_item(req);
		
			start_item(req);
				req.randomize() with {wb_adr_i=='h04;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h08;
						wb_we_i==1'b0;};
			finish_item(req);

			start_item(req);
				req.randomize() with {wb_adr_i=='h0C;
						wb_we_i==1'b0;};
			finish_item(req);



end
 `uvm_info("WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW) 
endtask
