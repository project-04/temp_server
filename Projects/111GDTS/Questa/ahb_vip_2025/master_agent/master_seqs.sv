class m_sequence extends uvm_sequence#(trans);

	`uvm_object_utils(m_sequence)
     
     env_config cfg;

	function new(string name="m_sequence");
		super.new(name);
	endfunction
     task body();
          
          if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",cfg))
          `uvm_fatal("master_sequence","cannot get env_cfg inside master sequence class")

     endtask

endclass

class single_seq extends m_sequence;

	`uvm_object_utils(single_seq)

	bit hwrite1;
	int haddr1;
	bit[2:0]hburst1;
	bit[2:0]hsize1;
	bit[1:0]htrans1;
	int hwdata1;

	function new(string name="single_seq");
		super.new(name);
	endfunction

	task body;
          super.body();
        //  repeat(4)
          begin
		req=trans::type_id::create("req");
		start_item(req);
		req.randomize with {hburst==0;haddr == cfg.haddr;htrans==2;hwrite==1;};
		finish_item(req);
          end
	endtask

endclass



class inc_seq extends m_sequence;

	`uvm_object_utils(inc_seq)

	bit hwrite2;
	int haddr2;
	bit[2:0]hsize2;
	bit[2:0]hburst2;
	bit[9:0]hlen2;

	function new(string name="ahb_seqs");
		super.new(name);
	endfunction

	task body;
          super.body();
	
//	repeat(10)
	begin
		req=trans::type_id::create("req");
		start_item(req);
		req.randomize with {hwrite==1;htrans==2;haddr == cfg.haddr;hburst inside {2,3,5,7};};
		finish_item(req);

		hwrite2=req.hwrite;
		haddr2=req.haddr;
		hburst2=req.hburst;
		hsize2=req.hsize;
		hlen2=req.hlen;

	for (int i=1; i <hlen2; i++) 
	  begin
                       	start_item(req);
			               req.randomize with {req.haddr == haddr2+(2**hsize2); req.htrans == 2'b11;hlen == hlen2;
						    req.hsize == hsize2; req.hburst == hburst2; req.hwrite == hwrite2;};
                       	finish_item(req);

          haddr2 = req.haddr;
	

	  end
	end
	endtask
endclass




class wrap_seq extends m_sequence;

	`uvm_object_utils(wrap_seq);

	bit hwrite3;
	int haddr3;
	bit [2:0]hburst3;
	bit [2:0]hsize3;
	bit [9:0]hlen3;

	function new(string name="wrap_seqs");
		super.new(name);
	endfunction

	task body;
	
    super.body();
	repeat(1)
	begin
		// busy transfer
		req=trans::type_id::create("req");
		start_item(req);
		req.randomize with {htrans==1;};
		finish_item(req);
	end

//	repeat(10)
	begin
		req=trans::type_id::create("req");
		start_item(req);
		req.randomize with {htrans == 2;hburst inside{2,4,6};hwrite==1;};
		`uvm_info("WRAP SEQUENCE",$sformatf("DATA FROM THE WRAP SEQUENCE %s",req.sprint),UVM_LOW);
		finish_item(req);

		hwrite3=req.hwrite;
		hsize3=req.hsize;
		hburst3=req.hburst;
		haddr3=req.haddr;
    	hlen3=req.hlen;

	if(hburst3==2)
		begin
			for(int i=0;i<3;i++)
			begin
				start_item(req);
				if(hsize3==0)
			begin
					req.randomize with {hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								req.haddr == {haddr3[31:2],haddr3[1:0]+1'b1};};
				end
				if(hsize3==1)
			begin
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:3],haddr3[2:1]+1'b1,haddr3[0]};};
				end
				if(hsize3==2)
			begin
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:4],haddr3[3:2]+1'b1,haddr3[1:0]};};
			end		
			finish_item(req);
				haddr3=req.haddr;
			end
		end

	if(hburst3==4)
		begin
			for(int i=0;i<7;i++)
			begin
				start_item(req);
				if(hsize3==0)
					req.randomize with {	hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:3],haddr3[2:0]+1'b1};};
				
				if(hsize3==1)
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:4],haddr3[3:1]+1'b1,haddr3[0]};};

				if(hsize3==2)
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:5],haddr3[4:2]+1'b1,haddr3[1:0]};};
				finish_item(req);
				haddr3=req.haddr;
			end
		end

	if(hburst3==6)
		begin
			for(int i=0;i<15;i++)
			begin
				start_item(req);
				if(hsize3==0)
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:4],haddr3[3:0]+1'b1};};
				
				if(hsize3==1)
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:5],haddr3[4:1]+1'b1,haddr3[0]};};

				if(hsize3==2)
					req.randomize with { hwrite == hwrite3;
								hsize == hsize3;
								hburst == hburst3;
								hlen==hlen3;
								htrans == 3;
								haddr == {haddr3[31:6],haddr3[5:2]+1,haddr3[1:0]};};
				finish_item(req);
				haddr3=req.haddr;
			end
		end
	end
	endtask
endclass

