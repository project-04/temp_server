//******************************************************************//Base sequence
class apb_sequence extends uvm_sequence #(apb_trans);
      `uvm_object_utils(apb_sequence)

  function new(string name = "apb_sequence" );
           super.new(name);
  endfunction

endclass

//****************************************************************//apb_HD0
class apb_HD0 extends apb_sequence;
      `uvm_object_utils(apb_HD0)
 
  function new(string name = "apb_HD0");
	   super.new(name);
  endfunction 


  task body();
     begin
	req = apb_trans::type_id::create("req");
  //Divisor2------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor1------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //THR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h0; PWRITE == 1; PWDATA== 8'b0110_1001;}); 
	finish_item(req);
     
     end

  endtask

  endclass

//****************************************************************//apb_HD0_mutliple_sequence
class apb_HD0_multiple_sequence extends apb_sequence;
      `uvm_object_utils(apb_HD0_multiple_sequence)
 
  function new(string name = "apb_HD0_multiple_sequence");
	   super.new(name);
  endfunction 

  task body();
     begin
	req = apb_trans::type_id::create("req");
  //Divisor2------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor1------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b1000_0110;});
	finish_item(req);

  //IER-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0111;});
	finish_item(req);

  //THR-----------------
	repeat(8)
         begin
     	  	start_item(req);
	  	assert(req.randomize() with {PADDR == 8'h0; PWRITE == 1; PWDATA inside {[1:255]};});
	  	finish_item(req);
         end
     end

  endtask

  endclass

//************************************************************//apb_HD1
class apb_HD1 extends apb_sequence;
      `uvm_object_utils(apb_HD1)
  
  function new(string name = "apb_HD1");
           super.new(name);
  endfunction 

  task body();     
       begin
	req = apb_trans::type_id::create("req");

  //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0101;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
	  begin
	    start_item(req);
            assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    finish_item(req);
	  end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//****************************************************************//apb_HD1_multiple_sequence
class apb_HD1_multiple_sequence extends apb_sequence;
      `uvm_object_utils(apb_HD1_multiple_sequence)
  
  function new(string name = "apb_HD1_multiple_sequence");
           super.new(name);
  endfunction 

  task body();     
       begin
	req = apb_trans::type_id::create("req");

  //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b1000_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0101;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
		begin
	    		start_item(req);
            		assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    		finish_item(req);
	  	end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//************************************************************//apb_FD_sequence
class apb_FD_sequence extends apb_sequence;	
      `uvm_object_utils(apb_FD_sequence)

	function new(string name="apb_FD_sequence");
		super.new(name);
	endfunction

	task body();
	     begin

		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b0000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0101;});
		finish_item(req);

	//THR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA==8'b1010_1010;}); //inside{[0:255]};})
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
		end
 	endtask
endclass

//************************************************************//apb_FD_multiple_sequence
class apb_FD_multiple_sequence extends apb_sequence;	
      `uvm_object_utils(apb_FD_multiple_sequence)

	function new(string name="apb_FD_multiple_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b1000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0101;});
		finish_item(req);

	//THR-------------------
                repeat(8)
		 begin
			start_item(req);
			assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA inside{[0:255]};})
			finish_item(req);
		 end

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
                 repeat(8)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
	
		end
 	endtask
endclass

//************************************************************//apb_loopback_sequence
class apb_loopback_sequence extends apb_sequence;	
      `uvm_object_utils(apb_loopback_sequence)

	function new(string name="apb_loopback_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

 	//MCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h10; PWDATA==8'b0001_0000;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b0000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0001;});
		finish_item(req);

	//THR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA=='h99;}); 
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
	
		end
 	endtask
endclass

//************************************************************//apb_loopback_multiple_sequence
class apb_loopback_multiple_sequence extends apb_sequence;	
      `uvm_object_utils(apb_loopback_multiple_sequence)

	function new(string name="apb_loopback_multiple_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

 	//MCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h10; PWDATA==8'b0001_0000;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b1000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0101;});
		finish_item(req);

	//THR-------------------
                repeat(8)
                begin
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA inside{[0:255]};})
		finish_item(req);
                end

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
                repeat(8)

			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
	
		end
 	endtask
endclass

//************************************************************//apb_THR_empty_sequence
class apb_THR_empty_sequence extends apb_sequence;
      `uvm_object_utils(apb_THR_empty_sequence)
  
  function new(string name = "apb_THR_empty_sequence");
           super.new(name);
  endfunction 

  task body();     
       begin
	req = apb_trans::type_id::create("req");

  //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b1100_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0010;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
	  begin
	    start_item(req);
            assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    finish_item(req);
	  end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//****************************************************************//apb_HD0_parity_sequence
class apb_HD0_parity_sequence extends apb_sequence;
      `uvm_object_utils(apb_HD0_parity_sequence)
 
  function new(string name = "apb_HD0_parity_sequence");
	   super.new(name);
  endfunction 

  task body();
     begin
	req = apb_trans::type_id::create("req");
  //Divisor2------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);


  //Divisor1------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_1011;});
	finish_item(req);

  //FCR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0101;});
	finish_item(req);

  //THR-----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h0; PWRITE == 1; PWDATA==99;}); //inside {[1:255]};});
	finish_item(req);
     
     end
  endtask

  endclass

//****************************************************************//apb_HD1_parity_sequence( HD1 where the UART agent is sending data to the UART DUT)
class apb_HD1_parity_sequence extends apb_sequence;
      `uvm_object_utils(apb_HD1_parity_sequence)
 
  function new(string name = "apb_HD1_parity_sequence");
	   super.new(name);
  endfunction 

  task body();
     begin
	req = apb_trans::type_id::create("req");

    //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0001_1011;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0101;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
	  begin
	    start_item(req);
            assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    finish_item(req);
	  end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//************************************************************//apb_FD_parity_sequence
class apb_FD_parity_sequence extends apb_sequence;	
      `uvm_object_utils(apb_FD_parity_sequence)

	function new(string name="apb_FD_parity_sequence");
		super.new(name);
	endfunction

	task body();
	     begin

		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0001_1011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b0000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0101;});
		finish_item(req);

	//THR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA==99;}); //inside{[0:255]};})
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
		end
 	endtask
endclass

 //************************************************************//apb_HD1_break_sequence
class apb_HD1_break_sequence extends apb_sequence;	
      `uvm_object_utils(apb_HD1_break_sequence)

	function new(string name="apb_HD1_break_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==32'h1;})
		finish_item(req);

	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==32'h46;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0100_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b0000_0110;});
		finish_item(req);

 	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0100;});
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;}) ;
		finish_item(req);
		get_response(req);

	//RBR------------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
		end
 	endtask
endclass

//****************************************************************//apb_HD_frame_sequence
class apb_HD_frame_sequence extends apb_sequence;
      `uvm_object_utils(apb_HD_frame_sequence)
 
  function new(string name = "apb_HD_frame_sequence");
	   super.new(name);
  endfunction 


  task body();
     begin
	req = apb_trans::type_id::create("req");
 
  //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0000;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0100;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
	  begin
	    start_item(req);
            assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    finish_item(req);
	  end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//************************************************************//apb_FD_frame_sequence
class apb_FD_frame_sequence extends apb_sequence;	
      `uvm_object_utils(apb_FD_frame_sequence)

	function new(string name="apb_FD_frame_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

        //Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA== 0;});
		finish_item(req);
		
	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA== 54;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0000;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==32'h6;});
		finish_item(req);

	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0100;});
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;});
		finish_item(req);
		get_response(req);
	
	//RBR-------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
	//THR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h0; PWDATA==5'h00_1111;}); // inside {[0:255]};})
		finish_item(req);
	
		end
	endtask
endclass

//************************************************************//apb_HD1_overrun
class apb_HD1_overrun extends apb_sequence;
      `uvm_object_utils(apb_HD1_overrun)
  
  function new(string name = "apb_HD1_overrun");
           super.new(name);
  endfunction 

  task body();     
       begin
	req = apb_trans::type_id::create("req");

  //Divisor MSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h20; PWRITE == 1; PWDATA == 'd0;});
	finish_item(req);

  //Divisor LSB------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h1c; PWRITE == 1; PWDATA == 'd54;});
	finish_item(req);

  //LCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'hc; PWRITE == 1; PWDATA == 8'b0000_0011;});
	finish_item(req);

  //FCR----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h8; PWRITE == 1; PWDATA == 8'b0000_0110;});
	finish_item(req);

  //IER----------------
	start_item(req);
	assert(req.randomize() with {PADDR == 8'h4; PWRITE == 1; PWDATA == 8'b0000_0100;});
	finish_item(req);

  //IIR----------------
	start_item(req);
	assert(req.randomize() with {PADDR==8'h8; PWRITE==0;}) 
        finish_item(req);
	get_response(req);

  //RBR----------------
       	if(req.IIR[3:0] == 4) //When data is available in RBR interrupt, then you read from it.
	  begin
	    start_item(req);
            assert(req.randomize() with {PADDR == 8'h00; PWRITE == 0;});
	    finish_item(req);
	  end

  //LSR----------------       
        if(req.IIR[3:0] == 6) //The interrupt is receiver line status.
          begin
            start_item(req);
            assert(req.randomize() with {PADDR == 8'h14; PWRITE == 0;});
	    finish_item(req);
	  end
       end
  endtask

endclass

//************************************************************//apb_HD1_timeout_sequence
class apb_HD1_timeout_sequence extends apb_sequence;	
      `uvm_object_utils(apb_HD1_timeout_sequence)

	function new(string name="apb_HD1_timeout_sequence");
		super.new(name);
	endfunction

	task body();
	     begin
		req=apb_trans::type_id::create("req");

	//Divisor MSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h20; PWDATA==0;});
		finish_item(req);
		
	//Divisor LSB-----------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h1c; PWDATA==54;});
		finish_item(req);

	//LCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'hc; PWDATA==8'b0000_0011;});
		finish_item(req);

	//FCR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h8; PWDATA==8'b1100_0110;});
		finish_item(req);

	//IER-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==1; PADDR==32'h4; PWDATA==8'b0000_0000;});
		finish_item(req);

	//IIR-------------------
		start_item(req);
		assert(req.randomize() with {PWRITE==0; PADDR==32'h8;});
		finish_item(req);
		get_response(req);
	
	//RBR-------------------
		if(req.IIR[3:0] == 4)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h0;PWRITE == 0;});
				finish_item(req);
			end
			
	//LSR------------------------
		if(req.IIR[3:0] == 6)
			begin 
				start_item(req);
				assert(req.randomize() with {PADDR == 32'h14; PWRITE == 0;});
				finish_item(req);
			end
            end	
          endtask
endclass

