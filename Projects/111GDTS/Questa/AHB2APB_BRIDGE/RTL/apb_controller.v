   // Include definitions
     `include "definitions.v"
   //This module represents a controller that controls the generation of APB output signals .
      module apb_controller (input Hclk,Hresetn,valid,Hwrite,
                             input flag_timer,flag_interruptc,flag_remap_pause_controller,flag_slave4,
			     input [`WIDTH-1:0]Haddr_in,
			     input [1:0] Htrans,
			     input [2:0] Hburst,
			     input [2:0] Hsize,
			     input [`WIDTH-1:0]Hwdata,
			     input [`WIDTH-1:0]Prdata,
                             input [`WIDTH-1:0]config_reg_data,
                             output reg Penable,Pwrite,
			     output reg [`SLAVES-1:0]Pselx,
			     output reg [`WIDTH-1:0]Paddr,
			     output  reg Hreadyout,
			     output  reg [`WIDTH-1:0]Pwdata,Hrdata);

           
              //One hot encoding 
              reg [7:0]pre_state,next_state,pre_state_reg,pre_state_reg_d1;

              //FSM States 
	      parameter	ST_IDLE    =  8'b0000_0001,
	              	ST_READ    =  8'b0000_0010,
		        ST_RENABLE =  8'b0000_0100,
		        ST_WWAIT   =  8'b0000_1000,
		        ST_WRITE   =  8'b0001_0000,
		        ST_WENABLE =  8'b0010_0000,
		        ST_WRITEP  =  8'b0100_0000,
		        ST_WENABLEP = 8'b1000_0000,
			ST_WR_RD    = 8'b0000_0000,
			ST_RD_WR    = 8'b0000_0011;
         //Internal signals 
	    	reg Hwritereg,Hwrite_reg_d2,Hwrite_reg_d3,Hwrite_reg_d4,Hwrite_reg_d5,Hwrite_reg_d6;
		reg start_count_flag;	  
		reg [3:0] no_of_trans;
		reg [3:0] trans_counter;	
		reg [1:0] Htrans_reg;
		reg [2:0] Hburst_reg;
		reg [2:0] Hsize_reg ;
		reg [2:0] Hsize_reg_d2;
		reg [2:0] Hsize_reg_d3;
		reg [2:0] Hsize_reg_d4;
		reg [2:0] Hsize_reg_d5;
                integer count ;
		reg [`WIDTH-1:0]Haddr_reg_d1;   //Delayed by one cycle 
		reg [`WIDTH-1:0]Haddr_reg_d2;   //Delayed by two cycles
		reg [`WIDTH-1:0]Haddr_reg_d3;   //Delayed by three cycles
		reg [`WIDTH-1:0]Hwdata_reg_d1;  //Delayed by one cycle
		reg [`WIDTH-1:0]Hwdata_reg_d2;  //Delayed by two cycle
		reg [`WIDTH-1:0]inc_address;    //Delayed by one cycle 
		reg [`WIDTH-1:0]inc_address_d1; //Delayed by one cycle 
		reg [`WIDTH-1:0]inc_address_d2; //Delayed by two cycles
		reg [`WIDTH-1:0]inc_address_d3; //Delayed by three cycles
                //Flags for de-selecting a slave 
                reg de_select_slave,de_select_slave_1,de_select_slave_2 ; 
                //Counter logic for holding values 
                reg count_write,count_read,count_read_d2,count_write_d2,count_write_d3,
                    count_write_d4,count_write_wait,count_write_wait_d2,count_write_wait_d3,
                    count_write_wait_d4;
                //ADDRESS MATCHING FLAG DURING BURST OPERATION
                  reg address_match ;
		


	//Generation of Hwritereg and registering of data and address 

	 always@(posedge Hclk,negedge Hresetn)
	    begin
	     if(~Hresetn)
		begin
	         Hwritereg  <= 0 ;
		 Hwrite_reg_d2 <= 0;
		 Hwrite_reg_d3 <= 0;
		 Hwrite_reg_d4 <= 0;
		 Hwrite_reg_d5 <= 0;
		 Hwrite_reg_d6 <= 0;
		 Htrans_reg <= 0;
	 	 Hburst_reg <= 0;
	 	 Hsize_reg  <= 0;
		 Hsize_reg_d2 <= 0;
		 Hsize_reg_d3 <= 0;
		 Hsize_reg_d4 <= 0;
		 Hsize_reg_d5 <= 0;
		 count_write_d2 <= 0;
		 count_write_d3 <= 0;
                 count_write_d4 <= 0;
		 count_read_d2 <=  0;
                 count_write_wait_d2 <= 0;
		 count_write_wait_d3 <= 0;
                 count_write_wait_d4 <= 0;

	      end
	     else
		begin
                 Hwritereg  <= Hwrite ;
		 Hwrite_reg_d2 <= Hwritereg;
		 Hwrite_reg_d3 <= Hwrite_reg_d2;
		 Hwrite_reg_d4 <= Hwrite_reg_d3;
		 Hwrite_reg_d5 <= Hwrite_reg_d4;
		 Hwrite_reg_d6 <= Hwrite_reg_d5;
		 Htrans_reg <= Htrans;
	 	 Hburst_reg <= Hburst;
	 	 Hsize_reg  <= Hsize;
		 Hsize_reg_d2 <= Hsize_reg;
		 Hsize_reg_d3 <= Hsize_reg_d2;
		 Hsize_reg_d4 <= Hsize_reg_d3;
		 Hsize_reg_d5 <= Hsize_reg_d4;
		 count_write_d2 <= count_write;
		 count_write_d3 <= count_write_d2;
                 count_write_d4 <= count_write_d3;
		 count_read_d2 <=  count_read;
                 count_write_wait_d2 <= count_write_wait;
                 count_write_wait_d3 <= count_write_wait_d2;
                 count_write_wait_d4 <= count_write_wait_d3;
	       end
	    end


            always@(posedge Hclk,negedge Hresetn)
	      begin
	       if(~Hresetn)
	        begin
		  Hwdata_reg_d1 <= 0;
		  Hwdata_reg_d2 <= 0;
                end
	       else
	        begin
	         Hwdata_reg_d1 <= Hwdata ;
		 Hwdata_reg_d2 <= Hwdata_reg_d1;
		end
	      end
		 
    


	always@(*)
	begin
           if(~Hresetn)
             no_of_trans  = 0;
           else
            begin
		 case (Hburst)
		  3'b000 : no_of_trans = 1; //SINGLE TRANSFER
		  3'b001 : no_of_trans = 0; //INCREMENTING BURST OF UNSPECIFIED LENGTH
		  3'b010,3'b011 : no_of_trans = 4;//4 BEAT WRAPPING & INCREMENTING BURST
		  3'b100,3'b101 : no_of_trans = 8;//8 BEAT WRAPPING & INCREMENTING BURST
		  3'b110,3'b111 : no_of_trans = 16;//16 BEAT WRAPPING & INCREMENTING BURST
		endcase
           end
	end

       
         //Present state logic 
	    always@(posedge Hclk,negedge Hresetn)
	      begin
	       if(~Hresetn)
	         begin
	          pre_state <= ST_IDLE ;
		  {Haddr_reg_d1,Haddr_reg_d2,Haddr_reg_d2} <= 0;
		  pre_state_reg <= 0 ;
                  pre_state_reg_d1 <= 0;
	         end
	       else 
	         begin
	              pre_state <= next_state ;
		      pre_state_reg <= pre_state ;
                      pre_state_reg_d1 <= pre_state_reg;
		      Haddr_reg_d1 <= Haddr_in;
		      Haddr_reg_d2 <= Haddr_reg_d1;
		      Haddr_reg_d3 <= Haddr_reg_d2;
	         end
	     end

           //Logic for de_selecting a slave 

            always@Paddr
             begin
              if(Paddr <= 8)
                begin
                  de_select_slave = 1;
                end
              else
                  de_select_slave = 0;
             end

           always@(posedge Hclk)
            begin
             de_select_slave_1 <= de_select_slave; 
             de_select_slave_2 <= de_select_slave_1; 
            end

	    always@(posedge Hclk,negedge Hresetn)
	      begin
	       if(~Hresetn)
	         begin
		       pre_state_reg <= 0 ;
	         end
	       else 
	         begin
		       pre_state_reg <= pre_state ;
	         end
	     end
      
       always@(posedge Hclk,negedge Hresetn)
         begin
	  if(~Hresetn)
	    count_write <= 0;
	  
	  else if(valid & (pre_state == ST_IDLE) & Hwrite)
	    count_write <= count_write + 1;
	  else
	    count_write <= 0;
         end 
       always@(posedge Hclk,negedge Hresetn)
         begin
	  if(~Hresetn)
	    count_read <= 0;
	  else if(valid & (pre_state == ST_IDLE) & ~Hwrite)
	    count_read <= count_read + 1;
	  else
	    count_read <= 0;
         end 
       always@(posedge Hclk,negedge Hresetn)
         begin
	  if(~Hresetn)
	    count_write_wait <= 0;
	  else if(valid & (pre_state == ST_RENABLE) & Hwrite)
	    count_write_wait <= count_write_wait + 1;
	  else
	    count_write_wait <= 0;
         end 

	//Task for Implementing the little Endianess 
                      task Endianess_d1();
		        begin
		        case(Hsize_reg_d2)
			 3'b000:         begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_BYTE_0:Pwdata = Hwdata_reg_d1[7:0];
					       `ADDR_OFFSET_BYTE_1:Pwdata = Hwdata_reg_d1[15:8];
					       `ADDR_OFFSET_BYTE_2:Pwdata = Hwdata_reg_d1[23:16];
					       `ADDR_OFFSET_BYTE_3:Pwdata = Hwdata_reg_d1[31:24];
					        default           :Pwdata = 0;
					    endcase
					 end
			 3'b001:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_HFWORD_0:Pwdata = Hwdata_reg_d1[15:0];
					       `ADDR_OFFSET_HFWORD_2:Pwdata = Hwdata_reg_d1[31:16];
					        default             :Pwdata = 0;
					    endcase
					  end
			 3'b010:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_WORD  :Pwdata = Hwdata_reg_d1;
					        default           :Pwdata = 0;
					    endcase
			                  end
			default: Pwdata = 0;
		       endcase
                      end
		    endtask

                      task Endianess_d2();
		        begin
		         case(Hsize_reg_d3)
			 3'b000:         begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_BYTE_0:Pwdata = Hwdata_reg_d2[7:0];
					       `ADDR_OFFSET_BYTE_1:Pwdata = Hwdata_reg_d2[15:8];
					       `ADDR_OFFSET_BYTE_2:Pwdata = Hwdata_reg_d2[23:16];
					       `ADDR_OFFSET_BYTE_3:Pwdata = Hwdata_reg_d2[31:24];
					        default           :Pwdata = 0;
					    endcase
					 end
			 3'b001:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_HFWORD_0:Pwdata = Hwdata_reg_d2[15:0];
					       `ADDR_OFFSET_HFWORD_2:Pwdata = Hwdata_reg_d2[31:16];
					        default             :Pwdata = 0;
					    endcase
					  end
			 3'b010:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_WORD  :Pwdata = Hwdata_reg_d2;
					        default           :Pwdata = 0;
					    endcase
			                  end
			default: Pwdata = 0;
		       endcase
                      end
		    endtask

                      task Endianess_d4();
		        begin
		         case(Hsize_reg_d4)
			 3'b000:         begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_BYTE_0:Pwdata = Hwdata_reg_d2[7:0];
					       `ADDR_OFFSET_BYTE_1:Pwdata = Hwdata_reg_d2[15:8];
					       `ADDR_OFFSET_BYTE_2:Pwdata = Hwdata_reg_d2[23:16];
					       `ADDR_OFFSET_BYTE_3:Pwdata = Hwdata_reg_d2[31:24];
					        default           :Pwdata = 0;
					    endcase
					 end
			 3'b001:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_HFWORD_0:Pwdata = Hwdata_reg_d2[15:0];
					       `ADDR_OFFSET_HFWORD_2:Pwdata = Hwdata_reg_d2[31:16];
					        default             :Pwdata = 0;
					    endcase
					  end
			 3'b010:          begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_WORD  :Pwdata = Hwdata_reg_d2;
					        default           :Pwdata = 0;
					    endcase
			                  end
			default: Pwdata = 0;
		       endcase
                      end
		    endtask 
        //Output logic for Pwdata implementing the little Endianess 
	   always@(pre_state)
             begin
	       if(~Hresetn)
	        Pwdata  = 0;
	       else if((count_write_d2 & Hwrite) | (count_write_wait_d2 & Hwrite ) | ((pre_state_reg_d1 == ST_RD_WR) & (pre_state == ST_WRITEP)))
	        begin
		    Pwdata = Pwdata ;
		 	`ifdef WIDTH_32
			 /*3'b000: Pwdata = begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_BYTE_0:Pwdata = Hwdata_reg_d1[7:0];
					       `ADDR_OFFSET_BYTE_1:Pwdata = Hwdata_reg_d1[15:8];
					       `ADDR_OFFSET_BYTE_2:Pwdata = Hwdata_reg_d1[23:16];
					       `ADDR_OFFSET_BYTE_3:Pwdata = Hwdata_reg_d1[31:24];
					        default           :Pwdata = 0;
					    endcase
					 end
			 3'b001: Pwdata = begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_HFWORD_0:Pwdata = Hwdata_reg_d1[15:0];
					       `ADDR_OFFSET_HFWORD_2:Pwdata = Hwdata_reg_d1[31:16];
					        default           :Pwdata = 0;
					    endcase
					  end
			 3'b010: Pwdata = begin
			                    case(Paddr[1:0])
					       `ADDR_OFFSET_WORD:Pwdata = Hwdata_reg_d1;
					        default           :Pwdata = 0;
					    endcase
			                  end
			default: Pwdata = 0;*/
			Endianess_d1;
		       `endif
	       end
	      else if((count_write_d3|count_write_wait_d4|count_write_d4) & Hwrite)
	        begin
		  Pwdata = Pwdata ;
		 	`ifdef WIDTH_32
			  Endianess_d2;
		        `endif
	        end
              else if(pre_state == ST_WENABLE)
                  Pwdata = Pwdata;
              else if(Hwrite_reg_d3 & ~Hwrite_reg_d2)
	        begin
		  Pwdata = Pwdata ;
		 	`ifdef WIDTH_32
			  Endianess_d4;
		        `endif
	      end
	      else 
	       begin
		   Pwdata = Pwdata ;
	         case(pre_state)
	          ST_IDLE,ST_WWAIT: begin
		                     Pwdata = Pwdata;
			            end
		  ST_WRITEP :       begin
		                      Pwdata = Pwdata ;
		 	           `ifdef WIDTH_32
			             Endianess_d4;
		                   `endif
				  end
		  ST_WENABLEP :     begin
		                     Pwdata = Pwdata;
			            end
		  ST_WRITE :   begin
		                 Pwdata = Pwdata ;
		 	           `ifdef WIDTH_32
			             Endianess_d1;
		                   `endif
			       end
		  ST_WENABLE,ST_WR_RD,ST_RD_WR:Pwdata = Pwdata;
		  ST_READ,ST_RENABLE : Pwdata = Pwdata; 
		endcase
	       end
	    end


          `ifdef SINGLE_INCR_UNSPECIFIED_LENGTH 
             //Output logic for Paddr logic
	   always@(pre_state)
             begin
	       if(~Hresetn)
	        Paddr = 0;
	       else if((Hburst == `SINGLE_TRANSFER)|(Hburst == `UNSPECIFIED)) 
	         begin
	           if(count_read & ~Hwrite)
	        	Paddr = Haddr_reg_d1;
	       	   else if(count_write_d2 )
	        	Paddr = Haddr_reg_d2;
	       	   else if(count_write_d3)
	       	 	Paddr = Paddr;
                   else 
	        	begin
		 	Paddr = Paddr ;
	         	case(pre_state)
	          	ST_IDLE  : begin
		              	    Paddr = Paddr ;
			     	   end
		  	ST_WWAIT : begin
		              	     Paddr = Paddr ;
			           end
		  	ST_WRITEP :  begin
		                      Paddr = Haddr_reg_d3;
			             end
		  	ST_WENABLEP :begin
		                      Paddr = Paddr;
			             end
		  	ST_WRITE :   Paddr = Haddr_reg_d3;
		  	ST_WENABLE : Paddr = Paddr;
		  	ST_READ :    begin
		                      Paddr = Haddr_reg_d1;
			               if(pre_state_reg == ST_WENABLE & ~Hwrite)
				        Paddr = Haddr_reg_d3;
			             end
		  	ST_RENABLE : Paddr = Paddr ;
		  	ST_WR_RD   : Paddr = Haddr_reg_d3;
		  	ST_RD_WR   : Paddr = Paddr;
	        	endcase
	      	       end
	        end
	      end
	`else 
             `ifdef WRAPPING_INCR 
	         always@(pre_state)
                  begin
	           if(~Hresetn)
                    begin
	             Paddr = 0;
                     address_match = 0;
                    end
	          else if((Hburst == `BEAT_4_WRAP)|(Hburst == `BEAT_8_WRAP)|
                          (Hburst == `BEAT_16_WRAP)|(Hburst == `BEAT_4_INCR)|
                          (Hburst == `BEAT_8_INCR)|(Hburst == `BEAT_16_INCR)) //Apply wrapping logic 
	              begin
                       address_match = 0;
	               if(count_read & ~Hwrite)
                         begin
	        	   Paddr = inc_address;
                           address_match = (inc_address == Haddr_reg_d1)?1:0 ;
                         end
	       	       else if(count_write_d2 |((pre_state_reg_d1 == ST_RD_WR) & (pre_state == ST_WRITEP)))
                         begin
	        	   Paddr = inc_address_d1;
                           address_match = (inc_address_d1 == Haddr_reg_d2)?1:0 ;
                         end 
                       else if((pre_state == ST_WRITE) & (pre_state_reg == ST_WENABLEP))
                         begin
                          Paddr = inc_address_d2;
                         end
	       	       else if(count_write_d3)
                         begin
	       	 	  Paddr = Paddr;
                         end
	               else 
	        	 begin
		 	  Paddr = Paddr;
                          address_match = address_match;
	         	  case(pre_state)
	          	   ST_IDLE  : begin
		              		Paddr = Paddr;
			     	      end
		  	   ST_WWAIT : begin
		              		Paddr = Paddr;
			              end
		  	   ST_WRITEP : begin
		                         Paddr = inc_address_d2;
                                         address_match = (inc_address_d2 == Haddr_reg_d3)?1:0;
			               end
		  	   ST_WENABLEP :begin
		                         Paddr = Paddr;
			                end
		  	   ST_WRITE    : begin
                                          Paddr = inc_address_d1;
                                          address_match = (inc_address_d1 == Haddr_reg_d3)?1:0;
                                         end
		  	   ST_WENABLE  : Paddr = Paddr;
		  	   ST_READ     : begin
		                          Paddr = inc_address;
                                          address_match = (inc_address_d2 == Haddr_reg_d1)?1:0;
			                  if(pre_state_reg == ST_WENABLE & ~Hwrite)
				           Paddr = inc_address_d2;
                                           address_match = (inc_address_d2 == Haddr_reg_d3)?1:0;
			                 end
		  	   ST_RENABLE :   Paddr = Paddr ;
		  	   ST_WR_RD   :   begin 
                                           Paddr = inc_address_d2;
                                           address_match = (inc_address_d2 == Haddr_reg_d3)?1:0;
                                          end
		  	   ST_RD_WR   :   Paddr = Paddr;
	        	 endcase
	      	       end
	          end
	        end
	`endif
        `endif
        
	    always@(posedge Hclk,negedge Hresetn)
	      begin
	       if(~Hresetn)
	         begin
		  {inc_address_d1,inc_address_d2,inc_address_d3} <= 0;
	         end
	       else 
	         begin
                  inc_address_d1 <= inc_address;
		  inc_address_d2 <= inc_address_d1;
		  inc_address_d3 <= inc_address_d2;
	         end
	     end

	 always@(posedge Hclk,negedge Hresetn)
           begin
            if(~Hresetn)
              {inc_address,count} <= 0;
	    else if(Htrans == 2'b10) //NON_SEQ Mode
              begin
	       inc_address <= Haddr_in ;
               count <= 0;
              end
            else if(Htrans == 2'b11) //SEQ Mode
                   begin
  			  case(Hsize)		
			  	3'b000 :  //8bits
					     begin
						case (Hburst)	
						3'b010 :  //4 BEAT WRAPPING BURST 
							begin
                                                          if(Hreadyout)
                                                          begin
                                                            if(count != 3)
                                                             begin
							      inc_address  <=  {inc_address[31:2],(inc_address[1:0] + 1'b1)} ;
                                                              count <= count + 1;
                                                             end
                                                          end 
							end
                                               3'b100  : //8 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin    
							        inc_address  <=  {inc_address[31:3],(inc_address[2:0] + 1'b1)} ;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                          end
                                               3'b110  : //16 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin    
							        inc_address  <=  {inc_address[31:4],(inc_address[3:0] + 1'b1)} ;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                          end
                                               3'b011  : //4 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 3)
                                                               begin
							        inc_address  <=  inc_address + 1'b1;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b101  : //8 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin
							        inc_address  <=  inc_address + 1'b1;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b111  : //16 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin
							        inc_address  <=  inc_address + 1'b1;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               endcase
					    end
                                3'b001 : //16bits
					     begin
						case (Hburst)	
						3'b010 :  //4 BEAT WRAPPING BURST 
							begin
                                                          if(Hreadyout)
                                                          begin
                                                            if(count != 3)
                                                             begin
                                                              count <= count + 1;
							      inc_address <= {inc_address[31:3], ( inc_address[2:1] + 1'b1 ), inc_address[0] };
                                                             end
                                                          end 
							end
                                               3'b100  : //8 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin    
							        inc_address <= {inc_address[31:4],
								( inc_address[3:1] + 1'b1 ), inc_address[0] };
                                                                count <= count + 1;
                                                               end
                                                             end
                                                          end
                                               3'b110  : //16 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin    
						 	        inc_address <= {inc_address[31:5], (inc_address[4:1] + 1'b1 ), inc_address[0] };
                                                                count <= count + 1;
                                                               end
                                                             end
                                                          end
                                               3'b011  : //4 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 3)
                                                               begin
							        inc_address  <=  inc_address + 2 ;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b101  : //8 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin
							        inc_address  <=  inc_address + 2;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b111  : //16 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin
							        inc_address  <=  inc_address + 2;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               endcase
					    end
                                3'b010: //32bits
					     begin
						case (Hburst)	
						3'b010 :  //4 BEAT WRAPPING BURST 
							begin
                                                          if(Hreadyout)
                                                          begin
                                                            if(count != 3)
                                                             begin
                                                              count <= count + 1;
							      inc_address <= {inc_address[31:4], ( inc_address[3:2] + 1'b1 ), inc_address[1:0] };
                                                             end
                                                          end 
							end
                                               3'b100  : //8 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin    
                                                                count <= count + 1;
							        inc_address <= 
								{inc_address[31:5], ( inc_address[4:2] + 1'b1 ), inc_address[1:0] };
                                                               end
                                                             end
                                                          end
                                               3'b110  : //16 BEAT WRAPPING BURST
                                                          begin
					                   if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin    
                                                                count <= count + 1;
							        inc_address <= {inc_address[31:6], ( inc_address[5:2] + 1'b1 ), inc_address[1:0] };
                                                               end
                                                             end
                                                          end
                                               3'b011  : //4 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 3)
                                                               begin
							        inc_address  <=  inc_address + 4 ;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b101  : //8 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 7)
                                                               begin
							        inc_address  <=  inc_address + 4;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               3'b111  : //16 BEAT INCREMENT BURST
                                                         begin
                                                           if(Hreadyout)
                                                             begin
                                                              if(count != 15)
                                                               begin
							        inc_address  <=  inc_address + 4;
                                                                count <= count + 1;
                                                               end
                                                             end
                                                        end
                                               endcase
					    end
			 endcase
		   end
            end
     //Output logic for Hrdata

      always@(Penable,Prdata,de_select_slave_2)
             begin
	       if(~Hresetn)
	        Hrdata  = 0;
               /*else if(de_select_slave_2)
                Hrdata  = config_reg_data;*/
               else if(Penable)
                begin
	           if(count_read_d2) //First read
	           begin
		    Hrdata = Hrdata ;
		        case(Hsize_reg_d2)
		        `ifdef WIDTH_1024
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];
                         3'b011: Hrdata = Prdata[63:0];
	                 3'b100: Hrdata = Prdata[127:0];
			 3'b101: Hrdata = Prdata[255:0];
			 3'b110: Hrdata = Prdata[511:0];
			 3'b111: Hrdata = Prdata[1023:0];
			default: Hrdata = 0;
		       `endif
                        `ifdef WIDTH_512
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];
                         3'b011: Hrdata = Prdata[63:0];
	                 3'b100: Hrdata = Prdata[127:0];
			 3'b101: Hrdata = Prdata[255:0];
			 3'b110: Hrdata = Prdata[511:0];
			default: Hrdata = 0;
		       `endif
                        `ifdef WIDTH_256
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];
                         3'b011: Hrdata = Prdata[63:0];
	                 3'b100: Hrdata = Prdata[127:0];
			 3'b101: Hrdata = Prdata[255:0];
			default: Hrdata = 0;
		       `endif
                       `ifdef WIDTH_128
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];
                         3'b011: Hrdata = Prdata[63:0];
	                 3'b100: Hrdata = Prdata[127:0];
			default: Hrdata = 0;
		       `endif
                       `ifdef WIDTH_64
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];
                         3'b011: Hrdata = Hwdata[63:0];
			 default: Hrdata = 0;
		       `endif
		 	`ifdef WIDTH_32
			 3'b000: Hrdata = Prdata[7:0];
			 3'b001: Hrdata = Prdata[15:0];	
			 3'b010: Hrdata = Prdata[31:0];	
			default: Hrdata = 0;
		       `endif
	              endcase
                end
             	else if(~count_read_d2 & ~Hwrite_reg_d2 & (pre_state == ST_RENABLE)) //Continuous Read
	          begin
		              Hrdata = Hrdata ;
		              case(Hsize_reg_d3)
			             `ifdef WIDTH_1024
			                 3'b000: Hrdata = Prdata[7:0];
			                 3'b001: Hrdata = Prdata[15:0];	
			                 3'b010: Hrdata = Prdata[31:0];
                                         3'b011: Hrdata = Prdata[63:0];
	                                 3'b100: Hrdata = Prdata[127:0];
			                 3'b101: Hrdata = Prdata[255:0];
			                 3'b110: Hrdata = Prdata[511:0];
			                 3'b111: Hrdata = Prdata[1023:0];
			                 default: Hrdata = 0;
		                     `endif
                                     `ifdef WIDTH_512
			               3'b000: Hrdata =  Prdata[7:0];
			               3'b001: Hrdata =  Prdata[15:0];	
			               3'b010: Hrdata =  Prdata[31:0];
                                       3'b011: Hrdata =  Prdata[63:0];
	                               3'b100: Hrdata =  Prdata[127:0];
			               3'b101: Hrdata =  Prdata[255:0];
			               3'b110: Hrdata  = Prdata[511:0];
		          	       default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_256
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              3'b101: Hrdata = Prdata[255:0];
			              default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_128
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              default: Hrdata = 0;
		                    `endif
                                   `ifdef WIDTH_64
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];
                                     3'b011: Hrdata = Prdata[63:0];
			             default: Hrdata = 0;
		                   `endif
		 	           `ifdef WIDTH_32
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];	
			             default: Hrdata = 0;
		                   `endif
	                     endcase
	        end
	      else if(Hwrite_reg_d5 & ~Hwrite_reg_d4)    //Back to Back 
	       begin
	                Hrdata = Hrdata ;
		              case(Hsize_reg_d4)
			             `ifdef WIDTH_1024
			                 3'b000: Hrdata = Prdata[7:0];
			                 3'b001: Hrdata = Prdata[15:0];	
			                 3'b010: Hrdata = Prdata[31:0];
                                         3'b011: Hrdata = Prdata[63:0];
	                                 3'b100: Hrdata = Prdata[127:0];
			                 3'b101: Hrdata = Prdata[255:0];
			                 3'b110: Hrdata = Prdata[511:0];
			                 3'b111: Hrdata = Prdata[1023:0];
			                 default: Hrdata = 0;
		                     `endif
                                     `ifdef WIDTH_512
			               3'b000: Hrdata =  Prdata[7:0];
			               3'b001: Hrdata =  Prdata[15:0];	
			               3'b010: Hrdata =  Prdata[31:0];
                                       3'b011: Hrdata =  Prdata[63:0];
	                               3'b100: Hrdata =  Prdata[127:0];
			               3'b101: Hrdata =  Prdata[255:0];
			               3'b110: Hrdata  = Prdata[511:0];
		          	       default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_256
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              3'b101: Hrdata = Prdata[255:0];
			              default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_128
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              default: Hrdata = 0;
		                    `endif
                                   `ifdef WIDTH_64
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];
                                     3'b011: Hrdata = Prdata[63:0];
			             default: Hrdata = 0;
		                   `endif
		 	           `ifdef WIDTH_32
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];	
			             default: Hrdata = 0;
		                   `endif
	                     endcase

	           end
		   else if(Hwrite_reg_d6 & ~Hwrite_reg_d5) 
	             begin
	                Hrdata = Hrdata ;
		              case(Hsize_reg_d5)
			             `ifdef WIDTH_1024
			                 3'b000: Hrdata = Prdata[7:0];
			                 3'b001: Hrdata = Prdata[15:0];	
			                 3'b010: Hrdata = Prdata[31:0];
                                         3'b011: Hrdata = Prdata[63:0];
	                                 3'b100: Hrdata = Prdata[127:0];
			                 3'b101: Hrdata = Prdata[255:0];
			                 3'b110: Hrdata = Prdata[511:0];
			                 3'b111: Hrdata = Prdata[1023:0];
			                 default: Hrdata = 0;
		                     `endif
                                     `ifdef WIDTH_512
			               3'b000: Hrdata =  Prdata[7:0];
			               3'b001: Hrdata =  Prdata[15:0];	
			               3'b010: Hrdata =  Prdata[31:0];
                                       3'b011: Hrdata =  Prdata[63:0];
	                               3'b100: Hrdata =  Prdata[127:0];
			               3'b101: Hrdata =  Prdata[255:0];
			               3'b110: Hrdata  = Prdata[511:0];
		          	       default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_256
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              3'b101: Hrdata = Prdata[255:0];
			              default: Hrdata = 0;
		                    `endif
                                    `ifdef WIDTH_128
			              3'b000: Hrdata = Prdata[7:0];
			              3'b001: Hrdata = Prdata[15:0];	
			              3'b010: Hrdata = Prdata[31:0];
                                      3'b011: Hrdata = Prdata[63:0];
	                              3'b100: Hrdata = Prdata[127:0];
			              default: Hrdata = 0;
		                    `endif
                                   `ifdef WIDTH_64
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];
                                     3'b011: Hrdata = Prdata[63:0];
			             default: Hrdata = 0;
		                   `endif
		 	           `ifdef WIDTH_32
			             3'b000: Hrdata = Prdata[7:0];
			             3'b001: Hrdata = Prdata[15:0];	
			             3'b010: Hrdata = Prdata[31:0];	
			             default: Hrdata = 0;
		                   `endif
	                     endcase

	           end
               else if(de_select_slave_2)
                    Hrdata  = config_reg_data;

	 end

      end
       
      
        //Next state logic 
	  always@*
	    begin
	      next_state = pre_state ; //Default assignment
	      case(pre_state)
	       ST_IDLE : begin
				Hreadyout = 1;   
			      if(valid)
			       	begin
			       	 if(Hwrite)
			       	  next_state = ST_WWAIT ;
			       	else
			          next_state = ST_READ;
			      	end
			     else
			          next_state = ST_IDLE ;
			  end
	       ST_READ  : 
			begin
                          next_state = ST_RENABLE ;
			  Hreadyout  = 0;
		        end

	      ST_RENABLE: begin
				Hreadyout = 1; 
 		                 if(valid)	
			           begin
			              if(Hwrite)		
			                next_state = ST_WWAIT ;
			              else
			                next_state = ST_READ;
			          end
			         else
			                next_state = ST_IDLE ;
			  end
		ST_WENABLE : 	
				begin
				  Hreadyout = 0;
				   next_state = ST_IDLE;
				 if(valid & ~Hwrite)
				   next_state = ST_READ;
				 else if(~Hwrite_reg_d2)
				    next_state = ST_WR_RD;
				  else if(valid & Hwrite)
			           next_state = ST_WWAIT;
			       end
	       ST_WR_RD    :  begin
	                           Hreadyout = 0;
				   next_state = ST_RD_WR;
			      end
	       ST_RD_WR    :  begin
	                        Hreadyout = 1;
				next_state = ST_WWAIT;
			      end
	       ST_WRITE :       begin
			           Hreadyout = 0; 
			           next_state = ST_WENABLE ;
			      end

	       ST_WENABLEP : begin			
				Hreadyout = 1; 
		                 if(Hwritereg)
			           begin
			            if(valid)
			             next_state = ST_WRITEP;
				    else
				     next_state = ST_WRITE;
			          end
				else if(Hwrite_reg_d2)
				  next_state = ST_WRITE;
			        else 
				   begin
				    Hreadyout = 0;
			     	    next_state = ST_WENABLE ;
				   end
			   end
	     ST_WRITEP  :
			   begin
				Hreadyout = 0; 
	                        next_state = ST_WENABLEP ;
			   end
	     ST_WWAIT   :
			 begin
				Hreadyout = 1; 
				  begin
				   if(Hwrite & valid)
			            next_state = ST_WRITEP;
			           else if(~Hwrite | (Htrans == 0) | ~valid)
			            next_state = ST_WRITE;
				   else
				    next_state = ST_WRITEP;
				  end
			 end
          endcase
        end

   
     //Output logic for APB  
     always@(*)
         begin
	   if(~Hresetn)
	    {Penable,Pselx,Pwrite} = 0;
           else if(de_select_slave)
             Pselx = 0;
	   else
	    begin
	      case(pre_state)
                ST_IDLE : begin
		              {Penable,Pselx} = 0;
			       Pwrite         = 0; //Holding the previous values 
			  end
	        ST_READ :begin
			     Pwrite = 0; //Pwrite is made active low
			    {Penable,Pselx} = {1'b0,1'b0};
                            if(flag_timer)
			     Pselx[0] = 1;
			    else if(flag_interruptc)
			     Pselx[1] = 1;
			    else if(flag_remap_pause_controller)
			     Pselx[2] = 1;
                            else if(flag_slave4)
                             Pselx[3] = 1;
			 end
	       ST_RENABLE : begin
	                      Penable   = 1;
			      Pwrite    = Pwrite;    //Hold the previous values 
                            if(flag_timer)
			     Pselx[0] = 1;
			    else if(flag_interruptc)
			     Pselx[1] = 1;
			    else if(flag_remap_pause_controller)
			     Pselx[2] = 1;
                            else if(flag_slave4)
                             Pselx[3] = 1;
			    end

	       ST_WR_RD   : begin
	                     Penable = 0;
			     Pwrite  = 0;
                            if(flag_timer)
			     Pselx[0] = 1;
			    else if(flag_interruptc)
			     Pselx[1] = 1;
			    else if(flag_remap_pause_controller)
			     Pselx[2] = 1;
                            else if(flag_slave4)
                             Pselx[3] = 1;
			    end

	       ST_RD_WR   : begin
	                     Penable = 1;
			     Pwrite  = 0;
                            if(flag_timer)
			     Pselx[0] = 1;
			    else if(flag_interruptc)
			     Pselx[1] = 1;
			    else if(flag_remap_pause_controller)
			     Pselx[2] = 1;
                            else if(flag_slave4)
                             Pselx[3] = 1;
	                    end
	       ST_WWAIT   :begin
	                      Penable  = 0;
			      Pwrite   = 0; 
			      if(flag_timer)
			       Pselx[0] = 1;
			     else if(flag_interruptc)
			       Pselx[1] = 1;
			     else if(flag_remap_pause_controller)
			       Pselx[2] = 1;
                            else if(flag_slave4)
                               Pselx[3] = 1;
			   end
	       ST_WRITE   :begin
	                       Pwrite = 1;
			       Penable = 0;
			       Pselx = 0;
                            if(flag_timer)
			     Pselx[0] = 1;
			    else if(flag_interruptc)
			     Pselx[1] = 1;
			    else if(flag_remap_pause_controller)
			     Pselx[2] = 1;
                            else if(flag_slave4)
                             Pselx[3] = 1;
			   end
	       ST_WENABLE  : begin
	                      Penable = 1;
			      Pwrite  = Pwrite;  //Hold the previous values 
                              if(flag_timer)
			       Pselx[0] = 1;
			      else if(flag_interruptc)
			       Pselx[1] = 1;
			      else if(flag_remap_pause_controller)
			       Pselx[2] = 1;
                              else if(flag_slave4)
                               Pselx[3] = 1;
                             end
	       ST_WRITEP   :begin
	                        Pwrite = 1;
			        Penable = 0;
                                if(flag_timer)
			         Pselx[0] = 1;
			        else if(flag_interruptc)
			         Pselx[1] = 1;
			        else if(flag_remap_pause_controller)
			         Pselx[2] = 1;
                                else if(flag_slave4)
                                 Pselx[3] = 1;
                            end
              ST_WENABLEP  : begin
	                       Penable = 1;
			       Pwrite  = Pwrite;  //Hold the previous values 
                                if(flag_timer)
			         Pselx[0] = 1;
			        else if(flag_interruptc)
			         Pselx[1] = 1;
			        else if(flag_remap_pause_controller)
			         Pselx[2] = 1;
                                else if(flag_slave4)
                                 Pselx[3] = 1;
			     end
           
              default      :  begin
	                       Penable =  Penable; //Hold the previous values 
			       Pwrite  =  Pwrite;  //Hold the previous values 
			       Pselx   =  0;  //Hold the previous values
			      end
	      endcase
             end
          end
        
	endmodule        
	        
		            
		           

		 
	       
	        
	        
                
                 
                

	        
