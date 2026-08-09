
//-------------------- AHB BASE SEQUENCE ----------------------//
class ahb_base_seqs extends uvm_sequence #(ahb_xtn);

	`uvm_object_utils(ahb_base_seqs)
	
	extern function new(string name ="ahb_base_seqs");
endclass

//-----------------  constructor new method  -------------------//
function ahb_base_seqs::new(string name ="ahb_base_seqs");
        super.new(name);
endfunction

//------------------ AHB INCREMENT SEQUENCE ---------------------//

class ahb_incr_wr_seq extends ahb_base_seqs;

	`uvm_object_utils(ahb_incr_wr_seq)

        extern function new(string name ="ahb_incr_wr_seq");
        extern task body();
endclass

function ahb_incr_wr_seq::new(string name ="ahb_incr_wr_seq");
	super.new(name);
endfunction

task ahb_incr_wr_seq::body();

	bit [31:0] addr;
	bit [2:0] size1;
	bit [2:0] burst;
       	bit [2:0] temp_b;
        bit Write;
repeat(5)
begin
	req = ahb_xtn::type_id::create("req");
	
//NON-SEQUENTIAL
	start_item(req);
	assert(req.randomize with {req.Htrans == 2'b10;req.Hwrite==0; ((req.Hburst==3'd7)||(req.Hburst==3'd5)||(req.Hburst==3'd3)||(req.Hburst==3'd0));/*req.Hwrite==0; req.Haddr == 32'h8000_0000;*/});
	`uvm_info("INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);

        Write = req.Hwrite;
	burst = req.Hburst;
	size1 = req.Hsize;
	addr = req.Haddr;
       	temp_b = req.length;

//SEQUENTIAL
	if((req.Hburst == 3'd7) | (req.Hburst == 3'd5) | (req.Hburst == 3'd3) | (req.Hburst ==3'd0))
        begin
		for (int i=1; i < temp_b; i++) 
		begin
                       	start_item(req);
			assert(req.randomize with {req.Haddr == addr+(2**size1); req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
			`uvm_info("INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)	
                       	finish_item(req);

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
	       		Write = req.Hwrite;
		end
        end
end
//IDLE TRANSFER
	start_item(req);
	assert(req.randomize with {req.Haddr == addr; req.Htrans == 2'b00; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
	`uvm_info("INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);

endtask
	
//------------------------ UNSPECIFIED INCR SEQUENCE ------------------------//

class unspecified_incr_wr_seq extends ahb_base_seqs;

	`uvm_object_utils(unspecified_incr_wr_seq)

        extern function new(string name ="unspecified_incr_wr_seq");
        extern task body();

endclass

function unspecified_incr_wr_seq::new(string name ="unspecified_incr_wr_seq");
	super.new(name);
endfunction

task unspecified_incr_wr_seq::body();

	bit [31:0] addr;
	bit [2:0] size1;
	bit [2:0] burst;
        bit Write;
        bit [2:0] temp_b;

	req = ahb_xtn::type_id::create("req");

//NON-SEQUENTIAL
	start_item(req);
	assert(req.randomize with {req.Htrans == 2'b10;Hwrite==0;});
	`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);

        Write = req.Hwrite;
	burst = req.Hburst;
	size1 = req.Hsize;
	addr = req.Haddr;
        temp_b = req.length;

//SEQUENTIAL
       if(req.Hburst == 3'b001)
        begin
		for (int i=0; i < 17; i++) 
		begin
                	start_item(req);
			assert(req.randomize with {req.Haddr == addr+(2**size1);req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
			`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)	
                        finish_item(req);

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
		        Write = req.Hwrite;
		end
	end

//IDLE TRANSFER
	start_item(req);
	assert(req.randomize with {req.Haddr == addr; req.Htrans == 2'b00; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
	`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);
		
endtask
	
//------------------ AHB WRAP SEQUENCE ---------------------//

class ahb_wrap_wr_seq extends ahb_base_seqs;

	`uvm_object_utils(ahb_wrap_wr_seq)

	extern function new(string name ="ahb_wrap_wr_seq");
	extern task body();

endclass

function ahb_wrap_wr_seq::new(string name ="ahb_wrap_wr_seq");
	super.new(name);
endfunction

task ahb_wrap_wr_seq::body();

	bit [31:0] addr;
	bit [2:0] size1;
	bit [2:0] burst;
        bit Write;
        bit [2:0] temp_b;

	req = ahb_xtn::type_id::create("req");
repeat(5)
begin
//NON-SEQUENTIAL	
	start_item(req);
	assert(req.randomize with {req.Htrans == 2'b00; ((req.Hburst == 3'd2) || (req.Hburst == 3'd4) || (req.Hburst == 3'd6));/* req.Haddr == 32'h8000_0002;*/})
	`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);

        Write = req.Hwrite;
	burst = req.Hburst;
	size1 = req.Hsize;
	addr = req.Haddr;
        temp_b = req.length;

//SEQUENTIAL
	//if(req.Hburst == 3'd2 || req.Hburst == 3'd4 || req.Hburst == 3'd6)
	begin
        if(req.Hsize == 0) 
        begin
		for (int i=1; i < 17; i++) 
		begin
			
                	start_item(req);
			if(req.Hburst == 3'b010)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:2],(addr[1:0]+1'b1)};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b100)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:3],(addr[2:0]+1'b1)};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b110)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:4],(addr[3:0]+1'b1)};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
				
			`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)	
                        finish_item(req);

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
		        Write = req.Hwrite;
		end
	end

	else if(req.Hsize == 1) 
	begin
		for (int i=1; i < 17; i++) 
		begin
                	start_item(req);
			if(req.Hburst == 3'b010)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:3],addr[2:1]+1'b1,addr[0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b100)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:4],addr[3:1]+1'b1,addr[0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b110)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:5],addr[4:1]+1'b1,addr[0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
				
			`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
                        finish_item(req);

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
		        Write = req.Hwrite;
		end
	end
	
	else if(req.Hsize == 2) 
        begin
		for (int i=1; i < 17; i++) 
		begin
                	start_item(req);
			if(req.Hburst == 3'b010)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:4],addr[3:2]+1'b1,addr[1:0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b100)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:5],addr[4:2]+1'b1,addr[1:0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
			else if(req.Hburst == 3'b110)
				begin
				assert(req.randomize with {req.Haddr == {addr[31:6],addr[5:2]+1'b1,addr[1:0]};req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
				end
				
			`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
                        finish_item(req);

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
		        Write = req.Hwrite;
		end
	end
	end	

//IDLE TRANSFER
	start_item(req);
	assert(req.randomize with {req.Haddr == addr; req.Htrans == 2'b00; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
	`uvm_info("UNSPECIFIED_INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);
end
endtask
/*

class ahb_seqs extends uvm_sequence#(ahb_xtn);

	`uvm_object_utils(ahb_seqs)
	
	extern function new(string name = "ahb_seqs");
	
endclass

function ahb_seqs::new(string name = "ahb_seqs");

	super.new(name);
	
endfunction

class ahb_incr_wr_seq extends ahb_seqs;

	`uvm_object_utils(ahb_incr_wr_seq)
	
	bit [2:0] burst;
	bit [2:0] size1;
	bit [31:0] addr;
	bit Write;
	bit [2:0] temp_burst;
	
	extern function new(string name = "ahb_incr_wr_seq");
	extern task body();
	extern task call1();
	extern task call2();
	extern task call3();
	
endclass

function ahb_incr_wr_seq::new(string name = "ahb_incr_wr_seq");

	super.new(name);
	
endfunction

task ahb_incr_wr_seq::body();

	req = ahb_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize with {req.Htrans==2'b10; ((req.Hburst==3'b000)||(req.Hburst==3'b001)||(req.Hburst==3'b011)||(req.Hburst==3'b101)||(req.Hburst==3'b111));});
		`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);
	
	Write = req.Hwrite;
	size1 = req.Hsize;
	burst = req.Hburst;
	temp_burst = req.length;
	addr = req.Haddr;
	
	if(req.Hburst == 3'b000 | req.Hburst == 3'b001 | req.Hburst == 3'b011 | req.Hburst == 3'b101 | req.Hburst == 3'b111)
		begin
	
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr==addr+2**size1);req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
	
	else
		begin
		
			if(req.Hsize == 0)
				call1();
		
			else if(req.Hsize == 1)
				call2();
				
			else if(req.Hsize == 2)
				call3();
		end
		
	start_item(req);
	assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;req.Htrans==2'b00;});
		`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);

endtask

task ahb_incr_wr_seq::call1();

	if(req.Hburst == 3'b010)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:2],addr[1:0]+1'b1});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
				
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b100)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:3],addr[2:0]+1'b1});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
				
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b110)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:4],addr[3:0]+1'b1});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
				
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
	
endtask

task ahb_incr_wr_seq::call2();

	if(req.Hburst == 3'b010)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:3],addr[2:1]+1'b1,addr[0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b100)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:4],addr[3:1]+1'b1,addr[0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b110)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:5],addr[4:1]+1'b1,addr[0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
	
endtask

task ahb_incr_wr_seq::call3();

	if(req.Hburst == 3'b010)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:4],addr[3:2]+1'b1,addr[1:0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b100)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:5],addr[4:2]+1'b1,addr[1:0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
		
	else if(req.Hburst == 3'b110)
		begin
			for(int i=1;i<temp_burst-1;i++)
				begin
					start_item(req);
					assert(req.randomize with {req.Hwrite==Write;req.Hsize==size1;req.Hburst==burst;(req.Haddr=={addr[31:6],addr[5:2]+1'b1,addr[1:0]});req.Htrans==2'b11;});
						`uvm_info("INCR_SEQ",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
					finish_item(req);
					
					Write = req.Hwrite;
					size1 = req.Hsize;
					burst = req.Hburst;
					addr = req.Haddr;
				end
		end
	
endtask	*/


