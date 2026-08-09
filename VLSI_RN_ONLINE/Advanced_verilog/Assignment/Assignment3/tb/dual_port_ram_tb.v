// `timescale 1ns/1ns
module dual_port_ram_tb();
  reg clock, reset, we, re;
  reg [3:0] wr_addr, rd_addr;
  reg [7:0] data_in;
  wire [7:0] data_out;
  
  reg [7:0] ref_mem [15:0];
  integer j;
  
  parameter THOLD  = 2,
  			TSETUP = 2,
  			CYCLE  = 20;
  
  dual_port_ram DUT(clock, reset, we, re, wr_addr, rd_addr, data_in, data_out);
  
  initial
    begin
      {clock, reset, we, re, wr_addr, rd_addr, data_in} = 0;
      while(1) #(CYCLE/2) clock = ~clock;
     end

  task rst();
    begin
      reset = 1'b1;
      repeat(3) @(posedge clock);
      #(THOLD);
      if(data_out !== 0)
        begin
          $display($time,"\t RESET IS FAILED");
          $stop; //Enter into debug mode
        end
      else
        $display($time,"\t RESET IS SUCCESS");
      for (j=0; j<16; j=j+1) ref_mem[j] = 0; // reset reference memory
      reset = 1'b0;
      #(CYCLE - THOLD - TSETUP);
    end
  endtask
  
  task stim_write(input [7:0] d_i, input [3:0] w_a, input e);
    begin
      data_in = d_i;
      wr_addr = w_a;
      we = e;
      @(posedge clock);
      #(THOLD);
      if (e) ref_mem[w_a] = d_i; // reference memory update
//       data_in = '0;
//       wr_addr = '0;
      we = 1'b0;
      #(CYCLE - THOLD - TSETUP);
    end
  endtask
  
  task stim_read(input [3:0] r_a, input e);
    begin
      rd_addr = r_a;
      re = e;
      @(posedge clock);
      #(THOLD);
      if(re && (data_out !== ref_mem[rd_addr]))
        begin
          $display($time,"\t DATA MISMATCH at location ",r_a);
          $stop; //Enter into debug mode
        end
      else if(re)
        $display($time,"\t READ IS SUCCESS at location ",r_a);
//       rd_addr = '0;
      re = 1'b0;
      #(CYCLE - THOLD - TSETUP);
    end
  endtask
  
  initial
    begin
      rst();
      repeat(50)
        begin
          stim_write($urandom%255, $urandom%16, 1'b1);
        end
        begin
          for (j=0; j<16; j=j+1) stim_read(j, 1'b1);
        end
      #100 $finish;
    end
      
  
//   initial begin
//     $monitor("%b %b %b %b %b %b %b %b ",clock, reset, we, re, wr_addr, rd_addr, data_in, data_out);
//   end

endmodule
