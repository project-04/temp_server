//qverilog ../coverage_inst.sv -R -c -do "log -r/*; run -all; coverage report -details; exit"

//vcs -full64 -l comp.log -sverilog -debug_access+all -kdb file_name.sv
//./simv -a vcs.log -cm_dir ./cov1 +ntb_random_seed=4137323363
//urg -dir cov1.vdb -format both -report urgReport
//vi urgReport/grp*.txt
//verdi -cov -covdir cov1.vdb

//vcs -full64 -l comp.log -sverilog -debug_access+all -kdb file_name.sv; ./simv -a vcs.log -cm_dir ./cov1 +ntb_random_seed=12345; urg -dir cov1.vdb -format both -report urgReport; cat urgReport/grpinfo.txt

module counter(input clk, rst, en, output reg [3:0] count);
    always @(posedge clk) begin
        if (rst) count <= 0;
        else if (en) count <= count + 1;
    end
endmodule

class Monitor;
    virtual interface cnt_if vif;
    int id;

    covergroup cg;
        option.per_instance = 1;                  // track coverage per instance  
        option.auto_bin_max = 6;                  // limit implicit bins to 6
        option.at_least = 2;                   // bin needs 2 hits to count as covered
      
        cp_count: coverpoint vif.count;
      
        cp_en: coverpoint vif.en {  
          
            bins zero_to_one = (0 => 1);           // transition bin
        }
    endgroup

    function new(virtual cnt_if vif, int id);
        this.vif = vif;
        this.id  = id;
        cg = new();
    endfunction

    task run();
        forever begin
            @(posedge vif.clk);
            $display("count = %0d", vif.count);
            cg.sample();
        end
    endtask
endclass

interface cnt_if(input clk);
    logic rst, en;
    logic [3:0] count;
endinterface

module tb3;
    bit clk;
    always #5 clk = ~clk;

    cnt_if vif1(clk), vif2(clk);
    counter duv1(clk, vif1.rst, vif1.en, vif1.count);
    counter duv2(clk, vif2.rst, vif2.en, vif2.count);
    Monitor mon1, mon2;

    initial begin
        mon1 = new(vif1, 1);
        mon2 = new(vif2, 2);
        fork
            mon1.run();
            #100 mon2.run();
        join_none

        vif1.rst = 1; vif1.en = 0;
        vif2.rst = 1; vif2.en = 0;
        @(posedge clk); @(posedge clk);
        vif1.rst = 0; vif1.en = 1;
        vif2.rst = 0; vif2.en = 1;

        repeat (20) @(posedge clk);   // enough cycles to wrap 0->15->0 at least twice

        $display("---- inst1 coverage = %0.2f %%", mon1.cg.get_inst_coverage());
        $display("---- inst2 coverage = %0.2f %%", mon2.cg.get_inst_coverage());
        $finish;
    end
endmodule
