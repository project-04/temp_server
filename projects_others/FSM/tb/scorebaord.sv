


class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	function new (string name = "scoreboard",uvm_component parent);
		super.new(name,parent);
	endfunction 

	uvm_tlm_analysis_fifo#(trans)sc_wp;
	uvm_tlm_analysis_fifo#(trans)sc_rp;	
	trans t1;
	trans t2;
	trans t3;

	typedef enum bit[1:0] {s0,s1,s2,s3} fsm_state;

	fsm_state dum_state;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		sc_wp = new("sc_wp",this);
		sc_rp = new("sc_rp",this);	
			
		t3 = trans::type_id::create("t3");		
		
	endfunction 



	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	fork
			forever	
				begin
				sc_rp.get(t2);
			//	`uvm_info(get_type_name(),"FRM RD_MON",UVM_LOW)	
			//	t2.print();

				//dummy(t2);
				//comp(t2);
			end
		forever
			begin 
				sc_wp.get(t1);
				`uvm_info(get_type_name(),"FRM WR_MON",UVM_LOW)	
				t1.print();
			end

	join
	endtask
	
	task comp(trans t1);
		begin 
			t1.print();
			t3.print();	
				
			if(t3.dout == t1.dout)
				$display("succ");
		end
	endtask		

	task dummy(trans t1);
	
		begin

			case(dum_state)
	
			s0 : 	if(t1.din == 1)
					dum_state = s1;
				else 
					dum_state = s0;
		
			s1 :	if(t1.din == 1)
					dum_state = s1;
				else
					dum_state = s2;
	
			s2 : 	if(t1.din == 1)
					dum_state = s3;
				else 
					dum_state = s0;
		
			s3 : 	if(t1.din == 1)
					dum_state = s1;
				else 
					dum_state = s2;
	
			endcase
		
		end

		this.t3.dout = (dum_state == s3);

	endtask
			

endclass	
