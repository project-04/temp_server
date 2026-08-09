interface apb_if(input bit clk);

    logic Preset_n;
    logic transfer;
    logic [31:0] Paddr;
    logic [31:0] Pwdata;
    logic [31:0] Prdata;
    logic Pwrite;
    logic pready;
    logic pslverr;
   

    clocking mdrv_cb @(posedge clk);
    default input #1 output #1;

    output Preset_n;
    output transfer;
    output Paddr;
    output Pwdata;
    output Pwrite;
    input pready;
    input Prdata;

    endclocking

    clocking mmon_cb @(posedge clk);
    default input #1 output #1;
   
    input Preset_n;
    input transfer; 
    input Pwrite;
    input Paddr;
    input Pwdata;
    input Prdata;
    input pready;
    input pslverr;
    
    endclocking

    clocking sdrv_cb @(posedge clk);
    default input #1 output #1;
    
    
    output Pwdata;
    input Pwrite;
    input pready;

    endclocking

    clocking smon_cb @(posedge clk);
    default input #1 output #1;

    input Prdata;
    input Pwdata;
    input Pwrite;
    input pready;

    endclocking


    modport MDR_MP (clocking mdrv_cb);
    modport MMON_MP (clocking mmon_cb);
    modport SDR_MP (clocking sdrv_cb);
    modport SMON_MP (clocking smon_cb);

endinterface
