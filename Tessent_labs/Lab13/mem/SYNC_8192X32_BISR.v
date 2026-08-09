`timescale 1ns/1ps
`celldefine

module SYNC_8192X32_BISR (
			CLK, CEB, WEB,
    	    	    	RSTB, SCLK, SDIN, SDOUT,
                        A, D, BWEB,
                        TSEL,
                        Q);

parameter numWord = 8192;
parameter numRow = 512;
parameter numCM = 16;
parameter numBit = 32;
parameter numWordAddr = 13;
parameter numRowAddr = 9;
parameter numCMAddr = 4;
parameter numSRSize = 10;

parameter Thold = 2.039;         
parameter tRSTBW = 5.000;
parameter preloadFile = "sram.preload.data";
parameter numStuckAt = 20;

//=== IO Ports ===//

			
// Normal Mode Input
input CLK;
input CEB;
input WEB;
input [12:0] A;
input [31:0] D;
input [31:0] BWEB;


// Data Output
output [31:0] Q;

// Serial Shift Register Data
input RSTB;
input SCLK;
input SDIN;
output SDOUT;

// Test Mode
input [1:0] TSEL;

// LV_pragma translate_off

//=== Internal Signals ===//

			
// Normal Mode Input
wire CLK_i;
wire CEB_i;
wire WEB_i;
wire [numWordAddr-1:0] A_i;
wire [numBit-1:0] D_i;
wire [numBit-1:0] BWEB_i;


// Data Output
wire [numBit-1:0] Q_i;

// Serial Shift Register Data
wire RSTB_i;
wire SCLK_i;
wire SDIN_i;
wire SDOUT_i;

// Test Mode
wire [1:0] TSEL_i;
wire TM_i, WLPTEST1_i, WLPTEST2_i;



//=== IO Buffers ===//

			
// Normal Mode Input
buf (CLK_i, CLK);
buf (CEB_i, CEB);
buf (WEB_i, WEB);
buf (A_i[0], A[0]);
buf (A_i[1], A[1]);
buf (A_i[2], A[2]);
buf (A_i[3], A[3]);
buf (A_i[4], A[4]);
buf (A_i[5], A[5]);
buf (A_i[6], A[6]);
buf (A_i[7], A[7]);
buf (A_i[8], A[8]);
buf (A_i[9], A[9]);
buf (A_i[10], A[10]);
buf (A_i[11], A[11]);
buf (A_i[12], A[12]);
buf (D_i[0], D[0]);
buf (D_i[1], D[1]);
buf (D_i[2], D[2]);
buf (D_i[3], D[3]);
buf (D_i[4], D[4]);
buf (D_i[5], D[5]);
buf (D_i[6], D[6]);
buf (D_i[7], D[7]);
buf (D_i[8], D[8]);
buf (D_i[9], D[9]);
buf (D_i[10], D[10]);
buf (D_i[11], D[11]);
buf (D_i[12], D[12]);
buf (D_i[13], D[13]);
buf (D_i[14], D[14]);
buf (D_i[15], D[15]);
buf (D_i[16], D[16]);
buf (D_i[17], D[17]);
buf (D_i[18], D[18]);
buf (D_i[19], D[19]);
buf (D_i[20], D[20]);
buf (D_i[21], D[21]);
buf (D_i[22], D[22]);
buf (D_i[23], D[23]);
buf (D_i[24], D[24]);
buf (D_i[25], D[25]);
buf (D_i[26], D[26]);
buf (D_i[27], D[27]);
buf (D_i[28], D[28]);
buf (D_i[29], D[29]);
buf (D_i[30], D[30]);
buf (D_i[31], D[31]);
buf (BWEB_i[0], BWEB[0]);
buf (BWEB_i[1], BWEB[1]);
buf (BWEB_i[2], BWEB[2]);
buf (BWEB_i[3], BWEB[3]);
buf (BWEB_i[4], BWEB[4]);
buf (BWEB_i[5], BWEB[5]);
buf (BWEB_i[6], BWEB[6]);
buf (BWEB_i[7], BWEB[7]);
buf (BWEB_i[8], BWEB[8]);
buf (BWEB_i[9], BWEB[9]);
buf (BWEB_i[10], BWEB[10]);
buf (BWEB_i[11], BWEB[11]);
buf (BWEB_i[12], BWEB[12]);
buf (BWEB_i[13], BWEB[13]);
buf (BWEB_i[14], BWEB[14]);
buf (BWEB_i[15], BWEB[15]);
buf (BWEB_i[16], BWEB[16]);
buf (BWEB_i[17], BWEB[17]);
buf (BWEB_i[18], BWEB[18]);
buf (BWEB_i[19], BWEB[19]);
buf (BWEB_i[20], BWEB[20]);
buf (BWEB_i[21], BWEB[21]);
buf (BWEB_i[22], BWEB[22]);
buf (BWEB_i[23], BWEB[23]);
buf (BWEB_i[24], BWEB[24]);
buf (BWEB_i[25], BWEB[25]);
buf (BWEB_i[26], BWEB[26]);
buf (BWEB_i[27], BWEB[27]);
buf (BWEB_i[28], BWEB[28]);
buf (BWEB_i[29], BWEB[29]);
buf (BWEB_i[30], BWEB[30]);
buf (BWEB_i[31], BWEB[31]);



// Data Output
nmos (Q[0], Q_i[0], 1'b1);
nmos (Q[1], Q_i[1], 1'b1);
nmos (Q[2], Q_i[2], 1'b1);
nmos (Q[3], Q_i[3], 1'b1);
nmos (Q[4], Q_i[4], 1'b1);
nmos (Q[5], Q_i[5], 1'b1);
nmos (Q[6], Q_i[6], 1'b1);
nmos (Q[7], Q_i[7], 1'b1);
nmos (Q[8], Q_i[8], 1'b1);
nmos (Q[9], Q_i[9], 1'b1);
nmos (Q[10], Q_i[10], 1'b1);
nmos (Q[11], Q_i[11], 1'b1);
nmos (Q[12], Q_i[12], 1'b1);
nmos (Q[13], Q_i[13], 1'b1);
nmos (Q[14], Q_i[14], 1'b1);
nmos (Q[15], Q_i[15], 1'b1);
nmos (Q[16], Q_i[16], 1'b1);
nmos (Q[17], Q_i[17], 1'b1);
nmos (Q[18], Q_i[18], 1'b1);
nmos (Q[19], Q_i[19], 1'b1);
nmos (Q[20], Q_i[20], 1'b1);
nmos (Q[21], Q_i[21], 1'b1);
nmos (Q[22], Q_i[22], 1'b1);
nmos (Q[23], Q_i[23], 1'b1);
nmos (Q[24], Q_i[24], 1'b1);
nmos (Q[25], Q_i[25], 1'b1);
nmos (Q[26], Q_i[26], 1'b1);
nmos (Q[27], Q_i[27], 1'b1);
nmos (Q[28], Q_i[28], 1'b1);
nmos (Q[29], Q_i[29], 1'b1);
nmos (Q[30], Q_i[30], 1'b1);
nmos (Q[31], Q_i[31], 1'b1);

// Serial Shift Register Data
buf (RSTB_i, RSTB);
buf (SCLK_i, SCLK);
buf (SDIN_i, SDIN);
nmos (SDOUT, SDOUT_i, 1'b1);

// Test Mode
buf (TSEL_i[0], TSEL[0]);
buf (TSEL_i[1], TSEL[1]);

//=== Data Structure ===//
reg [numBit-1:0] MEMORY[numRow-1:0][numCM-1:0];
reg RMEMORY[numRow-1:0];
reg [numBit-1:0] Q_d, Q_d1;
reg [numBit-1:0] PRELOAD[numWord-1:0];
reg [numSRSize-1:0] SHIFTREG;

reg [numBit-1:0] DIN_tmp, ERR_tmp;
reg [numWordAddr-1:0] stuckAt0Addr [numStuckAt:0];
reg [numWordAddr-1:0] stuckAt1Addr [numStuckAt:0];
reg [numBit-1:0] stuckAt0Bit [numStuckAt:0];
reg [numBit-1:0] stuckAt1Bit [numStuckAt:0];

integer i, j;
reg start_reset;

reg read_flag, write_flag, idle_flag;

reg notify_clk;
reg notify_bist;
reg notify_ceb;
reg notify_web;
reg notify_addr;
reg notify_din;
reg notify_bweb;
reg notify_rstb;
reg notify_sclk;
reg notify_sceb;
reg notify_sdin;

wire [numWordAddr-numCMAddr-1:0] iRowAddr = A_i[numWordAddr-1:numCMAddr];
wire [numCMAddr-1:0] iColAddr = A_i[numCMAddr-1:0];
wire iRSTB = RSTB_i;
wire iSCLK = SCLK_i;
wire iSDIN = SDIN_i;

wire check_read = read_flag;
wire check_write = write_flag;
wire check_noidle = ~idle_flag;

assign Q_i = Q_d;
assign SDOUT_i = SHIFTREG[numSRSize-1];

specify

    specparam tCYC = 2.367;
    specparam tCKH = 0.333;
    specparam tCKL = 0.441;
    specparam tCS = 0.393;
    specparam tCH = 0.000;
    specparam tWS = 0.346;
    specparam tWH = 0.000;
    specparam tAS = 0.417;
    specparam tAH = 0.000;
    specparam tDS = 0.386;
    specparam tDH = 0.000;
    specparam tBWS = 0.172;
    specparam tBWH = 0.000;
    specparam tCD = 2.286;
    specparam tHOLD = 2.039;
    

    specparam tRBW = 5.000;
    specparam tRBS = 0.748;
    specparam tSCYC = 2.367;
    specparam tSCKH = 0.333;
    specparam tSCKL = 0.441;
    specparam tSCS = 0.354;
    specparam tSCH = 0.000;
    specparam tSDS = 0.458;
    specparam tSDH = 0.000;
    specparam tSD = 0.406;
    specparam tRD = 0.170;



    (posedge CLK => (Q[0] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[1] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[2] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[3] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[4] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[5] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[6] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[7] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[8] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[9] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[10] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[11] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[12] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[13] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[14] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[15] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[16] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[17] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[18] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[19] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[20] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[21] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[22] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[23] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[24] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[25] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[26] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[27] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[28] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[29] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[30] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);
    (posedge CLK => (Q[31] : 1'bx)) = (tCD, tCD, tHOLD, tCD, tHOLD, tCD);

    (posedge SCLK => (SDOUT : 1'bx)) = (tSD, tSD);
    (negedge RSTB => (SDOUT : 1'bx)) = (tRD, tRD);

    
    $period(posedge CLK &&& check_noidle, tCYC, notify_clk);
    $width(posedge CLK &&& check_noidle, tCKH, 0, notify_clk);
    $width(negedge CLK &&& check_noidle, tCKL, 0, notify_clk);


    $setup(negedge CEB, posedge CLK, tCS, notify_ceb);
    $setup(posedge CEB, posedge CLK, tCS, notify_ceb);
    $hold(posedge CLK, negedge CEB, tCH, notify_ceb);
    $hold(posedge CLK, posedge CEB, tCH, notify_ceb);

    $setup(negedge WEB, posedge CLK &&& check_noidle, tWS, notify_web);
    $setup(posedge WEB, posedge CLK &&& check_noidle, tWS, notify_web);
    $hold(posedge CLK &&& check_noidle, negedge WEB, tWH, notify_web);
    $hold(posedge CLK &&& check_noidle, posedge WEB, tWH, notify_web);

    $setup(negedge A[0], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[1], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[2], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[3], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[4], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[5], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[6], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[7], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[8], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[9], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[10], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[11], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(negedge A[12], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[0], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[1], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[2], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[3], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[4], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[5], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[6], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[7], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[8], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[9], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[10], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[11], posedge CLK &&& check_noidle, tAS, notify_addr);
    $setup(posedge A[12], posedge CLK &&& check_noidle, tAS, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[0], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[1], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[2], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[3], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[4], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[5], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[6], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[7], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[8], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[9], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[10], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[11], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, negedge A[12], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[0], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[1], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[2], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[3], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[4], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[5], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[6], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[7], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[8], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[9], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[10], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[11], tAH, notify_addr);
    $hold(posedge CLK &&& check_noidle, posedge A[12], tAH, notify_addr);

    $setup(negedge D[0], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[1], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[2], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[3], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[4], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[5], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[6], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[7], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[8], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[9], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[10], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[11], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[12], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[13], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[14], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[15], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[16], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[17], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[18], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[19], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[20], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[21], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[22], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[23], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[24], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[25], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[26], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[27], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[28], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[29], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[30], posedge CLK &&& check_write, tDS, notify_din);
    $setup(negedge D[31], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[0], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[1], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[2], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[3], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[4], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[5], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[6], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[7], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[8], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[9], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[10], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[11], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[12], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[13], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[14], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[15], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[16], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[17], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[18], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[19], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[20], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[21], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[22], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[23], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[24], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[25], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[26], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[27], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[28], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[29], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[30], posedge CLK &&& check_write, tDS, notify_din);
    $setup(posedge D[31], posedge CLK &&& check_write, tDS, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[0], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[1], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[2], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[3], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[4], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[5], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[6], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[7], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[8], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[9], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[10], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[11], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[12], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[13], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[14], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[15], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[16], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[17], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[18], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[19], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[20], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[21], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[22], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[23], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[24], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[25], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[26], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[27], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[28], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[29], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[30], tDH, notify_din);
    $hold(posedge CLK &&& check_write, negedge D[31], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[0], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[1], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[2], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[3], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[4], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[5], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[6], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[7], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[8], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[9], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[10], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[11], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[12], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[13], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[14], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[15], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[16], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[17], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[18], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[19], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[20], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[21], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[22], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[23], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[24], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[25], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[26], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[27], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[28], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[29], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[30], tDH, notify_din);
    $hold(posedge CLK &&& check_write, posedge D[31], tDH, notify_din);

    $setup(negedge BWEB[0], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[1], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[2], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[3], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[4], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[5], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[6], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[7], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[8], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[9], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[10], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[11], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[12], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[13], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[14], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[15], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[16], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[17], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[18], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[19], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[20], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[21], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[22], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[23], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[24], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[25], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[26], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[27], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[28], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[29], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[30], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(negedge BWEB[31], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[0], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[1], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[2], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[3], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[4], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[5], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[6], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[7], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[8], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[9], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[10], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[11], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[12], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[13], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[14], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[15], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[16], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[17], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[18], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[19], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[20], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[21], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[22], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[23], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[24], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[25], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[26], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[27], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[28], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[29], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[30], posedge CLK &&& check_write, tBWS, notify_bweb);
    $setup(posedge BWEB[31], posedge CLK &&& check_write, tBWS, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[0], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[1], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[2], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[3], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[4], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[5], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[6], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[7], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[8], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[9], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[10], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[11], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[12], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[13], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[14], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[15], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[16], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[17], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[18], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[19], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[20], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[21], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[22], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[23], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[24], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[25], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[26], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[27], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[28], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[29], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[30], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, negedge BWEB[31], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[0], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[1], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[2], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[3], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[4], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[5], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[6], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[7], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[8], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[9], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[10], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[11], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[12], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[13], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[14], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[15], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[16], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[17], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[18], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[19], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[20], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[21], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[22], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[23], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[24], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[25], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[26], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[27], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[28], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[29], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[30], tBWH, notify_bweb);
    $hold(posedge CLK &&& check_write, posedge BWEB[31], tBWH, notify_bweb);




    $width(negedge RSTB, tRBW, 0, notify_rstb);
    $setup(posedge RSTB, posedge SCLK &&& idle_flag, tRBS, notify_rstb);
    $setup(negedge RSTB, posedge SCLK &&& idle_flag, tRBS, notify_rstb);
    
    $period(posedge SCLK, tSCYC, notify_sclk);
    $width(posedge SCLK, tSCKH, 0, notify_sclk);
    $width(negedge SCLK, tSCKL, 0, notify_sclk);

    $setup(negedge CEB, posedge SCLK, tSCS, notify_sceb);
    $setup(posedge CEB, posedge SCLK, tSCS, notify_sceb);
    $hold(posedge SCLK, negedge CEB, tSCH, notify_sceb);
    $hold(posedge SCLK, posedge CEB, tSCH, notify_sceb);


    $setup(negedge SDIN, posedge SCLK, tSDS, notify_sdin);
    $setup(posedge SDIN, posedge SCLK, tSDS, notify_sdin);
    $hold(posedge SCLK, negedge SDIN, tSDH, notify_sdin);
    $hold(posedge SCLK, posedge SDIN, tSDH, notify_sdin);

endspecify





initial begin

    start_reset = 0;

    read_flag = 0;
    write_flag = 0;
    idle_flag = 0;
    
    
    #0.001
    if (iRSTB === 1'b0) begin
    	start_reset = 1;
    end

end

always @(TSEL_i) begin
  if (TSEL_i !== 2'b01) begin
          `ifdef no_warning
	          `else
		          $display("\tWarning %m : input TSEL not keep 01 at simulation time %.1f\n", $realtime);
          `endif
  end
end


always @(posedge CLK_i) begin

    if (CEB_i === 1'b0) begin
    	idle_flag = 0;
        if (WEB_i === 1'b1) begin       // read
	    read_flag = 1;
	    if ( ^A_i === 1'bx ) begin
	        `ifdef no_warning
		`else
	    	$display("\tWarning %m : input A unknown/high-Z in read cycle at simulation time %.1f\n", $realtime);
		`endif
		Q_d1 = {numBit{1'bx}};
                xMemoryAll;
	    end
	    else if (A_i >= numWord) begin
	        `ifdef no_warning
		`else
	    	$display("\tWarning %m : address exceed word depth in read cycle at simulation time %.1f\n", $realtime);
		`endif
	    end
	    else begin
	    	if ( ^SHIFTREG === 1'bx ) begin
	            `ifdef no_warning
		    `else
		    $display("\tWarning %m : shift register content unknown/high-Z [%b] in read cycle at simulation time %.1f\n", SHIFTREG, $realtime);
		    `endif
		    Q_d1 = {numBit{1'bx}};
		end
		else begin
	    	    if (SHIFTREG[numSRSize-1] === 1'b1) begin // redundancy enabled
		    	if (iColAddr === SHIFTREG[numCMAddr-1:0]) begin	// column address matched
			    Q_d1 = MEMORY[iRowAddr][iColAddr];
			    Q_d1[decodeIO(SHIFTREG[numSRSize-2:numCMAddr])] = RMEMORY[iRowAddr];
			end
			else begin
			    Q_d1 = MEMORY[iRowAddr][iColAddr];
			end
		    end
		    else begin
		    	Q_d1 = MEMORY[iRowAddr][iColAddr];
		    end
		end
	    end
	end
	else if (WEB_i === 1'b0) begin	// write
	    write_flag = 1;
	    if ( ^A_i === 1'bx ) begin
	        `ifdef no_warning
		`else
	    	$display("\tWarning %m : input A unknown/high-Z in write cycle at simulation time %.1f\n", $realtime);
		`endif
		xMemoryAll;
	    end
	    else if (A_i >= numWord) begin
	        `ifdef no_warning
		`else
	    	$display("\tWarning %m : address exceed word depth in write cycle at simulation time %.1f\n", $realtime);
		`endif
	    end
	    else begin
	    	if ( ^SHIFTREG === 1'bx ) begin
	            `ifdef no_warning
		    `else
		    $display("\tWarning %m : shift register content unknown/high-Z [%b] in write cycle at simulation time %.1f\n", SHIFTREG, $realtime);
		    `endif
		    xMemoryAll;
		end
		else begin
		    if ( ^D_i === 1'bx ) begin
	                `ifdef no_warning
		        `else
		    	$display("\tWarning %m : input D unknown/high-Z in write cycle at simulation time %.1f\n", $realtime);
		        `endif
		    end
		    if ( ^BWEB_i === 1'bx ) begin
	                `ifdef no_warning
		        `else
		    	$display("\tWarning %m : input BWEB unknown/high-Z in write cycle at simulation time %.1f\n", $realtime);
			`endif
		    end
	    	    if (SHIFTREG[numSRSize-1] === 1'b1) begin // redundancy enabled
		    	if (iColAddr === SHIFTREG[numCMAddr-1:0]) begin	// column address matched
			    DIN_tmp = MEMORY[iRowAddr][iColAddr];
		    	    for (i = 0; i < numBit; i = i + 1) begin
			    	if (BWEB_i[i] === 1'b0) begin
				    if (i == decodeIO(SHIFTREG[numSRSize-2:numCMAddr])) begin
				    	RMEMORY[iRowAddr] = D_i[i];
				    end
				    else begin
				    	DIN_tmp[i] = D_i[i];
				    end
			    	end
			    	else if (BWEB_i[i] === 1'bx) begin
				    if (i == decodeIO(SHIFTREG[numSRSize-2:numCMAddr])) begin
				    	RMEMORY[iRowAddr] = 1'bx;
				    end
				    else begin
			    	    	DIN_tmp[i] = 1'bx;
				    end
			    	end
			    end
    	    	    	    if ( isStuckAt0(A_i) || isStuckAt1(A_i) ) begin
    	    	    	    	combineErrors(A_i, ERR_tmp);
    	    	    	    	for (j = 0; j < numBit; j = j + 1) begin
    	    	    	    	    if (ERR_tmp[j] === 1'b0) begin
    	    	    	    	    	DIN_tmp[j] = 1'b0;					
    	    	    	    	    end
    	    	    	    	    else if (ERR_tmp[j] === 1'b1) begin
    	    	    	    	    	DIN_tmp[j] = 1'b1;
    	    	    	    	    end
    	    	    	    	end
    	    	    	    end
			    MEMORY[iRowAddr][iColAddr] = DIN_tmp;
			end
			else begin // column addres does not match
		    	    DIN_tmp = MEMORY[iRowAddr][iColAddr];
		    	    for (i = 0; i < numBit; i = i + 1) begin
			    	if (BWEB_i[i] === 1'b0) begin
			    	    DIN_tmp[i] = D_i[i];
			    	end
			    	else if (BWEB_i[i] === 1'bx) begin
			    	    DIN_tmp[i] = 1'bx;
			    	end
			    end

    	    	    	    if ( isStuckAt0(A_i) || isStuckAt1(A_i) ) begin
    	    	    	    	combineErrors(A_i, ERR_tmp);
    	    	    	    	for (j = 0; j < numBit; j = j + 1) begin
    	    	    	    	    if (ERR_tmp[j] === 1'b0) begin
    	    	    	    	    	DIN_tmp[j] = 1'b0;					
    	    	    	    	    end
    	    	    	    	    else if (ERR_tmp[j] === 1'b1) begin
    	    	    	    	    	DIN_tmp[j] = 1'b1;
    	    	    	    	    end
    	    	    	    	end
    	    	    	    end

			    MEMORY[iRowAddr][iColAddr] = DIN_tmp;
			end
		    end
		    else begin
		    	DIN_tmp = MEMORY[iRowAddr][iColAddr];
		    	for (i = 0; i < numBit; i = i + 1) begin
			    if (BWEB_i[i] === 1'b0) begin
			    	DIN_tmp[i] = D_i[i];
			    end
			    else if (BWEB_i[i] === 1'bx) begin
			    	DIN_tmp[i] = 1'bx;
			    end
			end
    	    	    	if ( isStuckAt0(A_i) || isStuckAt1(A_i) ) begin
    	    	    	    combineErrors(A_i, ERR_tmp);

    	    	    	    for (j = 0; j < numBit; j = j + 1) begin
    	    	    	    	if (ERR_tmp[j] === 1'b0) begin
    	    	    	    	    DIN_tmp[j] = 1'b0;					
    	    	    	    	end
    	    	    	    	else if (ERR_tmp[j] === 1'b1) begin
    	    	    	    	    DIN_tmp[j] = 1'b1;
    	    	    	    	end
    	    	    	    end
    	    	    	end
    	    	    	
			MEMORY[iRowAddr][iColAddr] = DIN_tmp;
		    end
		end
	    end
	end
	else begin
            `ifdef no_warning
	    `else
    	    $display("\tWarning %m : input WEB unknown/high-Z at simulation time %.1f\n", $realtime);
	    `endif
	    if ( ^A_i === 1'bx ) begin
	    	Q_d1 = {numBit{1'bx}};
		xMemoryAll;
	    end
	    else begin
	    	Q_d1 = {numBit{1'bx}};
		xMemoryWord(A_i);
	    end
	end
    end
    else if (CEB_i === 1'b1) begin
    	idle_flag = 1;
    end
    else begin					
        `ifdef no_warning
        `else
    	$display("\tWarning %m : input CEB unknown/high-Z at simulation time %.1f\n", $realtime);
	`endif
	Q_d1 = {numBit{1'bx}};
	xMemoryAll;
    end


end

always @(posedge CLK_i) begin                                  
                                                       
    #(Thold);
    Q_d = {numBit{1'bx}};
    #(0.001);
    Q_d = Q_d1;
                      
end                        
                               
always @(CLK_i) begin

    if (CLK_i === 1'bx || CLK_i === 1'bz) begin
    	if (CEB_i !== 1'b1) begin
            `ifdef no_warning
            `else
    	    $display("\tWarning %m : input CLK unknown/high-Z at simulation time %.1f\n", $realtime);
	    `endif
	    Q_d1 = {numBit{1'bx}};
	    xMemoryAll;
	end
	read_flag = 0;
	write_flag = 0;
    end
    else if (CLK_i === 1'b0) begin
	read_flag = 0;
	write_flag = 0;
    end

end

always @(Q_d1) begin
    Q_d = Q_d1;
end

always @(iRSTB) begin

    if (iRSTB === 1'b0) begin
    	SHIFTREG = {numSRSize{1'b0}};
    end
    else if (iRSTB === 1'b1 && start_reset == 1 && $realtime < tRSTBW) begin
        `ifdef no_warning
        `else
    	$display("\tWarning %m : width of RSTB < tRBW at simulation time %.1f\n", $realtime);
	`endif
	SHIFTREG = {numSRSize{1'bx}};
    end
    else if (iRSTB === 1'bx || iRSTB === 1'bz) begin
        `ifdef no_warning
        `else
    	$display("\tWarning %m : input RSTB unknown/high-Z at simulation time %.1f\n", $realtime);
	`endif
	SHIFTREG = {numSRSize{1'bx}};
    end

end

always @(iSCLK) begin

    if (iRSTB !== 0) begin
        if (CEB_i === 1'b1) begin
      	     if (iSCLK === 1'b1) begin
      	       SHIFTREG[numSRSize-1:1] = SHIFTREG[numSRSize-2:0];
  	       SHIFTREG[0] = iSDIN;
      	     end
      	     else if (iSCLK === 1'bx || iSCLK === 1'bz) begin
               `ifdef no_warning
               `else
      	       $display("\tWarning %m : input SCLK unknown/high-Z at simulation time %.1f\n", $realtime);
	       `endif
	       SHIFTREG = {numSRSize{1'bx}};
	     end
	end
    end

end

always @(notify_clk) begin

    Q_d1 = {numBit{1'bx}};
    xMemoryAll;

end

always @(notify_bist) begin

    Q_d1 = {numBit{1'bx}};
    xMemoryAll;

end

always @(notify_ceb) begin

    Q_d1 = {numBit{1'bx}};
    xMemoryAll;
    read_flag = 0;
    write_flag = 0;

end

always @(notify_web) begin

    Q_d1 = {numBit{1'bx}};
    xMemoryAll;
    read_flag = 0;
    write_flag = 0;

end

always @(notify_addr) begin

    if (WEB_i === 1'b1) begin
    	Q_d1 = {numBit{1'bx}};
	xMemoryAll;
    end
    else if (WEB_i === 1'b0) begin
    	xMemoryAll;
    end
    else begin
    	Q_d1 = {numBit{1'bx}};
	xMemoryAll;
    end
    
    read_flag = 0;
    write_flag = 0;

end

always @(notify_din) begin

    if ( ^A_i === 1'bx ) begin
    	xMemoryAll;
    end
    else begin
    	xMemoryWord(A_i);
    end
    
    write_flag = 0;

end

always @(notify_bweb) begin

    if ( ^A_i === 1'bx ) begin
    	xMemoryAll;
    end
    else begin
    	xMemoryWord(A_i);
    end
    
    write_flag = 0;

end

always @(notify_rstb) begin

    SHIFTREG = {numSRSize{1'bx}};

end

always @(notify_sclk) begin

    SHIFTREG = {numSRSize{1'bx}};

end

always @(notify_sceb) begin

    SHIFTREG = {numSRSize{1'bx}};

end

always @(notify_sdin) begin

    SHIFTREG = {numSRSize{1'bx}};

end


function [numSRSize-numCMAddr-2:0] decodeIO;
input [numSRSize-numCMAddr-2:0] content;
reg [numSRSize-numCMAddr-2:0] io;
integer k, count;
begin
    decodeIO = content;
    
end
endfunction


task xMemoryAll;
reg [numRowAddr:0] row;
reg [numCMAddr:0] col;
begin
    for (row = 0; row < numRow; row = row + 1) begin
    	for (col = 0; col < numCM; col = col + 1) begin
    	    MEMORY[row][col] = {numBit{1'bx}};
	end
    end
end
endtask


task xMemoryWord;
input [numWordAddr-1:0] addr;
reg [numRowAddr-1:0] row;
reg [numCMAddr-1:0] col;
begin

    {row, col} = addr;
    MEMORY[row][col] = {numBit{1'bx}};

end
endtask


task preloadData;
reg [numWordAddr:0] w;
reg [numWordAddr-numCMAddr-1:0] row;
reg [numCMAddr-1:0] col;
begin

    $display("Preloading data from file %s", preloadFile);
    $readmemb(preloadFile, PRELOAD);

    for (w = 0; w < numWord; w = w + 1) begin
    	{row, col} = w;
    	MEMORY[row][col] = PRELOAD[w];
    end
 
end
endtask


/*
 * task injectSA - to inject a stuck-at error, please use hierarchical reference to call the injectSA task from the wrapper module
 *  	input addr - the address location where the defect is to be introduced
 *  	input bit - the bit location of the specified address where the defect is to occur
 *  	input type - specify whether it's a s-a-0 (type = 0) or a s-a-1 (type = 1) fault
 *
 *  	Multiple faults can be injected at the same address, regardless of the type.  This means that an address location can have 
 *  	certain bits having stuck-at-0 faults while other bits have the stuck-at-1 defect.
 *
 * Examples:
 *  	injectSA(0, 0, 0);  - injects a s-a-0 fault at address 0, bit 0
 *  	injectSA(1, 0, 1);  - injects a s-a-1 fault at address 1, bit 0
 *  	injectSA(1, 1, 0);  - injects a s-a-0 fault at address 1, bit 1
 *  	injectSA(1, 2, 1);  - injects a s-a-1 fault at address 1, bit 2
 *  	injectSA(1, 3, 1);  - injects a s-a-1 fault at address 1, bit 3
 *  	injectSA(2, 2, 1);  - injects a s-a-1 fault at address 2, bit 2
 *  	injectSA(14, 2, 0); - injects a s-a-0 fault at address 14, bit 2
 *
 */
task injectSA;
input [numWordAddr-1:0] addr;
input [numBit-1:0] bitn;
input typen;
reg [numStuckAt:0] i;
reg [numBit-1:0] btmp;
begin

    if ( typen == 0 ) begin
    
    	for (i = 0; i < numStuckAt; i = i + 1) begin
	
    	    if ( ^stuckAt0Addr[i] === 1'bx ) begin
	    	stuckAt0Addr[i] = addr;
		btmp = {numBit{1'bx}};
		btmp[bitn] = 1'b0;
		stuckAt0Bit[i] = btmp;
	    	i = numStuckAt;

		$display("First s-a-0 error injected at address location %d = %b", addr, btmp);
	    	i = numStuckAt;
	    end
	    else if ( stuckAt0Addr[i] === addr ) begin
	    	btmp = stuckAt0Bit[i];
		btmp[bitn] = 1'b0;
		stuckAt0Bit[i] = btmp;
		
		$display("More s-a-0 Error injected at address location %d = %b", addr, btmp);
	    	i = numStuckAt;
	    end	    
	end
	
    end
    else if (typen == 1) begin
    
    	for (i = 0; i < numStuckAt; i = i + 1) begin
	
    	    if ( ^stuckAt1Addr[i] === 1'bx ) begin
	    	stuckAt1Addr[i] = addr;
		btmp = {numBit{1'bx}};
		btmp[bitn] = 1'b1;
		stuckAt1Bit[i] = btmp;
	    	i = numStuckAt;

		$display("First s-a-1 error injected at address location %d = %b", addr, btmp);
	    	i = numStuckAt;
	    end
	    else if ( stuckAt1Addr[i] === addr ) begin
	    	btmp = stuckAt1Bit[i];
		btmp[bitn] = 1'b1;
		stuckAt1Bit[i] = btmp;
		
		$display("More s-a-1 Error injected at address location %d = %b", addr, btmp);
	    	i = numStuckAt;
	    end	    
	end
	
    end

end
endtask


task combineErrors;
input [numWordAddr-1:0] addr;
output [numBit-1:0] errors;
reg [numBit:0] j;
reg [numBit-1:0] btmp;
begin

    errors = {numBit{1'bx}};
    if ( isStuckAt0(addr) ) begin
	btmp = stuckAt0Bit[getStuckAt0Index(addr)];
    	for ( j = 0; j < numBit; j = j + 1 ) begin
	    if ( btmp[j] === 1'b0 ) begin
	    	errors[j] = 1'b0;
	    end
	end
    end
    if ( isStuckAt1(addr) ) begin
    	btmp = stuckAt1Bit[getStuckAt1Index(addr)];
    	for ( j = 0; j < numBit; j = j + 1 ) begin
	    if ( btmp[j] === 1'b1 ) begin
	    	errors[j] = 1'b1;
	    end
	end
    end

end
endtask


function [numStuckAt-1:0] getStuckAt0Index;
input [numWordAddr-1:0] addr;
reg [numStuckAt:0] i;
begin

    for (i = 0; i < numStuckAt; i = i + 1) begin
    
    	if (stuckAt0Addr[i] === addr) begin
	    getStuckAt0Index = i;
	end
    
    end

end
endfunction


function [numStuckAt-1:0] getStuckAt1Index;
input [numWordAddr-1:0] addr;
reg [numStuckAt:0] i;
begin

    for (i = 0; i < numStuckAt; i = i + 1) begin
    
    	if (stuckAt1Addr[i] === addr) begin
	    getStuckAt1Index = i;
	end
    
    end

end
endfunction


function isStuckAt0;
input [numWordAddr-1:0] addr;
reg [numStuckAt:0] i;
reg flag;
begin

    flag = 0;
    for (i = 0; i < numStuckAt; i = i + 1) begin

    	if (stuckAt0Addr[i] === addr) begin
    	    flag = 1;
	    i = numStuckAt;
	end

    end

    isStuckAt0 = flag;

end
endfunction


function isStuckAt1;
input [numWordAddr-1:0] addr;
reg [numStuckAt:0] i;
reg flag;
begin

    flag = 0;
    for (i = 0; i < numStuckAt; i = i + 1) begin

    	if (stuckAt1Addr[i] === addr) begin
	    flag = 1;
	    i = numStuckAt;
	end

    end

    isStuckAt1 = flag;

end
endfunction


task printMemory;
reg [numRowAddr:0] row;
reg [numCMAddr:0] col;
begin

    $display("\n\nDumping memory content at %.1f...\n", $realtime);
    
    for (row = 0; row < numRow; row = row + 1) begin
    	for (col = 0; col < numCM; col = col + 1) begin
    	    $display("[%d] = %b", {row, col}, MEMORY[row][col]);
	end
    end    
    
    $display("\n\n");
    
end
endtask


task printMemoryFromTo;
input [numWordAddr-1:0] addr1;
input [numWordAddr-1:0] addr2;
reg [numWordAddr:0] addr;
reg [numRowAddr-1:0] row;
reg [numCMAddr-1:0] col;
begin

    $display("\n\nDumping memory content at %.1f...\n", $realtime);
    
    for (addr = addr1; addr < addr2; addr = addr + 1) begin
    	{row, col} = addr;
    	$display("[%d] = %b", addr, MEMORY[row][col]);
    end    
    
    $display("\n\n");
    
end
endtask


task printRMemory;
reg [numRowAddr:0] row;
begin

    $display("\n\nDumping redundancy memory content at %.1f...\n", $realtime);
    
    for (row = 0; row < numRow; row = row + 1) begin
    	$display("[%d] = %b", {row}, RMEMORY[row]);
    end    
    
    $display("\n\n");
    
end
endtask


task printShiftReg;
begin
    $display("\n\nDumping shift register content at %.1f\n", $realtime);
    $display("%b\n\n", SHIFTREG);
end
endtask

// LV_pragma translate_on

endmodule
`endcelldefine