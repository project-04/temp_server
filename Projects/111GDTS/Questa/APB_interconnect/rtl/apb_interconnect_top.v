module apb_interconnect_top(
    input p_clk,
    input p_rst,
    input transfer,
    input write,
    input [31:0] addr,
    input [31:0] b_pw_data,
    output p_ready,
    output p_slverr, 
    output [31:0] pr_data);

    wire p_sel_m,p_enable_m,p_write_m,p_slvr_enable;
    wire [31:0] p_addr_m,p_addro;
    wire [3:0] p_slvr_sel;
    wire p_slvr_write;
    wire [31:0] p_slvr_pw_data;
    wire [3:0] p_slvr_ready;
    wire [3:0] p_slvr_slverr;
    wire [127:0] p_slvr_pr_data;
    wire p_ready_mi,pslv_err_mi;
    wire [31:0]pr_data_mi,pw_data_m;
    
  //  wire [31:0] pr_data;

apb_master master(p_clk,transfer,p_rst,addr,p_ready_mi,write,pslv_err_mi,b_pw_data,pr_data_mi,p_write_m,p_sel_m,p_enable_m,p_ready,p_slverr,p_addr_m,pw_data_m,pr_data);

apb_interconnect interconnects (p_write_m,p_enable_m,p_sel_m,p_slvr_ready,p_slvr_slverr,p_addr_m,pw_data_m,
				p_slvr_pr_data,p_slvr_enable,p_slvr_write,p_slvr_sel,p_slvr_pw_data,pr_data_mi,p_ready_mi,p_addro,pslv_err_mi);

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) 
     begin : slave_gen
        apb_slave slave(p_clk,p_rst,p_slvr_sel[i],p_slvr_enable,p_slvr_write,p_addro,p_slvr_pw_data,
			 p_slvr_pr_data[(i+1)*32-1:i*32],p_slvr_ready[i],p_slvr_slverr[i]);
     end
endgenerate

endmodule


