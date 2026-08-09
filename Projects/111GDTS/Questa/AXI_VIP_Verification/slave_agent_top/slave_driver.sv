class slave_driver extends uvm_driver#(axi_xtn);
        `uvm_component_utils(slave_driver)

    virtual axi_if.AXI_MDRV sif;
    slave_config slv_cfg_h;
    axi_xtn xtn,xtn1;
    axi_xtn q1[$],q2[$],q3[$];
    int count,ending;
        semaphore sem_awad = new();
        semaphore sem_wdrp = new();
        semaphore sem_awaddr = new(1);
        semaphore sem_awdata = new(1);
        semaphore sem_wrp = new(1);
        semaphore sem_awrp=new(1);

                semaphore sem_radc = new();

                semaphore sem_rac=new(1);
                semaphore sem_rdc=new(1);

    extern function new(string name = "slave_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task  run_phase(uvm_phase phase);

    extern task drive();
    extern task read_awaddr(axi_xtn xtn);
    extern task read_data(axi_xtn xtn);
    extern task drive_wresp(axi_xtn xtn);

        extern task slave_rdata(axi_xtn xtn1);
        extern task slave_raddr();

//  extern function void phase_ready_to_end(uvm_phase phase);
endclass: slave_driver

    function slave_driver::new(string name = "slave_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void slave_driver::build_phase(uvm_phase phase);
        if(!uvm_config_db#(slave_config)::get(this, "", "slave_config", slv_cfg_h))
            `uvm_fatal("slave Driver", "getting config failed");
            super.build_phase(phase);
    endfunction

    function void slave_driver::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
      sif=slv_cfg_h.sif;
    endfunction

     task slave_driver::run_phase(uvm_phase phase);
          //      seq_item_port.get_next_item(req);
        forever
                drive();
 //               if(count && ending)
   //               phase.drop_objection(this);
            //   seq_item_port.item_done();
           //    req.print();
     endtask

         task slave_driver::drive();

       xtn=axi_xtn::type_id::create("xtn");
           fork
            begin
                   sem_awaddr.get(1);
                   read_awaddr(xtn);
                   sem_awaddr.put(1);
                   sem_awad.put(1);
                 end
                 begin
                    sem_awad.get(1);
                        sem_awdata.get(1);
                    read_data(q1.pop_front());
                        sem_awdata.put(1);
                        sem_wdrp.put(1);
                 end
                  begin
                    sem_wdrp.get(1);
                    sem_wrp.get(1);
                    drive_wresp(q2.pop_front());
                    sem_wrp.put(1);
                 end
               begin
                        sem_rac.get(1);
                        slave_raddr();
                        sem_rac.put(1);
                        sem_radc.put(1);
                end

                begin
                        sem_radc.get(1);
                        sem_rdc.get(1);
                        slave_rdata(q3.pop_front());
                        sem_rdc.put(1);
                end
          join_any


         endtask

         task slave_driver::read_awaddr(axi_xtn xtn);
            $display("start of read_awaddr");
            repeat($urandom_range(1,5))
                    @(sif.slv_drv_cb);
                          sif.slv_drv_cb.AWREADY<=1;
                     @(sif.slv_drv_cb);
                 wait(sif.slv_drv_cb.AWVALID)
                        xtn.ARESETn=sif.slv_drv_cb.ARESETn;
                        xtn.AWID=sif.slv_drv_cb.AWID;
                        xtn.AWLEN=sif.slv_drv_cb.AWLEN;
                        xtn.AWSIZE=sif.slv_drv_cb.AWSIZE;
                        xtn.AWBURST=sif.slv_drv_cb.AWBURST;
                        xtn.AWVALID=sif.slv_drv_cb.AWVALID;
                        xtn.AWADDR=sif.slv_drv_cb.AWADDR;
                q1.push_back(xtn);
                q2.push_back(xtn);

          repeat($urandom_range(1,5))
                 @(sif.slv_drv_cb);
                 sif.slv_drv_cb.AWREADY<=0;

            $display("end of read_awaddr");
       endtask

        task slave_driver::read_data(axi_xtn xtn);
           int mem[int];

            $display("start of read_data");
          // wait(xtn.AWLEN>1)
          // $display("printing in slave");
          // xtn.print();
       //   $displayh("aligned:%h",xtn.aligned_addr);
          // $display("no_bytes:%d",xtn.no_bytes);
           xtn.cal_addr();

        $displayh("aligned:%h",xtn.aligned_addr);
           $displayh("addresses calculated in slave side are %p",xtn.addr);
          for(int i=0;i<(xtn.AWLEN+1);i++)
                 begin
                      sif.slv_drv_cb.WREADY<=1;
                      @(sif.slv_drv_cb);
                          wait(sif.slv_drv_cb.WVALID)

            $display("slave driver start of awvalid");
                                  $display("WSTRB in slave driver is:%p",sif.slv_drv_cb.WSTRB);
                                 if(sif.slv_drv_cb.WSTRB==15)
                                        mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA;

                               if(sif.slv_drv_cb.WSTRB==8)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[31:24];

                                  if(sif.slv_drv_cb.WSTRB==4)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[23:16];

                                  if(sif.slv_drv_cb.WSTRB==2)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[15:8];

                                  if(sif.slv_drv_cb.WSTRB==1)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[7:0];

                                  if(sif.slv_drv_cb.WSTRB==7)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[23:0];

                                  if(sif.slv_drv_cb.WSTRB==14)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[31:8];

                                  if(sif.slv_drv_cb.WSTRB==12)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[31:16];

                                  if(sif.slv_drv_cb.WSTRB==3)
                                         mem[xtn.addr[i]]=sif.slv_drv_cb.WDATA[15:0];



                           $displayh("value inside mem is: %p",mem[xtn.addr[i]]);
                           sif.slv_drv_cb.WREADY<=0;
                          repeat($urandom_range(1,5))
                          @(sif.slv_drv_cb);
                          count=1;
                   end
             $displayh("memory is %p",mem);

            $display("end of read_data");
        endtask

        task slave_driver::drive_wresp(axi_xtn xtn);

            $display("start of drive_wresp");
     //     repeat($urandom_range(1,5))
              //        @(sif.slv_drv_cb);
                          sif.slv_drv_cb.BVALID<=1;
                          sif.slv_drv_cb.BRESP<=0;
                          sif.slv_drv_cb.BID<=xtn.AWID;
                          $display("BID sent is %d",xtn.AWID);
        //repeat($urandom_range(1,5))
                      @(sif.slv_drv_cb);
                      wait(sif.slv_drv_cb.BREADY)
                          sif.slv_drv_cb.BVALID<=0;
                          sif.slv_drv_cb.BRESP<='hx;


         repeat($urandom_range(1,5))
                      @(sif.slv_drv_cb);
            $display("end of drive_wresp");
        endtask


          task slave_driver::slave_raddr();
           $display("start of slave_raddr");
           xtn1=axi_xtn::type_id::create("xtn");
            repeat($urandom_range(1,5))
                  @(sif.slv_drv_cb);
            sif.slv_drv_cb.ARREADY <= 1;

            wait(sif.slv_drv_cb.ARVALID)
                   xtn1.ARID=sif.slv_drv_cb.ARID;
                   xtn1.ARLEN=sif.slv_drv_cb.ARLEN;
                   xtn1.ARSIZE=sif.slv_drv_cb.ARSIZE;
                   xtn1.ARBURST=sif.slv_drv_cb.ARBURST;
                 //  xtn1.ARVALID=sif.slv_drv_cb.ARVALID;

                  q3.push_back(xtn1);
                   repeat($urandom_range(1,5))
                    @(sif.slv_drv_cb);

            sif.slv_drv_cb.ARREADY <= 0;

           $display("end of slave_raddr");
        endtask

        task slave_driver::slave_rdata(axi_xtn xtn1);
        int length = xtn1.ARLEN;
            $display("start of slave_rdata");
        for(int i=0; i<length+1; i++)
        begin
                sif.slv_drv_cb.RDATA<= $urandom;
             //   $displayh("slave received address:%0p, data;%0d",xtn.addr,sif.slv_drv_cb.RDATA);
              //  $displayh("RDATA SENt is : %h",sif.slv_drv_cb.RDATA);
                sif.slv_drv_cb.RVALID<= 1;
                sif.slv_drv_cb.RID<= xtn1.ARID;
                sif.slv_drv_cb.RRESP <= 0;
                if(i==(length))
                        sif.slv_drv_cb.RLAST <= 1;
                else
                        sif.slv_drv_cb.RLAST <= 0;

                @(sif.slv_drv_cb);
                wait(sif.slv_drv_cb.RREADY)
                sif.slv_drv_cb.RVALID <= 0;
                sif.slv_drv_cb.RLAST <= 0;
                sif.slv_drv_cb.RRESP <= 'hz;
           //   `uvm_fatal("a","a")

                repeat($urandom_range(1,5))
                  @(sif.slv_drv_cb);
               count=1;
        end

            $display("end of slave_rdata");
        endtask

