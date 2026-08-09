/*
module uart_fifo(
  input [7:0] data_in,
  input clk, rstn, push, pop,
  output reg [7:0] data_out,
  output wire fifo_empty, fifo_full,
  output reg [4:0] count
);

  reg [7:0] memory [15:0];
  reg [3:0] ip_count, op_count; //writer_pointer, read_pointer
  
  // Write
  always @(posedge clk)
    begin
      if (!rstn)
        begin
          ip_count <= 4'd0;
        end
      else if (push && !fifo_full)
        begin
          memory[ip_count] <= data_in;
          ip_count <= ip_count + 1'b1;
        end
    end

  // Read 
  always @(posedge clk) 
    begin
      if (!rstn)
        begin
          data_out <= 8'd0;
          op_count <= 4'd0;
        end
      else if (pop && !fifo_empty) 
        begin
          data_out <= memory[op_count];
          op_count <= op_count + 1'b1;
        end
    end

  // Count
  always @(posedge clk) 
    begin
      if (!rstn)
        begin
          count <= 5'd0;
        end
      else
        begin
          case ({push, pop})
            2'b01: if (!fifo_empty) count <= count - 1'b1; // pop only
            2'b10: if (!fifo_full)  count <= count + 1'b1; // push only
            2'b11: count <= count; // push & pop
            default: count <= count;
          endcase
        end
    end

  // Status flags
  assign fifo_full  = (count == 5'd16);
  assign fifo_empty = (count == 5'd0);

endmodule
*/



module uart_fifo (
  			input clk,
  			input rstn,
  			input push,
  			input pop,
  			input [7:0] data_in,
  			output reg fifo_empty,
  			output reg fifo_full,
  			output reg[4:0] count,
  			output reg[7:0] data_out
		);

   reg[3:0] ip_count;
   reg[3:0] op_count;

   reg [7:0] data_fifo[15:0];

   integer i;

   always @(posedge clk)
     begin
       if(rstn == 1'b0) 
	 begin
      	   count <= 1'b0;
      	   ip_count <= 1'b0;
      	   op_count <= 1'b0;
      	   for(i=0;i<16;i=i+1) 
	     begin
               data_fifo[i] <= 8'b0;
      	     end
    	 end
       else 
	 begin
      	   case({push, pop})
             2'b01 : 
	       begin
                 if(count > 0) 
		   begin
                     op_count <= op_count + 1;
                     count <= count - 1;
                   end
               end
             2'b10 : 
	       begin
                 if(count <= 5'hf) 
		   begin
                     ip_count <= ip_count + 1;
                     data_fifo[ip_count] <= data_in;
                     count <= count + 1;
                   end
               end
             2'b11 : 
	       begin
                 op_count <= op_count + 1;
                 ip_count <= ip_count + 1;
                 data_fifo[ip_count] <= data_in;
               end
      	   endcase
    	 end
     end

   always@(*)
     data_out = data_fifo[op_count];
   
   always@(*)
     fifo_empty = ~(|count);
   
   always@(*)
     fifo_full = (count == 5'b10000);
 
 endmodule
 
 
 

