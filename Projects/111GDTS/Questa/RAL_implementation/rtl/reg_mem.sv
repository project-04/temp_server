/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   peripheral_interface.sv

Description		:	RTL Design Module for Peripheral interface  

Author Name		:   Gangadhar G

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/

module reg_mem_block (
    input clk,
    input rst,

    input wr_en,              // Write enable
    input rd_en,              // Read enable
    input [3:0] addr,         // 4-bit address
    input [7:0] data_in,      // Data to write

    output reg [7:0] data_out // Data read
);

    // Register to store data
    reg [7:0] reg_data;

    // Memory: 16 x 8-bit
    reg [7:0] mem [0:15];

    // Write process
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_data <= 8'd0;
        end else if (wr_en) begin
            reg_data <= data_in;    // Store in register
            mem[addr] <= data_in;   // Store in memory
        end
    end

    // Read process
    always @(posedge clk) begin
        if (rd_en) begin
            data_out <= mem[addr];  // Read from memory
        end else begin
            data_out <= 8'd0;
        end
    end

endmodule

