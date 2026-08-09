/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_trans.sv   

module Name             :       axi_trans

Description             :       axi transaction class for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class axi_trans extends uvm_sequence_item;
   `uvm_object_utils(axi_trans)	
   rand bit aresetn;
   //aw channel
   rand bit [7:0] awid;
   rand bit [31:0] awaddr;
   rand bit [7:0] awlen;
   rand bit [2:0] awsize;
   rand bit [1:0] awburst;
   rand bit awvalid;
   bit awready;
   //w channel	
   rand bit [7:0] wid;
   rand bit [63:0] wdata[];
   bit [7:0] wstrb[$];
   bit wlast;
   rand bit wvalid;
   bit wready;	
   //ar channel
   rand bit [7:0] arid;
   rand bit [31:0] araddr;
   rand bit [7:0] arlen;
   rand bit [2:0] arsize;
   rand bit [1:0] arburst;
   rand bit arvalid;
   bit arready;
   //b response channel
   bit [7:0] bid;
   bit [1:0] bresp;
   bit bvalid;
   bit bready;
   //r channel	
   bit [7:0] rid;
   bit [63:0] rdata[];
   bit [1:0] rresp[];
   bit rlast;
   bit rvalid;
   bit rready;
   bit [63:0]temp_wdata;
   bit [63:0]temp_rdata;
   //to include delay	
   int delay_cycles;
   //constraints	
   //constraint wdata_c_1 { foreach(wdata[i])
   //					wdata[i] inside {[100000:1000000]};} 
   constraint aid_c {awid==wid;} 
   //three transfer types 0:fixed 1:increment 2:wrap
   constraint arburst_c { arburst inside {0,1,2};}  
   constraint awburst_c { awburst inside {0,1,2};}
   //as data width is 64 bits maximum possible size 3 where we can send 8 bytes per transfer
   constraint arsize_c { arsize inside {0,1,2,3};}
   constraint awsize_c { awsize inside {0,1,2,3};}
   //        constraint arsize_c { arsize ==3;}
   //        constraint awsize_c { awsize ==3;}
   //axi does not support the unaligned transfers for wrap type burst
   constraint awaddr_c { if(awburst==2)
			   if(awsize==1)
			     awaddr%2==0;
			   else if(awsize==2)
			     awaddr%4==0;
			   else if(awsize==3)
			     awaddr%8==0;
			}	
   //	constraint awaddr_c1 { awaddr inside {[0:1023]}; }
   constraint araddr_c { if(arburst==2)
                           if(arsize==1)
                             araddr%2==0;
                           else if(arsize==2)
                             araddr%4==0;
                           else if(arsize==3)
                             araddr%8==0;
                        }
   //constraint araddr_c1 { araddr inside {[0:1023]}; }
   constraint wdata_c {solve awlen before wdata.size;wdata.size==awlen+1; }
   extern function new (string name="axi_trans");
   extern function void post_randomize();
   extern function void do_print(uvm_printer printer);
 endclass
 //-------------------- new ------------------------- 
 function axi_trans::new(string name="axi_trans");
   super.new(name);
 endfunction
 //-------------------- post randomize ------------------------
 function void axi_trans::post_randomize();      
   int j=0;
   bit [31:0] start_address=awaddr;
   int number_byte=2**awsize;
   int burst_length=awlen+1;
   bit[31:0] aligned_address = (start_address/number_byte)*number_byte;     
   for(int i=(start_address%8);i<((aligned_address%8)+number_byte);i++)
     begin
       wstrb[j][i]=1'b1;
     end
   for(int l=1;l<burst_length;l++)
     begin
       aligned_address=aligned_address+number_byte;
       j++;
       for(int k=(aligned_address%8);k<((aligned_address%8)+number_byte);k++)
         wstrb[j][k]=1'b1;
     end
 endfunction
 //------------------------------------ do print --------------------------
 function void axi_trans::do_print(uvm_printer printer);
   super.do_print(printer);
   printer.print_field("awid", this.awid, 8, UVM_DEC);
   printer.print_field("awaddr", this.awaddr, 32, UVM_DEC);
   printer.print_field("awlen", this.awlen, 8, UVM_DEC);
   printer.print_field("awsize", this.awsize, 3, UVM_DEC);
   printer.print_field("awburst", this.awburst, 2, UVM_DEC);
   printer.print_field("awvalid", this.awvalid, 1, UVM_DEC);
   printer.print_field("awready", this.awready, 1, UVM_DEC);
   printer.print_field("wid", this.wid, 8, UVM_DEC);
   foreach(wdata[i])
     printer.print_field($sformatf("wdata[%0d]",i), this.wdata[i], 64, UVM_DEC);
   foreach(wstrb[i])
     printer.print_field($sformatf("wstrb[%0d]",i), this.wstrb[i], 8, UVM_BIN);
   printer.print_field("wlast", this.wlast, 1, UVM_DEC);
   printer.print_field("wvalid", this.wvalid, 1, UVM_DEC);
   printer.print_field("wready", this.wready, 1, UVM_DEC);
   printer.print_field("bid", this.bid, 8, UVM_DEC);
   printer.print_field("bresp", this.bresp, 2, UVM_DEC);
   printer.print_field("bvalid", this.bvalid, 1, UVM_DEC);
   printer.print_field("bready", this.bready, 1, UVM_DEC);
   printer.print_field("arid", this.arid, 8, UVM_DEC);
   printer.print_field("araddr", this.araddr, 32, UVM_DEC);
   printer.print_field("arlen", this.arlen, 8, UVM_DEC);
   printer.print_field("arsize", this.arsize, 3, UVM_DEC);
   printer.print_field("arburst", this.arburst, 2, UVM_DEC);
   printer.print_field("arvalid", this.arvalid, 1, UVM_DEC);
   printer.print_field("arready", this.arready, 1, UVM_DEC);
   printer.print_field("rid", this.rid, 8, UVM_DEC);
   foreach(rdata[i])
     printer.print_field($sformatf("rdata[%0d]",i), this.rdata[i], 64, UVM_DEC);
   printer.print_field("rlast", this.rlast, 1, UVM_DEC);
   foreach(rresp[i])
     printer.print_field($sformatf("rresp[%0d]",i), this.rresp[i], 2, UVM_DEC);
   printer.print_field("rvalid", this.rvalid, 1, UVM_DEC);
   printer.print_field("rready", this.rready, 1, UVM_DEC);
 endfunction
