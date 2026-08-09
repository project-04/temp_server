module tb();
  reg [7:0] data_in;
  reg clk, rstn, push, pop;
  wire [7:0] data_out;
  wire fifo_empty, fifo_full;
  wire [4:0] count;
  
  reg [7:0] ref_memory[15:0];
  reg [3:0] ref_ip_count, ref_op_count;
  integer i;
  parameter THOLD  = 2,
  			TSETUP = 2,
  			CYCLE  = 20;

  uart_fifo DUT(
    .data_in(data_in),
    .clk(clk),
    .rstn(rstn),
    .push(push),
    .pop(pop),
    .data_out(data_out),
    .fifo_empty(fifo_empty),
    .fifo_full(fifo_full),
    .count(count));
  
  initial
    begin
      {data_in,clk,rstn,push,pop} = 0;
      while(1) #(CYCLE/2) clk = ~clk;
     end
  
  // Reset
  task res();
    begin
      $display("reset stated");
      rstn = 1'b0;
      repeat(3) @(posedge clk);
      #(THOLD);
      if(data_out !== 0 && fifo_empty !== 1 && fifo_full !== 0 && count !== 0)
        $display($time,"\t RESET IS FAILED");
      else
        $display($time,"\t RESET IS SUCCESS");
      ref_ip_count = 4'b0;
      ref_op_count = 4'b0;
      rstn = 1'b1;
      #(CYCLE - THOLD - TSETUP);
      $display("reset ended");
    end
  endtask
  
  // Write
  task wri(input pu, input [7:0] d_i);
    begin
      data_in = d_i;
      push = pu;
      @(posedge clk);
      #(THOLD);
      if (push && !fifo_full)
        begin
          ref_memory[ref_ip_count] <= data_in;
          ref_ip_count <= ref_ip_count + 1'b1;
          $display($time,"\t WRITE IS SUCCESS");
        end
      push = 1'b0;
      #(CYCLE - THOLD - TSETUP);
    end
  endtask
  
  // Read
  task rea(input po);
    begin
      //if (pop && !fifo_empty)
        begin
          if(data_out !== ref_memory[ref_op_count])
            $display($time,"\t DATA MISMATCH");
          else
            begin
              $display($time,"\t READ IS SUCCESS");
              ref_op_count <= ref_op_count + 1'b1;
            end
        end
      pop = po;
      @(posedge clk);
      #(THOLD);
      pop = 1'b0;
      #(CYCLE - THOLD - TSETUP);
    end
  endtask
  
initial 
  begin
    //$dumpfile("dump.fsdb");
    //$dumpvars(0, uart_fifo_tb);
    
    res();
    
    $display("Writing data start");
    for(i=0; i<=20; i=i+1) 
    begin
      wri(1'b1,{$random}%255);
      if (i>=10) rea(1'b1);
    end
    $display("Writing data end");
    
    $display("Reading data start");
    for(i=0; i<=20; i=i+1)
      rea(1'b1);
    $display("Reading data end");
    #10 $finish;
  end
  
  initial $monitor($time,"\t fifo_full=%b, fifo_empty=%b", fifo_full, fifo_empty);

endmodule
