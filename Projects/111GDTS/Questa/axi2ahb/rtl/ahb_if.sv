`timescale 1ns/10ps

interface ahb_if(input logic HCLK);

        logic HRESETn;
        logic HREADY;
        logic [1:0] HTRANS;
        logic [2:0] HBURST;
        logic [2:0] HSIZE;
        logic HWRITE;
        logic [31:0] HADDR;
        logic [31:0] HWDATA;
        logic [31:0] HRDATA;
        logic [1:0] HRESP;
	logic HGRANT;
	logic HMASTER;


             clocking sdrv_cb@(posedge HCLK);
                default input #1 output #0;

                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                output HREADY;
                output HRESP;
		output HRESETn;
		output HGRANT;
		output HMASTER;
                output negedge HRDATA;

        endclocking

        clocking smon_cb@(posedge HCLK);
                default input #1 output #0;

                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                input HREADY;
                input HRESP;
                input HRDATA;

        endclocking

        modport SDRV_MP(clocking sdrv_cb, input HRESETn);
        modport SMON_MP(clocking smon_cb, input HRESETn);

endinterface
