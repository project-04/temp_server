class axi_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(axi_scoreboard)

	// Properties
	// analysis FIFO Declaration
	uvm_tlm_analysis_fifo #(axi_xtn) fifo_mast[];
	uvm_tlm_analysis_fifo #(axi_xtn) fifo_slv[];
	axi_env_config m_cfg; 

	//Declare the Handle for axi_xtn
	axi_xtn axi_mast_data;
	axi_xtn axi_slv_data;

	axi_xtn mast_xtn;
	//axi_xtn slv_xtn;

	// Declare the Handles for Master and Slave Coverage Data
	axi_xtn mast_cov_data0;
	axi_xtn slv_cov_data0; 

	axi_xtn mast_cov_data1;
	axi_xtn slv_cov_data1;
 
	axi_xtn mast_cov_data2;
	axi_xtn slv_cov_data2;
  
       
	axi_xtn mast_cov_data3;
	axi_xtn slv_cov_data3; 
	//Define a queue to push data of Master to compare with Slave
	axi_xtn q1[$];	

	int data_verified_count;

	//Covergroup for Master
	covergroup master_covgrp0;
		option.per_instance = 1;
	
		RESET: coverpoint mast_cov_data0.rst1 {bins rst[] ={0,1};}

		AW_ID :   coverpoint mast_cov_data0.AWID {bins AWID1 ={[0:31]};
		                                         bins AWID2 ={[32:63]};
		                                         bins AWID3 ={[64:127]};
                                                         bins AWID4={[128:255]};}

		AW_ADDR: coverpoint mast_cov_data0.AWADDR{ bins first_slave = {[32'h0000_0000:32'h00ff_ffff]};
							bins second_slave ={[32'h0100_0000: 32'h01ff_ffff]};
							bins third_slave = {[32'h0200_0000:32'h02ff_ffff]};
							bins fourth_slave ={[32'h0300_0000:32'h03ff_ffff]};}

		AW_LENGTH: coverpoint mast_cov_data0.AWLEN {bins AWLEN1 ={[0:31]};
		                                           bins AWLEN2 ={[32:63]};
		                                           bins AWLEN3 ={[63:127]};
		                                           bins AWLEN4 ={[127:255]}; }

		AW_BURST_SIZE: coverpoint mast_cov_data0.AWSIZE {bins AWSIZE[] ={0,1,2};}
		AW_BURST_TYPE: coverpoint mast_cov_data0.AWBURST {bins AWBURST[] ={[0:2]};}
                AW_LOCK:coverpoint mast_cov_data0.AWLOCK{bins AWLOCK[]={[0:1]};}
                AW_CACHE:coverpoint mast_cov_data0.AWCACHE{bins AWCACHE[]={[0:15]};}
                AW_PROT:coverpoint mast_cov_data0.AWPROT{bins AWPROT[]={[0:7]};}
                AW_QOS:coverpoint mast_cov_data0.AWQOS{bins AWQOS[]={[0:15]};}
                AW_REGION:coverpoint mast_cov_data0.AWREGION{bins AWREGION[]={[0:1]};}
                AW_USER:coverpoint mast_cov_data0.AWUSER{bins AWUSER[]={[0:1]};}
                AW_VALID:coverpoint mast_cov_data0.AWVALID{bins AWVALID[]={[0:1]};}
                AW_READY:coverpoint mast_cov_data0.AWREADY{bins AWREADY[]={[0:1]};}

                W_LAST:coverpoint mast_cov_data0.WLAST {bins WLAST[]={[0:1]};}
                W_USER:coverpoint mast_cov_data0.WUSER {bins WUSER[]={[0:1]};}
		W_ID :   coverpoint mast_cov_data0.WID {bins WID1 ={[0:31]};
		                                       bins WID2 ={[32:63]};
		                                       bins WID3 ={[64:127]};
                                                       bins WID4 ={[128:255]};}
                W_VALID:coverpoint mast_cov_data0.WVALID {bins WVALID[]={[0:1]};}
                W_READY:coverpoint mast_cov_data0.WREADY {bins WREADY[]={[0:1]};}

                
		B_ID :   coverpoint mast_cov_data0.BID {bins BID1 ={[0:31]};
		                                       bins BID2 ={[32:63]};
		                                       bins BID3 ={[64:127]};
                                                       bins BID4 ={[128:255]};}
                B_BUSER:coverpoint mast_cov_data0.BUSER {bins BUSER[]={[0:1]};}
                B_VALID:coverpoint mast_cov_data0.BVALID {bins BVALID[]={[0:1]};}
                B_READY:coverpoint mast_cov_data0.BREADY {bins BREADY[]={[0:1]};}
                B_RESP : coverpoint mast_cov_data0.BRESP { bins BRESP[] ={[0:3]};}
             
                

               // Cross Bins
		AW_LEN_X_AW_BURST_SIZE: cross AW_LENGTH, AW_BURST_SIZE;
                AW_VALID_X_AW_READY:cross AW_VALID,AW_READY;
                W_VALID_X_W_READY:cross W_VALID,W_READY;
                W_VALID_X_W_READY_X_W_LAST:cross W_VALID,W_READY,W_LAST;
                B_VALID_X_B_READY:cross B_VALID,B_READY;
//              	W_LEN_X_W_ADDR_X_B_SIZE: cross AW_LENGTH, AW_BURST_SIZE, AW_ADDR;
	endgroup

	covergroup mast_dyn_covgrp0 with function sample(int i);
		WRITE_DATA: coverpoint mast_cov_data0.WDATA[i] {bins low = {[32'h0000_0000:32'h4444_4444]};
							bins mid1 ={[32'h4444_4445: 32'h8888_8888]};
							bins mid2 = {[32'h8888_8889:32'hcccc_cccc]};
							bins high ={[32'hcccc_cccd:32'hffff_ffff]};}
		W_STROBE: coverpoint mast_cov_data0.WSTRB[i] {bins W_STRB[] ={1, 2, 3, 4, 8, 12, 14, 15};}
	endgroup

	covergroup slave_covgrp0;
		option.per_instance = 1;
		
	
		
	        AR_ID :   coverpoint slv_cov_data0.ARID {bins ARID1 ={[0:31]};
		                                        bins ARID2 ={[32:63]};
		                                        bins ARID3 ={[64:127]};
                                                        bins ARID4 ={[128:255]};}
	
              
                
		AR_ADDR: coverpoint slv_cov_data0.ARADDR{bins first_slave = {[32'h 0000_0000:32'h 00ff_ffff]};
							bins second_slave ={[32'h 0100_0000:32'h 01ff_ffff]};
							bins third_slave = {[32'h 0200_0000:32'h 02ff_ffff]};
							bins fourth_slave ={[32'h 0300_0000:32'h 03ff_ffff]};}

		AR_LENGTH: coverpoint slv_cov_data0.ARLEN{bins ARLEN1 ={[0:31]};
		                                         bins ARLEN2 ={[31:63]};
		                                         bins ARLEN3 ={[64:127]};
		                                         bins ARLEN4 ={[127:255]};}

		AR_BURST_SIZE: coverpoint slv_cov_data0.ARSIZE{bins ARSIZE[] ={0, 1, 2};}
		AR_BURST_TYPE: coverpoint slv_cov_data0.ARBURST {bins ARBURST[] ={0, 1, 2}; }
		AR_LOCK: coverpoint slv_cov_data0.ARLOCK{bins ARLOCK[] ={[0:1]}; }
		AR_CACHE: coverpoint slv_cov_data0.ARCACHE {bins ARCACHE[] ={[0:15]};}
		AR_PROT: coverpoint slv_cov_data0.ARPROT {bins ARPROT[] ={[0:7]};}
		AR_QOS: coverpoint slv_cov_data0.ARQOS {bins ARQOS[] ={[0:15]};}
		AR_USER: coverpoint slv_cov_data0.ARUSER {bins ARUSER[] ={[0:1]};}
		AR_VALID: coverpoint slv_cov_data0.ARVALID{bins ARVALID[] ={[0:1]};}
		AR_READY: coverpoint slv_cov_data0.ARREADY{bins ARREADY[] ={[0:1]};}
      
                R_ID :   coverpoint slv_cov_data0.RID {bins RID1 ={[0:31]};
		                                      bins RID2 ={[32:63]};
		                                      bins RID3 ={[64:127]};
                                                      bins RID4 ={[128:255]};}

		R_LAST: coverpoint slv_cov_data0.RLAST{bins RLAST[] ={[0:1]};}
		R_USER: coverpoint slv_cov_data0.RUSER{bins RUSER[] ={[0:1]};}
		R_VALID: coverpoint slv_cov_data0.RVALID{bins RVALID[] ={[0:1]};}
		R_READY: coverpoint slv_cov_data0.RREADY{bins RREADY[] ={[0:1]};}

               // Cross Bins
              
		AR_LEN_X_AR_BURST_SIZE: cross AR_LENGTH, AR_BURST_SIZE;
                AR_VALID_X_AR_READY:cross AR_VALID,AR_READY;
                R_VALID_X_R_READY:cross R_VALID,R_READY;
                R_VALID_X_R_READY_X_R_LAST:cross R_VALID,R_READY,R_LAST;
              //  R_LEN_X_R_ADDR_X_B_SIZE: cross AR_LENGTH, AR_BURST_SIZE, AR_ADDR;

	endgroup 

	covergroup slv_dyn_covgrp0 with function sample(int i);
		READ_DATA: coverpoint slv_cov_data0.RDATA[i]  {bins low = {[32'h0000_0000:32'hffff_ffff]};}
		READ_RESP: coverpoint slv_cov_data0.RRESP[i] {bins R_RESP[]={[0:3]};}
	endgroup

      	covergroup master_covgrp1;
		option.per_instance = 1;
	
		RESET: coverpoint mast_cov_data1.rst1 {bins rst[] ={0,1};}

		AW_ID :   coverpoint mast_cov_data1.AWID {bins AWID1 ={[0:31]};
		                                         bins AWID2 ={[32:63]};
		                                         bins AWID3 ={[64:127]};
                                                         bins AWID4={[128:255]};}

		AW_ADDR: coverpoint mast_cov_data1.AWADDR{ bins first_slave = {[32'h0000_0000:32'h00ff_ffff]};
							bins second_slave ={[32'h0100_0000: 32'h01ff_ffff]};
							bins third_slave = {[32'h0200_0000:32'h02ff_ffff]};
							bins fourth_slave ={[32'h0300_0000:32'h03ff_ffff]};}

		AW_LENGTH: coverpoint mast_cov_data1.AWLEN {bins AWLEN1 ={[0:31]};
		                                           bins AWLEN2 ={[32:63]};
		                                           bins AWLEN3 ={[63:127]};
		                                           bins AWLEN4 ={[127:255]}; }

		AW_BURST_SIZE: coverpoint mast_cov_data1.AWSIZE {bins AWSIZE[] ={0,1,2};}
		AW_BURST_TYPE: coverpoint mast_cov_data1.AWBURST {bins AWBURST[] ={[0:2]};}
                AW_LOCK:coverpoint mast_cov_data1.AWLOCK{bins AWLOCK[]={[0:1]};}
                AW_CACHE:coverpoint mast_cov_data1.AWCACHE{bins AWCACHE[]={[0:15]};}
                AW_PROT:coverpoint mast_cov_data1.AWPROT{bins AWPROT[]={[0:7]};}
                AW_QOS:coverpoint mast_cov_data1.AWQOS{bins AWQOS[]={[0:15]};}
                AW_REGION:coverpoint mast_cov_data1.AWREGION{bins AWREGION[]={[0:1]};}
                AW_USER:coverpoint mast_cov_data1.AWUSER{bins AWUSER[]={[0:1]};}
                AW_VALID:coverpoint mast_cov_data1.AWVALID{bins AWVALID[]={[0:1]};}
                AW_READY:coverpoint mast_cov_data1.AWREADY{bins AWREADY[]={[0:1]};}

                W_LAST:coverpoint mast_cov_data1.WLAST {bins WLAST[]={[0:1]};}
                W_USER:coverpoint mast_cov_data1.WUSER {bins WUSER[]={[0:1]};}
		W_ID :   coverpoint mast_cov_data1.WID {bins WID1 ={[0:31]};
		                                       bins WID2 ={[32:63]};
		                                       bins WID3 ={[64:127]};
                                                       bins WID4 ={[128:255]};}
                W_VALID:coverpoint mast_cov_data1.WVALID {bins WVALID[]={[0:1]};}
                W_READY:coverpoint mast_cov_data1.WREADY {bins WREADY[]={[0:1]};}

                
		B_ID :   coverpoint mast_cov_data1.BID {bins BID1 ={[0:31]};
		                                       bins BID2 ={[32:63]};
		                                       bins BID3 ={[64:127]};
                                                       bins BID4 ={[128:255]};}
                B_BUSER:coverpoint mast_cov_data1.BUSER {bins BUSER[]={[0:1]};}
                B_VALID:coverpoint mast_cov_data1.BVALID {bins BVALID[]={[0:1]};}
                B_READY:coverpoint mast_cov_data1.BREADY {bins BREADY[]={[0:1]};}
                B_RESP : coverpoint mast_cov_data1.BRESP { bins BRESP[] ={[0:3]};}
             
                

               // Cross Bins
		AW_LEN_X_AW_BURST_SIZE: cross AW_LENGTH, AW_BURST_SIZE;
                W_VALID_X_W_READY_X_W_LAST:cross W_VALID,W_READY,W_LAST;
                AW_VALID_X_AW_READY:cross AW_VALID,AW_READY;
                W_VALID_X_W_READY:cross W_VALID,W_READY;
                B_VALID_X_B_READY:cross B_VALID,B_READY;
               //	W_LEN_X_W_ADDR_X_B_SIZE: cross AW_LENGTH, AW_BURST_SIZE, AW_ADDR;
	endgroup

	covergroup mast_dyn_covgrp1 with function sample(int i);
		WRITE_DATA: coverpoint mast_cov_data1.WDATA[i] {bins low = {[32'h0000_0000:32'h4444_4444]};
							bins mid1 ={[32'h4444_4445: 32'h8888_8888]};
							bins mid2 = {[32'h8888_8889:32'hcccc_cccc]};
							bins high ={[32'hcccc_cccd:32'hffff_ffff]};}
		W_STROBE: coverpoint mast_cov_data1.WSTRB[i] {bins W_STRB[] ={1, 2, 3, 4, 8, 12, 14, 15};}
	endgroup

	covergroup slave_covgrp1;
		option.per_instance = 1;
		
	
		
	        AR_ID :   coverpoint slv_cov_data1.ARID {bins ARID1 ={[0:31]};
		                                        bins ARID2 ={[32:63]};
		                                        bins ARID3 ={[64:127]};
                                                        bins ARID4 ={[128:255]};}
	
              
                
		AR_ADDR: coverpoint slv_cov_data1.ARADDR{bins first_slave = {[32'h 0000_0000:32'h 00ff_ffff]};
							bins second_slave ={[32'h 0100_0000:32'h 01ff_ffff]};
							bins third_slave = {[32'h 0200_0000:32'h 02ff_ffff]};
							bins fourth_slave ={[32'h 0300_0000:32'h 03ff_ffff]};}

		AR_LENGTH: coverpoint slv_cov_data1.ARLEN{bins ARLEN1 ={[0:31]};
		                                         bins ARLEN2 ={[31:63]};
		                                         bins ARLEN3 ={[64:127]};
		                                         bins ARLEN4 ={[127:255]};}

		AR_BURST_SIZE: coverpoint slv_cov_data1.ARSIZE{bins ARSIZE[] ={0, 1, 2};}
		AR_BURST_TYPE: coverpoint slv_cov_data1.ARBURST {bins ARBURST[] ={0, 1, 2}; }
		AR_LOCK: coverpoint slv_cov_data1.ARLOCK{bins ARLOCK[] ={[0:1]}; }
		AR_CACHE: coverpoint slv_cov_data1.ARCACHE {bins ARCACHE[] ={[0:15]};}
		AR_PROT: coverpoint slv_cov_data1.ARPROT {bins ARPROT[] ={[0:7]};}
		AR_QOS: coverpoint slv_cov_data1.ARQOS {bins ARQOS[] ={[0:15]};}
		AR_USER: coverpoint slv_cov_data1.ARUSER {bins ARUSER[] ={[0:1]};}
		AR_VALID: coverpoint slv_cov_data1.ARVALID{bins ARVALID[] ={[0:1]};}
		AR_READY: coverpoint slv_cov_data1.ARREADY{bins ARREADY[] ={[0:1]};}
      
                R_ID :   coverpoint slv_cov_data1.RID {bins RID1 ={[0:31]};
		                                      bins RID2 ={[32:63]};
		                                      bins RID3 ={[64:127]};
                                                      bins RID4 ={[128:255]};}

		R_LAST: coverpoint slv_cov_data1.RLAST{bins RLAST[] ={[0:1]};}
		R_USER: coverpoint slv_cov_data1.RUSER{bins RUSER[] ={[0:1]};}
		R_VALID: coverpoint slv_cov_data1.RVALID{bins RVALID[] ={[0:1]};}
		R_READY: coverpoint slv_cov_data1.RREADY{bins RREADY[] ={[0:1]};}

               // Cross Bins
              
		AR_LEN_X_AR_BURST_SIZE: cross AR_LENGTH, AR_BURST_SIZE;
                AR_VALID_X_AR_READY:cross AR_VALID,AR_READY;
                R_VALID_X_R_READY:cross R_VALID,R_READY;
                R_VALID_X_R_READY_X_R_LAST:cross R_VALID,R_READY,R_LAST;
               // R_LEN_X_R_ADDR_X_B_SIZE: cross AR_LENGTH, AR_BURST_SIZE, AR_ADDR;

	endgroup 
	covergroup slv_dyn_covgrp1 with function sample(int i);
		READ_DATA: coverpoint slv_cov_data1.RDATA[i]  {bins low = {[32'h0000_0000:32'hffff_ffff]};}
		READ_RESP: coverpoint slv_cov_data1.RRESP[i] {bins R_RESP[]={[0:3]};}
	endgroup

     	covergroup master_covgrp2;
		option.per_instance = 1;
	
		RESET: coverpoint mast_cov_data2.rst1 {bins rst[] ={0,1};}

		AW_ID :   coverpoint mast_cov_data2.AWID {bins AWID1 ={[0:31]};
		                                         bins AWID2 ={[32:63]};
		                                         bins AWID3 ={[64:127]};
                                                         bins AWID4={[128:255]};}

		AW_ADDR: coverpoint mast_cov_data2.AWADDR{ bins first_slave = {[32'h0000_0000:32'h00ff_ffff]};
							bins second_slave ={[32'h0100_0000: 32'h01ff_ffff]};
							bins third_slave = {[32'h0200_0000:32'h02ff_ffff]};
							bins fourth_slave ={[32'h0300_0000:32'h03ff_ffff]};}

		AW_LENGTH: coverpoint mast_cov_data2.AWLEN {bins AWLEN1 ={[0:31]};
		                                           bins AWLEN2 ={[32:63]};
		                                           bins AWLEN3 ={[63:127]};
		                                           bins AWLEN4 ={[127:255]}; }

		AW_BURST_SIZE: coverpoint mast_cov_data2.AWSIZE {bins AWSIZE[] ={0,1,2};}
		AW_BURST_TYPE: coverpoint mast_cov_data2.AWBURST {bins AWBURST[] ={[0:2]};}
                AW_LOCK:coverpoint mast_cov_data2.AWLOCK{bins AWLOCK[]={[0:1]};}
                AW_CACHE:coverpoint mast_cov_data2.AWCACHE{bins AWCACHE[]={[0:15]};}
                AW_PROT:coverpoint mast_cov_data2.AWPROT{bins AWPROT[]={[0:7]};}
                AW_QOS:coverpoint mast_cov_data2.AWQOS{bins AWQOS[]={[0:15]};}
                AW_REGION:coverpoint mast_cov_data2.AWREGION{bins AWREGION[]={[0:1]};}
                AW_USER:coverpoint mast_cov_data2.AWUSER{bins AWUSER[]={[0:1]};}
                AW_VALID:coverpoint mast_cov_data2.AWVALID{bins AWVALID[]={[0:1]};}
                AW_READY:coverpoint mast_cov_data2.AWREADY{bins AWREADY[]={[0:1]};}

                W_LAST:coverpoint mast_cov_data2.WLAST {bins WLAST[]={[0:1]};}
                W_USER:coverpoint mast_cov_data2.WUSER {bins WUSER[]={[0:1]};}
		W_ID :   coverpoint mast_cov_data2.WID {bins WID1 ={[0:31]};
		                                       bins WID2 ={[32:63]};
		                                       bins WID3 ={[64:127]};
                                                       bins WID4 ={[128:255]};}
                W_VALID:coverpoint mast_cov_data2.WVALID {bins WVALID[]={[0:1]};}
                W_READY:coverpoint mast_cov_data2.WREADY {bins WREADY[]={[0:1]};}

                
		B_ID :   coverpoint mast_cov_data2.BID {bins BID1 ={[0:31]};
		                                       bins BID2 ={[32:63]};
		                                       bins BID3 ={[64:127]};
                                                       bins BID4 ={[128:255]};}
                B_BUSER:coverpoint mast_cov_data2.BUSER {bins BUSER[]={[0:1]};}
                B_VALID:coverpoint mast_cov_data2.BVALID {bins BVALID[]={[0:1]};}
                B_READY:coverpoint mast_cov_data2.BREADY {bins BREADY[]={[0:1]};}
                B_RESP : coverpoint mast_cov_data2.BRESP { bins BRESP[] ={[0:3]};}
             
                

               // Cross Bins
		AW_LEN_X_AW_BURST_SIZE: cross AW_LENGTH, AW_BURST_SIZE;
                AW_VALID_X_AW_READY:cross AW_VALID,AW_READY;
                W_VALID_X_W_READY:cross W_VALID,W_READY;
                W_VALID_X_W_READY_X_W_LAST:cross W_VALID,W_READY,W_LAST;
                B_VALID_X_B_READY:cross B_VALID,B_READY;
               //	W_LEN_X_W_ADDR_X_B_SIZE: cross AW_LENGTH, AW_BURST_SIZE, AW_ADDR;
	endgroup

	covergroup mast_dyn_covgrp2 with function sample(int i);
		WRITE_DATA: coverpoint mast_cov_data2.WDATA[i] {bins low = {[32'h0000_0000:32'h4444_4444]};
							bins mid1 ={[32'h4444_4445: 32'h8888_8888]};
							bins mid2 = {[32'h8888_8889:32'hcccc_cccc]};
							bins high ={[32'hcccc_cccd:32'hffff_ffff]};}
		W_STROBE: coverpoint mast_cov_data2.WSTRB[i] {bins W_STRB[] ={1, 2, 3, 4, 8, 12, 14, 15};}
	endgroup

	covergroup slave_covgrp2;
		option.per_instance = 1;
		
	
		
	        AR_ID :   coverpoint slv_cov_data2.ARID {bins ARID1 ={[0:31]};
		                                        bins ARID2 ={[32:63]};
		                                        bins ARID3 ={[64:127]};
                                                        bins ARID4 ={[128:255]};}
	
              
                
		AR_ADDR: coverpoint slv_cov_data2.ARADDR{bins first_slave = {[32'h 0000_0000:32'h 00ff_ffff]};
							bins second_slave ={[32'h 0100_0000:32'h 01ff_ffff]};
							bins third_slave = {[32'h 0200_0000:32'h 02ff_ffff]};
							bins fourth_slave ={[32'h 0300_0000:32'h 03ff_ffff]};}

		AR_LENGTH: coverpoint slv_cov_data2.ARLEN{bins ARLEN1 ={[0:31]};
		                                         bins ARLEN2 ={[31:63]};
		                                         bins ARLEN3 ={[64:127]};
		                                         bins ARLEN4 ={[127:255]};}

		AR_BURST_SIZE: coverpoint slv_cov_data2.ARSIZE{bins ARSIZE[] ={0, 1, 2};}
		AR_BURST_TYPE: coverpoint slv_cov_data2.ARBURST {bins ARBURST[] ={0, 1, 2}; }
		AR_LOCK: coverpoint slv_cov_data2.ARLOCK{bins ARLOCK[] ={[0:1]}; }
		AR_CACHE: coverpoint slv_cov_data2.ARCACHE {bins ARCACHE[] ={[0:15]};}
		AR_PROT: coverpoint slv_cov_data2.ARPROT {bins ARPROT[] ={[0:7]};}
		AR_QOS: coverpoint slv_cov_data2.ARQOS {bins ARQOS[] ={[0:15]};}
		AR_USER: coverpoint slv_cov_data2.ARUSER {bins ARUSER[] ={[0:1]};}
		AR_VALID: coverpoint slv_cov_data2.ARVALID{bins ARVALID[] ={[0:1]};}
		AR_READY: coverpoint slv_cov_data2.ARREADY{bins ARREADY[] ={[0:1]};}
      
                R_ID :   coverpoint slv_cov_data2.RID {bins RID1 ={[0:31]};
		                                      bins RID2 ={[32:63]};
		                                      bins RID3 ={[64:127]};
                                                      bins RID4 ={[128:255]};}

		R_LAST: coverpoint slv_cov_data2.RLAST{bins RLAST[] ={[0:1]};}
		R_USER: coverpoint slv_cov_data2.RUSER{bins RUSER[] ={[0:1]};}
		R_VALID: coverpoint slv_cov_data2.RVALID{bins RVALID[] ={[0:1]};}
		R_READY: coverpoint slv_cov_data2.RREADY{bins RREADY[] ={[0:1]};}

               // Cross Bins
              
		AR_LEN_X_AR_BURST_SIZE: cross AR_LENGTH, AR_BURST_SIZE;
                AR_VALID_X_AR_READY:cross AR_VALID,AR_READY;
                R_VALID_X_R_READY:cross R_VALID,R_READY;
                R_VALID_X_R_READY_X_R_LAST:cross R_VALID,R_READY,R_LAST;
               // R_LEN_X_R_ADDR_X_B_SIZE: cross AR_LENGTH, AR_BURST_SIZE, AR_ADDR;

	endgroup 

	covergroup slv_dyn_covgrp2 with function sample(int i);
		READ_DATA: coverpoint slv_cov_data2.RDATA[i]  {bins low = {[32'h0000_0000:32'hffff_ffff]};}
		READ_RESP: coverpoint slv_cov_data2.RRESP[i] {bins R_RESP[]={[0:3]};}
	endgroup

      	covergroup master_covgrp3;
		option.per_instance = 1;
	
		RESET: coverpoint mast_cov_data3.rst1 {bins rst[] ={0,1};}

		AW_ID :   coverpoint mast_cov_data3.AWID {bins AWID1 ={[0:31]};
		                                         bins AWID2 ={[32:63]};
		                                         bins AWID3 ={[64:127]};
                                                         bins AWID4={[128:255]};}

		AW_ADDR: coverpoint mast_cov_data3.AWADDR{ bins first_slave = {[32'h0000_0000:32'h00ff_ffff]};
							bins second_slave ={[32'h0100_0000: 32'h01ff_ffff]};
							bins third_slave = {[32'h0200_0000:32'h02ff_ffff]};
							bins fourth_slave ={[32'h0300_0000:32'h03ff_ffff]};}

		AW_LENGTH: coverpoint mast_cov_data3.AWLEN {bins AWLEN1 ={[0:31]};
		                                           bins AWLEN2 ={[32:63]};
		                                           bins AWLEN3 ={[63:127]};
		                                           bins AWLEN4 ={[127:255]}; }

		AW_BURST_SIZE: coverpoint mast_cov_data3.AWSIZE {bins AWSIZE[] ={0,1,2};}
		AW_BURST_TYPE: coverpoint mast_cov_data3.AWBURST {bins AWBURST[] ={[0:2]};}
                AW_LOCK:coverpoint mast_cov_data3.AWLOCK{bins AWLOCK[]={[0:1]};}
                AW_CACHE:coverpoint mast_cov_data3.AWCACHE{bins AWCACHE[]={[0:15]};}
                AW_PROT:coverpoint mast_cov_data3.AWPROT{bins AWPROT[]={[0:7]};}
                AW_QOS:coverpoint mast_cov_data3.AWQOS{bins AWQOS[]={[0:15]};}
                AW_REGION:coverpoint mast_cov_data3.AWREGION{bins AWREGION[]={[0:1]};}
                AW_USER:coverpoint mast_cov_data3.AWUSER{bins AWUSER[]={[0:1]};}
                AW_VALID:coverpoint mast_cov_data3.AWVALID{bins AWVALID[]={[0:1]};}
                AW_READY:coverpoint mast_cov_data3.AWREADY{bins AWREADY[]={[0:1]};}

                W_LAST:coverpoint mast_cov_data3.WLAST {bins WLAST[]={[0:1]};}
                W_USER:coverpoint mast_cov_data3.WUSER {bins WUSER[]={[0:1]};}
		W_ID :   coverpoint mast_cov_data3.WID {bins WID1 ={[0:31]};
		                                       bins WID2 ={[32:63]};
		                                       bins WID3 ={[64:127]};
                                                       bins WID4 ={[128:255]};}
                W_VALID:coverpoint mast_cov_data3.WVALID {bins WVALID[]={[0:1]};}
                W_READY:coverpoint mast_cov_data3.WREADY {bins WREADY[]={[0:1]};}

                
		B_ID :   coverpoint mast_cov_data3.BID {bins BID1 ={[0:31]};
		                                       bins BID2 ={[32:63]};
		                                       bins BID3 ={[64:127]};
                                                       bins BID4 ={[128:255]};}
                B_BUSER:coverpoint mast_cov_data3.BUSER {bins BUSER[]={[0:1]};}
                B_VALID:coverpoint mast_cov_data3.BVALID {bins BVALID[]={[0:1]};}
                B_READY:coverpoint mast_cov_data3.BREADY {bins BREADY[]={[0:1]};}
                B_RESP : coverpoint mast_cov_data3.BRESP { bins BRESP[] ={[0:3]};}
             
                

               // Cross Bins
		AW_LEN_X_AW_BURST_SIZE: cross AW_LENGTH, AW_BURST_SIZE;
                AW_VALID_X_AW_READY:cross AW_VALID,AW_READY;
                W_VALID_X_W_READY:cross W_VALID,W_READY;
                W_VALID_X_W_READY_X_W_LAST:cross W_VALID,W_READY,W_LAST;
                B_VALID_X_B_READY:cross B_VALID,B_READY;
               	W_LEN_X_W_ADDR_X_B_SIZE: cross AW_LENGTH, AW_BURST_SIZE, AW_ADDR;
	endgroup

	covergroup mast_dyn_covgrp3 with function sample(int i);
		WRITE_DATA: coverpoint mast_cov_data3.WDATA[i] {bins low = {[32'h0000_0000:32'h4444_4444]};
							bins mid1 ={[32'h4444_4445: 32'h8888_8888]};
							bins mid2 = {[32'h8888_8889:32'hcccc_cccc]};
							bins high ={[32'hcccc_cccd:32'hffff_ffff]};}
		W_STROBE: coverpoint mast_cov_data3.WSTRB[i] {bins W_STRB[] ={1, 2, 3, 4, 8, 12, 14, 15};}
	endgroup

	covergroup slave_covgrp3;
		option.per_instance = 1;
		
	
		
	        AR_ID :   coverpoint slv_cov_data3.ARID {bins ARID1 ={[0:31]};
		                                        bins ARID2 ={[32:63]};
		                                        bins ARID3 ={[64:127]};
                                                        bins ARID4 ={[128:255]};}
	
              
                
		AR_ADDR: coverpoint slv_cov_data3.ARADDR{bins first_slave = {[32'h 0000_0000:32'h 00ff_ffff]};
							bins second_slave ={[32'h 0100_0000:32'h 01ff_ffff]};
							bins third_slave = {[32'h 0200_0000:32'h 02ff_ffff]};
							bins fourth_slave ={[32'h 0300_0000:32'h 03ff_ffff]};}

		AR_LENGTH: coverpoint slv_cov_data3.ARLEN{bins ARLEN1 ={[0:31]};
		                                         bins ARLEN2 ={[31:63]};
		                                         bins ARLEN3 ={[64:127]};
		                                         bins ARLEN4 ={[127:255]};}

		AR_BURST_SIZE: coverpoint slv_cov_data3.ARSIZE{bins ARSIZE[] ={0, 1, 2};}
		AR_BURST_TYPE: coverpoint slv_cov_data3.ARBURST {bins ARBURST[] ={0, 1, 2}; }
		AR_LOCK: coverpoint slv_cov_data3.ARLOCK{bins ARLOCK[] ={[0:1]}; }
		AR_CACHE: coverpoint slv_cov_data3.ARCACHE {bins ARCACHE[] ={[0:15]};}
		AR_PROT: coverpoint slv_cov_data3.ARPROT {bins ARPROT[] ={[0:7]};}
		AR_QOS: coverpoint slv_cov_data3.ARQOS {bins ARQOS[] ={[0:15]};}
		AR_USER: coverpoint slv_cov_data3.ARUSER {bins ARUSER[] ={[0:1]};}
		AR_VALID: coverpoint slv_cov_data3.ARVALID{bins ARVALID[] ={[0:1]};}
		AR_READY: coverpoint slv_cov_data3.ARREADY{bins ARREADY[] ={[0:1]};}
      
                R_ID :   coverpoint slv_cov_data3.RID {bins RID1 ={[0:31]};
		                                      bins RID2 ={[32:63]};
		                                      bins RID3 ={[64:127]};
                                                      bins RID4 ={[128:255]};}

		R_LAST: coverpoint slv_cov_data3.RLAST{bins RLAST[] ={[0:1]};}
		R_USER: coverpoint slv_cov_data3.RUSER{bins RUSER[] ={[0:1]};}
		R_VALID: coverpoint slv_cov_data3.RVALID{bins RVALID[] ={[0:1]};}
		R_READY: coverpoint slv_cov_data3.RREADY{bins RREADY[] ={[0:1]};}

               // Cross Bins
              
		AR_LEN_X_AR_BURST_SIZE: cross AR_LENGTH, AR_BURST_SIZE;
                AR_VALID_X_AR_READY:cross AR_VALID,AR_READY;
                R_VALID_X_R_READY:cross R_VALID,R_READY;
                R_LEN_X_R_ADDR_X_B_SIZE: cross AR_LENGTH, AR_BURST_SIZE, AR_ADDR;
                R_VALID_X_R_READY_X_R_LAST:cross R_VALID,R_READY,R_LAST;

	endgroup 

	covergroup slv_dyn_covgrp3 with function sample(int i);
		READ_DATA: coverpoint slv_cov_data3.RDATA[i]  {bins low = {[32'h0000_0000:32'hffff_ffff]};}
		READ_RESP: coverpoint slv_cov_data3.RRESP[i] {bins R_RESP[]={[0:3]};}
	endgroup





	// Methods
	extern function new(string name="axi_scoreboard", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check_data(axi_xtn slv_xtn); 
	extern function void report_phase(uvm_phase phase);

endclass

function axi_scoreboard :: new(string name="axi_scoreboard", uvm_component parent);
	super.new(name, parent);

	mast_cov_data0 = new();
	slv_cov_data0 = new();

	master_covgrp0 = new();
	slave_covgrp0 = new();
	
	mast_dyn_covgrp0 = new();
	slv_dyn_covgrp0=new();

       mast_cov_data1 = new();
	slv_cov_data1 = new();

	master_covgrp1 = new();
	slave_covgrp1 = new();
	
	mast_dyn_covgrp1 = new();
	slv_dyn_covgrp1=new();
	
       mast_cov_data2= new();
	slv_cov_data2 = new();

	master_covgrp2 = new();
	slave_covgrp2= new();
	
	mast_dyn_covgrp2 = new();
	slv_dyn_covgrp2=new();

       mast_cov_data3 = new();
	slv_cov_data3 = new();

	master_covgrp3 = new();
	slave_covgrp3 = new();
	
	mast_dyn_covgrp3 = new();
	slv_dyn_covgrp3=new();
	

	

	
endfunction

function void axi_scoreboard :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(axi_env_config)::get(this, "","axi_env_config", m_cfg))
		`uvm_fatal("AXI-SCOREBOARD", "Cannot get m_cfg from uvm_config_db. Have you set?")

	fifo_mast = new[m_cfg.no_of_mast_agt];
	fifo_slv = new[m_cfg.no_of_slv_agt];

	foreach(fifo_mast[i])
		fifo_mast[i] = new($sformatf("fifo_mast[%0d]", i), this);

	foreach(fifo_slv[i])
		fifo_slv[i] = new($sformatf("fifo_slv[%0d]", i), this);
	
	axi_mast_data = axi_xtn :: type_id :: create("axi_mast_data");
	axi_slv_data = axi_xtn :: type_id :: create("axi_slv_data");


endfunction

task axi_scoreboard :: run_phase(uvm_phase phase);
	fork
		begin
			forever
				begin
				          fork
						begin
							fifo_mast[0].get(axi_mast_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Master  Data", UVM_LOW)
							axi_mast_data.print();
							mast_cov_data0 = axi_mast_data;
							q1.push_back(axi_mast_data);
							master_covgrp0.sample();
							foreach(mast_cov_data0.WDATA[i])
							mast_dyn_covgrp0.sample(i);
					 	end
                                         
                                       
                                         	begin
							fifo_mast[1].get(axi_mast_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Master  Data", UVM_LOW)
							axi_mast_data.print();
							mast_cov_data1 = axi_mast_data;
							q1.push_back(axi_mast_data);
							master_covgrp1.sample();
							foreach(mast_cov_data1.WDATA[i])
							mast_dyn_covgrp1.sample(i);
					 	end
                                            
                                                begin
							fifo_mast[2].get(axi_mast_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Master  Data", UVM_LOW)
							axi_mast_data.print();
							mast_cov_data2 = axi_mast_data;
							q1.push_back(axi_mast_data);
							master_covgrp2.sample();
							foreach(mast_cov_data2.WDATA[i])
							mast_dyn_covgrp2.sample(i);
					 	end

                                                 begin
							fifo_mast[3].get(axi_mast_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Master  Data", UVM_LOW)
							axi_mast_data.print();
							mast_cov_data3= axi_mast_data;
							q1.push_back(axi_mast_data);
							master_covgrp3.sample();
							foreach(mast_cov_data3.WDATA[i])
							mast_dyn_covgrp3.sample(i);
					 	end

                                          join_any
                                           
				end	
              			
		end
		
		
	
		begin
			forever
				begin
				          fork
						begin
							fifo_slv[0].get(axi_slv_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Slave  Data", UVM_LOW)
                                                        
							axi_slv_data.print();
                                                        slv_cov_data0 = axi_slv_data;
                                                        wait(q1.size!=0)
                                                        if((32'h 0000_0000<(axi_slv_data.AWADDR)<32'h 00ff_ffff)||(32'h 0000_0000<(axi_slv_data.ARADDR)<32'h 00ff_ffff))
                                                       	check_data(axi_slv_data);
                                                        else
							`uvm_fatal("AXI_SCOREBORD-Run_Phase", "address is not in the range ")
							slave_covgrp0.sample();
							foreach(slv_cov_data0.RDATA[i])
							slv_dyn_covgrp0.sample(i);
						end
                                                
                                                begin
							fifo_slv[1].get(axi_slv_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Slave  Data", UVM_LOW)
							axi_slv_data.print();
							slv_cov_data1 = axi_slv_data;
                                                        wait(q1.size!=0)
                                                        if((32'h 0100_0000<(axi_slv_data.AWADDR)<32'h 01ff_ffff)||(32'h 0100_0000<(axi_slv_data.ARADDR)<32'h 01ff_ffff))
                                                       	check_data(axi_slv_data);
                                                        else
							`uvm_fatal("AXI_SCOREBORD-Run_Phase", "address is not in the range ")
							slave_covgrp1.sample();
							foreach(slv_cov_data1.RDATA[i])
							slv_dyn_covgrp1.sample(i);
						end
                                                
                                                begin
							fifo_slv[2].get(axi_slv_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Slave  Data", UVM_LOW)
							axi_slv_data.print();
							slv_cov_data2 = axi_slv_data;
                                                        wait(q1.size!=0)
                                                        if((32'h 0200_0000<(axi_slv_data.AWADDR)<32'h 02ff_ffff)||(32'h 0200_0000<(axi_slv_data.ARADDR)<32'h 02ff_ffff))
                                                       	check_data(axi_slv_data);
                                                        else
							`uvm_fatal("AXI_SCOREBORD-Run_Phase", "address is not in the range ")
							slave_covgrp2.sample();
							foreach(slv_cov_data2.RDATA[i])
							slv_dyn_covgrp2.sample(i);
						end

                                                 begin
							fifo_slv[3].get(axi_slv_data);
							`uvm_info("AXI_SCOREBORD-Run_Phase", "Data from scoreboard -Slave  Data", UVM_LOW)
							axi_slv_data.print();
							slv_cov_data3 = axi_slv_data;
                                                        wait(q1.size!=0)
                                                        if((32'h 0300_0000<(axi_slv_data.AWADDR)<32'h 03ff_ffff)||(32'h 0300_0000<(axi_slv_data.ARADDR)<32'h 03ff_ffff))
                                                       	check_data(axi_slv_data);
                                                        else
							`uvm_fatal("AXI_SCOREBORD-Run_Phase", "address is not in the range ")
							slave_covgrp3.sample();
							foreach(slv_cov_data3.RDATA[i])
							slv_dyn_covgrp3.sample(i);
						end

                                          join_any


				end
		end

	join	

endtask

function void axi_scoreboard :: check_data(axi_xtn slv_xtn);
		
		mast_xtn =q1.pop_front(); 
        if(mast_xtn.AWVALID && slv_xtn.AWREADY)	
	if(mast_xtn.AWID == slv_xtn.AWID)
	if(mast_xtn.WID == slv_xtn.WID)
	if(mast_xtn.BID == slv_xtn.BID)

		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write ID comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write ID comparision is Failed", UVM_LOW)

	if(mast_xtn.AWADDR == slv_xtn.AWADDR)
		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Address comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Address comparision is Failed", UVM_LOW)

	if(mast_xtn.AWLEN == slv_xtn.AWLEN)
	if(mast_xtn.AWSIZE == slv_xtn.AWSIZE)
	if(mast_xtn.AWBURST == slv_xtn.AWBURST)
        if(mast_xtn.AWPROT==slv_xtn.AWPROT)
        if(mast_xtn.AWCACHE==slv_xtn.AWCACHE)
        if(mast_xtn.AWQOS==slv_xtn.AWQOS)
        if(mast_xtn.AWUSER==slv_xtn.AWUSER)
        if(mast_xtn.AWLOCK==slv_xtn.AWLOCK)

		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Control information comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Control information comparision is Failed", UVM_LOW)

       // if(mast_xtn.WVALID && slv_xtn.WREADY)
	foreach(slv_xtn.WDATA[i])
		if(mast_xtn.WDATA[i] ==slv_xtn.WDATA[i])
	 		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Data comparision is Successful", UVM_LOW)
		else
			`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Data comparision is Failed", UVM_LOW)

	foreach(slv_xtn.WSTRB[i])
		if(mast_xtn.WSTRB[i] == slv_xtn.WSTRB[i])
	 		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Strobe comparision is Successful", UVM_LOW)
		else
			`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Strobe comparision is Failed", UVM_LOW)

        if(mast_xtn.BREADY && slv_xtn.BVALID)
	if(mast_xtn.BRESP == slv_xtn.BRESP)
	 	`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Response comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--WRITE_DATA", "Write Response comparision is Failed", UVM_LOW)
        if(mast_xtn.ARVALID && slv_xtn.ARREADY)
	if(mast_xtn.ARID == slv_xtn.ARID)
	if(mast_xtn.RID == slv_xtn.RID)
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read ID comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read ID comparision is Failed", UVM_LOW)

	if(mast_xtn.ARADDR == slv_xtn.ARADDR)
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read Address comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read Address comparision is Failed", UVM_LOW)

	if(mast_xtn.ARLEN == slv_xtn.ARLEN)
	if(mast_xtn.ARSIZE == slv_xtn.ARSIZE)
	if(mast_xtn.ARBURST == slv_xtn.ARBURST)
        if(mast_xtn.ARPROT==slv_xtn.ARPROT)
        if(mast_xtn.ARCACHE==slv_xtn.ARCACHE)
        if(mast_xtn.ARQOS==slv_xtn.ARQOS)
        if(mast_xtn.ARUSER==slv_xtn.ARUSER)
        if(mast_xtn.ARLOCK==slv_xtn.ARLOCK)
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read Control information comparision is Successful", UVM_LOW)
	else
		`uvm_info("AXI_SCORE-BOARD--READ_DATA", "Read Control information comparision is Failed", UVM_LOW)
        if(mast_xtn.RVALID && slv_xtn.RREADY)
	foreach(slv_xtn.RDATA[i])
		if(mast_xtn.RDATA[i] ==slv_xtn.RDATA[i])
	 		`uvm_info("AXI_SCORE-BOARD--Read_DATA", "Read Data comparision is Successful", UVM_LOW)
		else
			`uvm_info("AXI_SCORE-BOARD--Read_DATA", "Read Data comparision is Failed", UVM_LOW)

	foreach(slv_xtn.RRESP[i])
		if(mast_xtn.RRESP[i] ==slv_xtn.RRESP[i])
	 		`uvm_info("AXI_SCORE-BOARD--Read_DATA", "Read Response comparision is Successful", UVM_LOW)
		else
			`uvm_info("AXI_SCORE-BOARD--Read_DATA", "Read Response comparision is Failed", UVM_LOW)


	 data_verified_count++;

endfunction

function void axi_scoreboard :: report_phase(uvm_phase phase);
	`uvm_info("AXI_SCOREBOARD-Report_Phase", $sformatf(" ***###*** The No of Transaction Verified are %0d   ***###***", data_verified_count), UVM_LOW)
endfunction


