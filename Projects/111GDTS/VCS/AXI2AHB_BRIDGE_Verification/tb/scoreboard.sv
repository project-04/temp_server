/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       scoreboard.sv   

module Name             :       scoreboard

Description             :       Scoreboard for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)

   uvm_tlm_analysis_fifo#(axi_rst_trans) fifo_axi_rst_h[];
   uvm_tlm_analysis_fifo#(ahb_rst_trans) fifo_ahb_rst_h[];
   uvm_tlm_analysis_fifo#(axi_trans) fifo_axi_h[];
   uvm_tlm_analysis_fifo#(ahb_trans) fifo_ahb_h[];
   uvm_tlm_analysis_fifo#(axi_trans) fifo_axi_wdata_h[];
   uvm_tlm_analysis_fifo#(axi_trans) fifo_axi_rdata_h[];

   axi_trans wdata[$],rdata[$];

   axi_rst_trans axi_rst_xtn;
   axi_rst_trans axi_rst_cov_data;
   ahb_rst_trans ahb_rst_xtn;
   ahb_rst_trans ahb_rst_cov_data;
	
   axi_trans axi_xtn,axi_wdata,axi_rdata;
   axi_trans axi_cov_data;
	
   ahb_trans ahb_cov_data;
   ahb_trans ahb_xtn;

   environment_config env_cfg;

   covergroup axi_rst_cg;
     option.per_instance=1;
     CP_A_RESETN : coverpoint axi_rst_cov_data.aresetn{ 
							 bins RST[]={0,1};
						       }
   endgroup
   covergroup ahb_rst_cg;
     option.per_instance=1;
     CP_H_RESETN : coverpoint ahb_rst_cov_data.hresetn{ 
							 bins RST[]={0,1};
						      }
   endgroup
   covergroup axi_cg;
     option.per_instance=1;
     CP_AW_ID : coverpoint axi_cov_data.awid {
						bins low ={[0:50]};
						bins mid1={[51:100]};
						bins mid2={[101:150]};
						bins mid3={[151:200]};
						bins high={[201:255]};
					     }
     CP_AW_ADDR : coverpoint axi_cov_data.awaddr {
						    bins first_slave = {[32'h0000_0000:32'h4444_4444]};
						    bins second_slave ={[32'h4444_4445: 32'h8888_8888]};
						    bins third_slave = {[32'h8888_8889:32'hcccc_cccc]};
						    bins fourth_slave ={[32'hcccc_cccd:32'hffff_ffff]};
						 }

     CP_AWLEN : coverpoint axi_cov_data.awlen { bins AW_LEN[] ={[1:15]};}
     CP_AWSIZE : coverpoint axi_cov_data.awsize { bins AW_SIZE[] ={0,1,2,3};}
     CP_AWBURST : coverpoint axi_cov_data.awburst {bins AW_BURST[] ={[0:2]};}
     CP_AWVALID : coverpoint axi_cov_data.awvalid{bins AW_VALID[]={0,1};}
     CP_AWREADY : coverpoint axi_cov_data.awready{bins AW_READY[]={0,1};}
     CP_AWLENXAWSIZE : cross CP_AWLEN,CP_AWSIZE;
     CP_AWREADYXAWVALID : cross CP_AWREADY,CP_AWVALID;		
     CP_AWLENXAWSIZEXAWADDR : cross CP_AWLEN,CP_AWSIZE,CP_AW_ADDR;

     CP_W_ID : coverpoint axi_cov_data.wid {
                                              bins low ={[0:50]};
                                              bins mid1={[51:100]};
                                              bins mid2={[101:150]};
                                              bins mid3={[151:200]};
                                              bins high={[201:255]};
                                           }
     CP_W_LAST : coverpoint axi_cov_data.wlast{bins W_LAST[]={0,1};}
     CP_WVALID : coverpoint axi_cov_data.wvalid{bins W_VALID[]={0,1};}
     CP_WREADY : coverpoint axi_cov_data.wready{bins W_READY[]={0,1};}
     //CP_WREADYXWDATA:cross CP_WREADY,CP_W_DATA;
     CP_WREADYXWVALID : cross CP_WREADY,CP_WVALID;
     CP_B_ID : coverpoint axi_cov_data.bid {
                                             bins low ={[0:50]};
                                             bins mid1={[51:100]};
                                             bins mid2={[101:150]};
                                             bins mid3={[151:200]};
                                             bins high={[201:255]};
                                           }
     CP_BRESP : coverpoint axi_cov_data.wvalid{bins B_BRESP[]={0,1};}
     CP_BVALID : coverpoint axi_cov_data.wvalid{bins B_VALID[]={0,1};}
     CP_BREADY : coverpoint axi_cov_data.wvalid{bins B_READY[]={0,1};}
     CP_BREADYXBVALID : cross CP_BREADY,CP_BVALID;		

     CP_AR_ID : coverpoint axi_cov_data.arid {
                                               bins low ={[0:50]};
                                               bins mid1={[51:100]};
                                               bins mid2={[101:150]};
                                               bins mid3={[151:200]};
                                               bins high={[201:255]};
                                             }
     CP_AR_ADDR : coverpoint axi_cov_data.araddr {
                                                    bins first_slave = {[32'h0000_0000:32'h4444_4444]};
                                                    bins second_slave ={[32'h4444_4445: 32'h8888_8888]};
                                                    bins third_slave = {[32'h8888_8889:32'hcccc_cccc]};
                                                    bins fourth_slave ={[32'hcccc_cccd:32'hffff_ffff]};
                                                  }
     CP_ARLEN : coverpoint axi_cov_data.arlen {bins AR_LEN[] ={[1:15]};}
     CP_ARSIZE : coverpoint axi_cov_data.arsize {bins AR_SIZE[] ={0,1,2,3};}
     CP_ARBURST : coverpoint axi_cov_data.arburst {bins AR_BURST[] ={[0:2]};}
     CP_ARVALID : coverpoint axi_cov_data.arvalid{bins AR_VALID[]={0,1};}
     CP_ARREADY : coverpoint axi_cov_data.arready{bins AR_READY[]={0,1};}
     CP_ARLENXARSIZE : cross CP_ARLEN,CP_ARSIZE;
     CP_ARLENXARSIZEXARADDR : cross CP_ARLEN,CP_ARSIZE,CP_AR_ADDR;
     CP_ARREADYXARVALID : cross CP_ARREADY,CP_ARVALID;

     CP_R_ID : coverpoint axi_cov_data.rid {
                                             bins low ={[0:50]};
                                             bins mid1={[51:100]};
                                             bins mid2={[101:150]};
                                             bins mid3={[151:200]};
                                             bins high={[201:255]};
                                           }
     CP_R_LAST : coverpoint axi_cov_data.rlast{bins R_LAST[]={0,1};}
     CP_RVALID : coverpoint axi_cov_data.rvalid{bins R_VALID[]={0,1};}
     CP_RREADY : coverpoint axi_cov_data.rready{bins R_READY[]={0,1};}
     //CP_RREADYXRDATA:cross CP_RREADY,CP_R_DATA;
     CP_RREADYXRVALID : cross CP_RREADY,CP_RVALID;
   endgroup
   covergroup axi_wdata_dyn_cg with function sample(int i);
     CP_W_DATA:coverpoint axi_cov_data.wdata[i] {
						  bins low = {[64'h0000_0000_0000_0000:64'h4444_4444_4444_4444]};
						  bins mid1 ={[64'h4444_4444_4444_4445: 64'h8888_8888_8888_8888]};
						  bins mid2 = {[64'h8888_8888_8888_8889:64'hcccc_cccc_cccc_cccc]};
						  bins high ={[64'hcccc_cccc_cccc_cccd:64'hffff_ffff_ffff_ffff]};
						}
     CP_W_STRB:coverpoint axi_cov_data.wstrb[i] {
						   bins W_STRB[] ={1,2,4, 8,16,32,64,128,3, 12,48,192,15,240,255};
						 }
   endgroup
   covergroup axi_rdata_dyn_cg with function sample(int i);
     CP_R_DATA:coverpoint axi_cov_data.rdata[i] {
                                                  bins low = {[64'h0000_0000_0000_0000:64'h4444_4444_4444_4444]};
                                                  bins mid1 ={[64'h4444_4444_4444_4445: 64'h8888_8888_8888_8888]};
                                                  bins mid2 = {[64'h8888_8888_8888_8889:64'hcccc_cccc_cccc_cccc]};
                                                  bins high ={[64'hcccc_cccc_cccc_cccd:64'hffff_ffff_ffff_ffff]};
                                                }
     CP_RRESP:coverpoint axi_cov_data.rresp[i] {
                                                 bins RRESP[] ={0,1};
                                               }
   endgroup
   covergroup ahb_cg;
     option.per_instance=1;
     CP_HADDR : coverpoint ahb_cov_data.haddr {
                                                bins first_slave = {[32'h0000_0000:32'h4444_4444]};
                                                bins second_slave ={[32'h4444_4445: 32'h8888_8888]};
                                                bins third_slave = {[32'h8888_8889:32'hcccc_cccc]};
                                                bins fourth_slave ={[32'hcccc_cccd:32'hffff_ffff]};
                                              }
     CP_HWRITE : coverpoint ahb_cov_data.hwrite{bins HWRITE[]={0,1};}
     CP_HSIZE : coverpoint ahb_cov_data.hsize {bins H_SIZE[] ={0,1,2,3};}
     CP_HREADY : coverpoint ahb_cov_data.hready {bins H_READY[]={0,1};}
     CP_HRESP : coverpoint ahb_cov_data.hresp {bins H_RESP[]={0,1};}
     CP_HWDATA : coverpoint ahb_cov_data.hwdata {
						  bins low = {[64'h0000_0000_0000_0000:64'h4444_4444_4444_4444]};
						  bins mid1 ={[64'h4444_4444_4444_4445: 64'h8888_8888_8888_8888]};
						  bins mid2 = {[64'h8888_8888_8888_8889:64'hcccc_cccc_cccc_cccc]};
						  bins high ={[64'hcccc_cccc_cccc_cccd:64'hffff_ffff_ffff_ffff]};
					        }
     CP_HRDATA : coverpoint ahb_cov_data.hrdata {
						  bins low = {[64'h0000_0000_0000_0000:64'h4444_4444_4444_4444]};
						  bins mid1 ={[64'h4444_4444_4444_4445: 64'h8888_8888_8888_8888]};
						  bins mid2 = {[64'h8888_8888_8888_8889:64'hcccc_cccc_cccc_cccc]};
						  bins high ={[64'hcccc_cccc_cccc_cccd:64'hffff_ffff_ffff_ffff]};
						}
   endgroup
   extern function new(string name="scoreboard", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task axi_rst_check(axi_rst_trans axi_rst_xtn);
   extern task ahb_rst_check(ahb_rst_trans ahb_rst_xtn);
   extern task data_compare(ahb_trans ahb_xtn);
 endclass
 //----------------------------- new -----------------------
 function scoreboard::new(string name="scoreboard", uvm_component parent);
   super.new(name,parent);
   axi_cg=new();
   axi_rst_cg=new();
   ahb_cg=new();
   ahb_rst_cg=new();
   axi_wdata_dyn_cg=new();
   axi_rdata_dyn_cg=new();
 endfunction
 //---------------------------- build phase -----------------------
 function void scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(environment_config)::get(this,"","environment_config",env_cfg)) 
     `uvm_fatal(get_type_name(),"confgiuration is not set properly")
   fifo_axi_rst_h=new[env_cfg.no_of_axi_rst_agent];
   fifo_ahb_rst_h=new[env_cfg.no_of_ahb_rst_agent];
   fifo_axi_h=new[env_cfg.no_of_axi_agent];
   fifo_axi_wdata_h=new[env_cfg.no_of_axi_agent];
   fifo_axi_rdata_h=new[env_cfg.no_of_axi_agent];
   fifo_ahb_h=new[env_cfg.no_of_ahb_agent];
   foreach(fifo_axi_rst_h[i])
     fifo_axi_rst_h[i]=new($sformatf("fifo_axi_rst_h[%0d]",i),this);
   foreach(fifo_ahb_rst_h[i])
     fifo_ahb_rst_h[i]=new($sformatf("fifo_ahb_rst_h[%0d]",i),this);
   foreach(fifo_axi_h[i])
     fifo_axi_h[i]=new($sformatf("fifo_axi_h[%0d]",i),this);
   foreach(fifo_axi_wdata_h[i])
     fifo_axi_wdata_h[i]=new($sformatf("fifo_axi_wdata_h[%0d]",i),this);
   foreach(fifo_axi_rdata_h[i])
     fifo_axi_rdata_h[i]=new($sformatf("fifo_axi_rdata_h[%0d]",i),this);
   foreach(fifo_ahb_h[i])
     fifo_ahb_h[i]=new($sformatf("fifo_ahb_h[%0d]",i),this);
 endfunction
 //------------------------- run_phase --------------------------
 task scoreboard::run_phase(uvm_phase phase);
   fork
     begin
       forever
	 begin
	   fifo_axi_rst_h[0].get(axi_rst_xtn);
	   axi_rst_check(axi_rst_xtn);
	   axi_rst_cov_data=new axi_rst_xtn;
	   axi_rst_cg.sample();
 	 end
     end
     begin
       forever
	 begin
	   fifo_ahb_rst_h[0].get(ahb_rst_xtn);
	   ahb_rst_check(ahb_rst_xtn);
	   ahb_rst_cov_data=new ahb_rst_xtn;
	   ahb_rst_cg.sample();
	 end
     end
     begin
       forever
	 begin
	   fifo_axi_h[0].get(axi_xtn);
	   axi_cov_data=new axi_xtn;
	   axi_cg.sample();
	   foreach(axi_cov_data.wdata[i])
	     axi_wdata_dyn_cg.sample(i);
           foreach(axi_cov_data.rdata[i])
             axi_rdata_dyn_cg.sample(i);
         end
     end
     begin
       forever
	 begin
           fifo_ahb_h[0].get(ahb_xtn);
	   ahb_cov_data=new ahb_xtn;
	   data_compare(ahb_xtn);
	   ahb_cg.sample();
	 end
     end
     begin
       forever
	 begin
	   fifo_axi_wdata_h[0].get(axi_wdata);
	   wdata.push_back(axi_wdata);
	 end
     end
     begin
       forever
	 begin
	   fifo_axi_rdata_h[0].get(axi_rdata);
	   rdata.push_back(axi_rdata);
	 end
     end	
   join
 endtask
 //---------------------- axi_rst_check ----------------------
 task scoreboard::axi_rst_check(axi_rst_trans axi_rst_xtn);
   if(axi_rst_xtn.aresetn==1'b0)
     begin
       if(axi_rst_xtn.bvalid==1'b0 && axi_rst_xtn.rvalid==1'b0)
	 `uvm_info(get_type_name(),"axi reset operation is successful",UVM_LOW)
       else 
	 `uvm_error(get_type_name(),"axi reset operation is not successful")
     end
 endtask
 //--------------------- ahb_rst_check -----------------------
 task scoreboard::ahb_rst_check(ahb_rst_trans ahb_rst_xtn);
   if(ahb_rst_xtn.hresetn==1'b0)
     begin
       if(ahb_rst_xtn.htrans==2'b00)
	 `uvm_info(get_type_name(),"ahb reset operation successful",UVM_LOW)
       else 
	 `uvm_error(get_type_name(),"ahb reset operation not successful");
     end
 endtask
 //---------------------data compare ------------------------
 task scoreboard::data_compare(ahb_trans ahb_xtn);
   axi_trans axi_xtn;
   if(ahb_xtn.hwrite==1)
     begin
       wait(wdata.size!=0);
       axi_xtn=wdata.pop_front();
       if(axi_xtn.temp_wdata==ahb_xtn.hwdata)
         begin
	   `uvm_info(get_type_name(),"data is matched",UVM_LOW)
	   `uvm_info(get_type_name(),$sformatf("axi_temp_wdata: %0d , ahb_hwdata: %0d",axi_xtn.temp_wdata,ahb_xtn.hwdata),UVM_LOW)
         end
       else
	 begin
	   `uvm_error(get_type_name(),"data is mismatched")
           `uvm_error(get_type_name(),$sformatf("axi_temp_wdata: %0d , ahb_hwdata: %0d",axi_xtn.temp_wdata,ahb_xtn.hwdata))
         end
     end
   else
     begin
       wait(rdata.size!=0);
       axi_xtn=rdata.pop_front();
       if(axi_xtn.temp_rdata==ahb_xtn.hrdata)
         begin
	   `uvm_info(get_type_name(),"data is matched",UVM_LOW)
           `uvm_info(get_type_name(),$sformatf("axi_temp_rdata: %0d , ahb_hrdata: %0d",axi_xtn.temp_rdata,ahb_xtn.hrdata),UVM_LOW)
	 end
       else
         begin
	   `uvm_error(get_type_name(),"data is mismatched")
           `uvm_error(get_type_name(),$sformatf("axi_temp_rdata: %0d , ahb_hrdata: %0d",axi_xtn.temp_rdata,ahb_xtn.hrdata))
	 end
     end
 endtask 
