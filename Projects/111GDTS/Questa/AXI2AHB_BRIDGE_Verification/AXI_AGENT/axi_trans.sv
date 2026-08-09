 class axi_trans extends uvm_sequence_item;
   `uvm_object_utils(axi_trans)	
   rand bit aresetn;
   //aw channel
   rand bit [7:0] AWID;
   rand bit [31:0] AWADDR;
   rand bit [7:0] AWLEN;
   rand bit [2:0] AWSIZE;
   rand bit [1:0] AWBURST;
   rand bit AWVALID;
   bit AWREADY;
   //w channel	
   rand bit [7:0] WID;
   rand bit [63:0] WDATA[];
   bit [7:0] WSTRB[];
   bit WLAST;
   rand bit WVALID;
   bit WREADY;	
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
  
   int delay_cycles;
  

  
    constraint write_id_c       {AWID == WID; bid==WID;}
        constraint read_id_c    {rid == arid;}
   constraint arburst_c { arburst inside {0,1,2};}  
   constraint AWBURST_c { AWBURST inside {0,1,2};}
   
   constraint arsize_c { arsize inside {0,1,2,3};}
   constraint AWSIZE_c { AWSIZE inside {0,1,2,3};}
  
  constraint write_alignmnent_c1            {((AWBURST == 2'b10 || AWBURST == 2'b00) && AWSIZE == 1) -> AWADDR%2 == 0;} //alignment for wrap
                                                                               
 constraint write_alignmnent_c2            {((AWBURST == 2'b10 || AWBURST == 2'b00) && AWSIZE == 2) -> AWADDR%4 == 0;}
 constraint write_alignmnent_c3            {((AWBURST == 2'b10 || AWBURST == 2'b00) && AWSIZE == 3) -> AWADDR%8 == 0;}
        
constraint read_alignmnent_c1             {((arburst == 2'b10 || arburst == 2'b00) && arsize == 1) -> araddr%2 == 0;} //alignment for wrap
        
constraint read_alignmnent_c2             {((arburst == 2'b10 || arburst == 2'b00) && arsize == 2) -> araddr%4 == 0;}

constraint read_alignmnent_c3             {((arburst == 2'b10 || arburst == 2'b00) && arsize == 3) -> araddr%8 == 0;}
 
  
  
   constraint WDATA_c {solve AWLEN before WDATA.size;WDATA.size==AWLEN+1; }


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
   bit [31:0] start_address=AWADDR;
   int number_byte=2**AWSIZE;
   int burst_length=AWLEN+1;
   bit[31:0] aligned_address = (start_address/number_byte)*number_byte;     
   WSTRB=new[AWLEN+1]; 
   
 // doing modulus operation ex: 10%8 then remainder will be 2. the i will start from 2.

for(int i=(start_address%8);i<((aligned_address%8)+number_byte);i++)
     begin
       WSTRB[j][i]=1'b1;
     end
   for(int l=1;l<burst_length;l++)
     begin
       aligned_address=aligned_address+number_byte;
       j++;
       for(int k=(aligned_address%8);k<((aligned_address%8)+number_byte);k++)
         WSTRB[j][k]=1'b1;
     end
 endfunction
   

 //------------------------------------ do print --------------------------
 function void axi_trans::do_print(uvm_printer printer);
   super.do_print(printer);
   printer.print_field("AWID", this.AWID, 8, UVM_DEC);
   printer.print_field("AWADDR", this.AWADDR, 32, UVM_DEC);
   printer.print_field("AWLEN", this.AWLEN, 8, UVM_DEC);
   printer.print_field("AWSIZE", this.AWSIZE, 3, UVM_DEC);
   printer.print_field("AWBURST", this.AWBURST, 2, UVM_DEC);
   printer.print_field("AWVALID", this.AWVALID, 1, UVM_DEC);
   printer.print_field("AWREADY", this.AWREADY, 1, UVM_DEC);
   printer.print_field("WID", this.WID, 8, UVM_DEC);
   foreach(WDATA[i])
     printer.print_field($sformatf("WDATA[%0d]",i), this.WDATA[i], 64, UVM_DEC);
   foreach(WSTRB[i])
     printer.print_field($sformatf("WSTRB[%0d]",i), this.WSTRB[i], 8, UVM_BIN);
   printer.print_field("WLAST", this.WLAST, 1, UVM_DEC);
   printer.print_field("WVALID", this.WVALID, 1, UVM_DEC);
   printer.print_field("WREADY", this.WREADY, 1, UVM_DEC);
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
