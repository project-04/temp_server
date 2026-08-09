module apb_master(
		input  p_clk, transfer,         
		input  p_rst,            
		input [31:0] p_addr_mi,  
		//input [31:0] b_pw_data,
		input p_ready_mi,p_write_mi,        
    		input p_slverr_mi,       
		input [31:0] pw_data_mi, 
		input [31:0]pr_data_mi,
    		output reg p_write_mo,   
    		output reg p_sel_mo,            
    		output reg p_enable_mo,
                output pready_mo,
                output pslv_err_mo,         
    		output reg [31:0] p_addr_mo,
		output reg [31:0]pw_data_mo,  
		output [31:0] pr_data_mo); 
		//output reg [31:0] ahp_data);

	parameter idle=2'b00,
		  setup=2'b01,
		  access=2'b10;

	reg [1:0]p_state,n_state;
	//wire [31:0]temp;

always@(posedge p_clk)
 begin
      if(!p_rst)
	begin
	     p_state<=idle;
	     
	end
      else
	     p_state<=n_state;
 end
	
always@(*)
 begin
	
	n_state=idle;
	     	
	case(p_state)
	  idle   :  if (transfer)
			n_state=setup;

	  setup  :begin
		  n_state=access;
		  
		   end
	  access :begin
		    if(p_ready_mi)
		      n_state=idle;
		    else
		      n_state=access;
		  end
		default:n_state=idle;
	endcase
  end
	
always@(*)
 begin
	//ahp_data = ahp_data; 
	p_sel_mo=0;
	p_enable_mo = 0;
	//p_addr_mo=0;
	//pw_data_mo=0;
	//p_write_mo=0;
	case(p_state)
	  idle   :begin
		    p_sel_mo=0;
		    p_enable_mo = 0;
		  end
	  setup  :begin
		    p_sel_mo=1;
		    p_write_mo=p_write_mi;
		    p_addr_mo=p_addr_mi;
		    pw_data_mo=pw_data_mi;
		  end
	  access :begin
		    p_enable_mo=1;
		    p_sel_mo=1;
		    /* if (p_ready) 
			begin
			  if (!write)
			     ahp_data = pr_data;
			  else
			     ahp_data=ahp_data;
                         end*/
		   end
	  default:begin
			p_sel_mo=0;
			//p_write_mo=0;
			
			
		  end
          endcase
				
 end
assign pready_mo = p_ready_mi;
assign pr_data_mo = pr_data_mi;
assign pslv_err_mo = p_slverr_mi;

//assign temp = (!write_enable&& p_state == access)? PRDATA: 0;

endmodule
	
	
	



