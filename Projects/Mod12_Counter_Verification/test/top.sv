module check_assertion(input clk, up, reset_n, load, [3:0]data_in, [3:0] data_out);

   property reset_n_prop;
          @(posedge clk)
  
          reset_n |=> data_out==0;
   endproperty
  
   /*property load_and_data_in_prop;
          @(posedge clk) disable iff(reset_n)
  
          load |=> data_out==$past(data_in,1);
   endproperty*/
  
   property load_and_data_in_prop;
        int past_data_in;

        //@(posedge clk) disable iff(reset_n)
        @(posedge clk) if (!reset_n)

        ($rose(load),past_data_in = data_in) |=> data_out == past_data_in;
        //(load == 1,past_data_in = data_in) |=> data_out == past_data_in;
        //(load,past_data_in = data_in) |=> data_out == past_data_in;
 endproperty

 reset_n_ckeck:         assert property(reset_n_prop)
                        $display("%0d reset_n Assertions Pass",$time);
                else
                        $display("%0d reset_n Assertions Fail",$time);

 load_and_data_in_check: assert property(load_and_data_in_prop)
                                $display("%0d load_and_data_in Assertions Pass",$time);
                        else
                                $display("%0d load_and_data_in Assertions Fail",$time);

name1 : cover property(reset_n_prop);
name2 : cover property(load_and_data_in_prop);
endmodule


module top;
  import uvm_pkg::*; 
  `include "uvm_macros.svh"
  
  import counter_test_pkg::*;

  logic clk0 = 0;

  always #10 clk0 = ~clk0;    // 50 MHz


  counter_if vif0(clk0);

  mod12counter mod12counter0(
      .clk	(clk0),
      .up  	(vif0.up),
      .reset_n  (vif0.reset_n),
      .load     (vif0.load),
      .data_in  (vif0.data_in),
      .data_out (vif0.data_out)
  );

check_assertion check_assertion0(
      .clk      (clk0),
      .up       (vif0.up),
      .reset_n  (vif0.reset_n),
      .load     (vif0.load),
      .data_in  (vif0.data_in),
      .data_out (vif0.data_out)
  );

  initial begin
  	`ifdef VCS
         	$fsdbDumpvars(0, top);
         	//$fsdbDumpSVA;
        `endif
        		
      	uvm_config_db#(virtual counter_if)::set(null, "*", "counter_if0", vif0);

	uvm_top.set_report_verbosity_level(UVM_MEDIUM);
        uvm_top.set_report_verbosity_level(UVM_NONE);
        
      	run_test();
  end

endmodule
