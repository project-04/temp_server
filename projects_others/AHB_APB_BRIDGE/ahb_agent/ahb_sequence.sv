

class ahb_base_sequence extends uvm_sequence#(ahb_trans);

	`uvm_object_utils(ahb_base_sequence)

	function new (string name = "ahb_base_sequence");
		super.new(name);
	endfunction 

endclass	






class single_sequence extends ahb_base_sequence;

	`uvm_object_utils(single_sequence)
	
	function new (string name = "single_sequence");
		super.new(name);
	endfunction 

	task body();
		repeat(10)
			begin 
				req = ahb_trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {Htrans==2; Hwrite==1; Hburst==0;});
				//req.print();
				finish_item(req);
				`uvm_info("AHB_SEQUENCE","single sequence is done",UVM_NONE);
			end
	endtask

endclass	






class inc_undefined_sequence extends ahb_base_sequence;

	`uvm_object_utils(inc_undefined_sequence)
	
	function new(string name = "inc_undefined_sequence");
		super.new(name);
	endfunction 
	
	ahb_trans t1;

	task body();
		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite == 1; Htrans == 2; Hburst == 1;});
		`uvm_info("inc_undefined_sequence","NON_SEQUENTIAL TRANSFER##", UVM_NONE);
		finish_item(req);
		
		t1 = ahb_trans::type_id::create("t1");
		t1.copy(req);
		
		$display("%0d",req.length);
		if(req.Hburst==1)
			begin 
				for(int i = 0; i < t1.length-1; i++)
					begin 
						start_item(req);
						assert(req.randomize() with { Hwrite==t1.Hwrite; Htrans==3; Hburst==t1.Hburst; Haddr==(t1.Haddr+(2**t1.Hsize));})
						`uvm_info("inc_undefined_sequence","SEQUENTIAL TRANSFER##", UVM_NONE);
						finish_item(req);
						t1.Haddr=req.Haddr;
					end
			end			
		
	endtask	
			
endclass




class inc_by_4_sequence extends ahb_base_sequence;

	`uvm_object_utils(inc_by_4_sequence)

	function new (string name = "inc_by_4_sequence");
		super.new(name);
	endfunction 

	ahb_trans t1;

	task body();
		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==3;});
		`uvm_info("inc_by_8_sequence","NON SEQUENTIAL TRANSFER##", UVM_NONE);
		finish_item(req);
		
		
		t1 = ahb_trans::type_id::create("t1");
		t1.copy(req);
		
		if(req.Hburst==3)
			begin 
				for(int i = 0; i < t1.length-1; i++)
					begin
						start_item(req);
						assert(req.randomize() with {Hwrite == t1.Hwrite; Hburst==t1.Hburst; Htrans==3; Haddr==(t1.Haddr+(2**(t1.Hsize)));});
						`uvm_info("inc_by_4_sequence","SEQUENTIAL TRANSFER##", UVM_NONE);
						finish_item(req);
						t1.Haddr=req.Haddr;
					end
			end

	endtask

endclass	









class inc_by_8_sequence extends ahb_base_sequence;

	`uvm_object_utils(inc_by_8_sequence)

	function new (string name = "inc_by_8_sequence");
		super.new(name);
	endfunction 

	ahb_trans t1;
	
	task body();
		
		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==5;});
		`uvm_info("inc_by_8_sequence","NON SEQUENTIAL TRANSFER##", UVM_NONE);
		finish_item(req);
	
		
		t1 = ahb_trans::type_id::create("t1");
		t1.copy(req);

		if(req.Hburst==5)
			begin 
				for(int i = 0; i < t1.length-1 ; i++ )
					begin 
						start_item(req);
						assert(req.randomize() with {Hburst==t1.Hburst; Hwrite==t1.Hwrite; Htrans==3; Haddr==(t1.Haddr+(2**t1.Hsize));});
						`uvm_info("inc_by_8_sequence","SEQUENTIAL TRANSFER##", UVM_NONE);
						finish_item(req);
						t1.Haddr=req.Haddr;
					end	
			end

	endtask

endclass



class inc_by_16_sequence extends ahb_base_sequence;

	`uvm_object_utils(inc_by_16_sequence)

	function new (string name = "inc_by_16_sequence");
		super.new(name);
	endfunction 

	ahb_trans t1;
	

	task body();
		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==7;});
		`uvm_info("inc_by_16_sequence","NON SEQUENTIAL TRANSFER##", UVM_NONE);
		finish_item(req);

		t1 = ahb_trans::type_id::create("req");
		t1.copy(req);

		if(req.Hburst==7)
			begin 
				for(int i = 0; i < t1.length-1 ; i++)
					begin 
						start_item(req);
						assert(req.randomize() with {Hwrite==t1.Hwrite; Hburst==t1.Hburst; Htrans==3; Haddr==(t1.Haddr+(2**t1.Hsize));});
						`uvm_info("inc_by_16_sequence","SEQUENTIAL TRANSFER##", UVM_NONE);
						finish_item(req);
						t1.Haddr=req.Haddr;
					end
			end
	endtask

endclass





class wrap_4_sequence extends ahb_base_sequence;

	`uvm_object_utils(wrap_4_sequence)

	function new (string name = "wrap_4_sequence");
		super.new(name);
	endfunction 
	
	bit [31:0] b_Haddr;
	ahb_trans t1;
		
	task body();

		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==2;});
		finish_item(req);

		t1 = ahb_trans::type_id::create("t1");	
		t1.copy(req);
			
		if(req.Hburst==2)
			begin 
				if(t1.Hsize==0)
					begin 
						for(int i = 0;i < t1.length-1; i++ )
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hburst==t1.Hburst; Htrans==3; Haddr=={t1.Haddr[31:2],t1.Haddr[1:0]+2'b01};Hsize==t1.Hsize;});
								finish_item(req);
								t1.Haddr=req.Haddr; 
							end
					end
				if(t1.Hsize==1)
					begin 
						for(int i = 0;i < t1.length-1; i++ )
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hburst==t1.Hburst; Htrans==3; Haddr=={t1.Haddr[31:3],t1.Haddr[2:1]+2'b01,t1.Haddr[0]};Hsize==t1.Hsize;});
								finish_item(req);
								t1.Haddr=req.Haddr; 
								end
					end

				else if(t1.Hsize==2)
					begin 
						for(int i = 0;i < t1.length-1; i++ )
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hburst==t1.Hburst; Htrans==3; Haddr=={t1.Haddr[31:4],t1.Haddr[3:2]+2'b01,t1.Haddr[1:0]};Hsize==t1.Hsize;});
								finish_item(req);
								t1.Haddr=req.Haddr; 
							end
					end


			end
				

	endtask

endclass







class wrap_8_sequence extends ahb_base_sequence;

	`uvm_object_utils(wrap_8_sequence)

	function new (string name = "wrap_8_sequence");
		super.new(name);
	endfunction 


	ahb_trans t1;

	task body();

		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==4;});
		finish_item(req);

		t1 = ahb_trans::type_id::create("t1");
		t1.copy(req);

		if(req.Hburst==4)	
			begin 
				if(t1.Hsize==0)
					begin 
						for(int i = 0; i < t1.length-1; i++)	
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr=={t1.Haddr[31:3],t1.Haddr[2:0]+3'b001};});
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
				if(t1.Hsize==1)
					begin 
						for(int i = 0; i < t1.length-1; i++)
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr =={t1.Haddr[31:4],t1.Haddr[3:1]+3'b001,t1.Haddr[0]}; });
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
				else if(t1.Hsize==2)
					begin 
						for(int i = 0; i < t1.length-1; i++)
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr =={t1.Haddr[31:5],t1.Haddr[4:2]+3'b001,t1.Haddr[1:0]};});
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
			end	
	endtask			
				

endclass	
		





	
		
class wrap_16_sequence extends ahb_base_sequence;

	`uvm_object_utils(wrap_16_sequence)

	function new (string name = "wrap_16_sequence");
		super.new(name);
	endfunction 


	ahb_trans t1;
	longint end_address;
	longint start_address;

	task body();

		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1; Htrans==2; Hburst==6;});
		finish_item(req);

		t1 = ahb_trans::type_id::create("t1");
		t1.copy(req);
		
		if(req.Hburst==6)	
			begin 
				if(t1.Hsize==0)
					begin 
						for(int i = 0; i < t1.length-1; i++)	
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr=={t1.Haddr[31:4],t1.Haddr[3:0]+4'b001};});
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
				if(t1.Hsize==1)
					begin 
						for(int i = 0; i < t1.length-1; i++)
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr =={t1.Haddr[31:5],t1.Haddr[4:1]+4'b0001,t1.Haddr[0]}; });
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
				else if(t1.Hsize==2)
					begin 
						for(int i = 0; i < t1.length-1; i++)
							begin 
								start_item(req);
								assert(req.randomize() with {Hwrite==t1.Hwrite; Hsize==t1.Hsize; Hburst==t1.Hburst; Haddr =={t1.Haddr[31:6],t1.Haddr[5:2]+4'b0001,t1.Haddr[1:0]};});
								finish_item(req);
								t1.Haddr=req.Haddr;
							end
					end
			end	
	endtask			
				

endclass	
		








		
