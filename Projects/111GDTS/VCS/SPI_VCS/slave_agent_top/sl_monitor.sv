class sl_monitor extends uvm_monitor;
	`uvm_component_utils(sl_monitor)
	virtual spi_if.SL_MON vif;
	uvm_analysis_port #(sl_xtn) monitor_port;
	sl_xtn slxtn;
sl_agent_config sl_cfg;
bit [6:0] char_len;
    bit drv_edge;
    bit lsb;
    int i;


int ctrl;

extern function new(string name ="sl_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);

endclass


function sl_monitor::new(string name ="sl_monitor", uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);
endfunction


function void sl_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
`uvm_info("wb_monitor","This is in SL_MONITOR",UVM_LOW)

	if(!uvm_config_db#(sl_agent_config)::get(this,"","sl_agent_config",sl_cfg))
`uvm_fatal("sl_monitor","Unable to get config in monitor which is set in the test")

if(!uvm_config_db#(int)::get(this,"","int",ctrl))
`uvm_fatal("ctrl","Unable to get the ctrl signal from test")
char_len = ctrl [6:0];
        drv_edge = ctrl [9];
        lsb = ctrl [11];

slxtn=sl_xtn::type_id::create("slxtn");

endfunction

function void sl_monitor::connect_phase(uvm_phase phase);
 super.connect_phase(phase);

		vif=sl_cfg.vif_1;
endfunction

task sl_monitor::run_phase(uvm_phase phase);

	forever
		collect_data();
endtask


task sl_monitor::collect_data();
//repeat(10)
	@(vif.sl_mon_cb);

if(ctrl[9]==1) //rx neg
	begin
	//	$display("Entered slave monitorrrrrrrrr ctrl[6:0]=%d",ctrl[6:0]);
		if(ctrl[6:0]==0)
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<=127;i++)
							begin
								@(posedge vif.sl_mon_cb.sclk_pad_o);
		
								slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
								slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
							end
					end
				else
					begin
							for(int i=127;i>=0;i--)
							begin
								@(posedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
								slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;

							end
					end
			end
		else
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<ctrl[6:0];i++)			
							begin

								@(posedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								//	slxtn.print();
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];
								//	slxtn.print();
															//	$stop;
						//	@(vif.sl_mon_cb);
							end
					end
				else
					begin
						for(int i=ctrl[6:0]-1;i>=0;i--)
							begin
								@(posedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];

							end
					end
			end
	end
else
	begin
		if(ctrl[6:0]==0)
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<127;i++)
							begin
								@(negedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];
							end
					end
				else
					begin
							for(int i=127;i>=0;i--)
							begin
								@(negedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];
							end
					end
			end
		else
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<=ctrl[6:0]-1;i++)			
							begin
								@(negedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];
							end
					end
				else
					begin
						for(int i=ctrl[6:0]-1;i>=0;i--)
							begin
								@(negedge vif.sl_mon_cb.sclk_pad_o);
								slxtn.miso_pad_i = vif.sl_mon_cb.miso_pad_i[i];
								slxtn.mosi_pad_o = vif.sl_mon_cb.mosi_pad_o[i];
							end
					end
			end
	end

/*repeat(15)
  @(vif.sl_mon_cb);
        if (drv_edge) begin
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i <= 127; i++) begin
                        @(negedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(negedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(negedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                            $display("from mon miso_pad_i[%0d] = %b at %t \n *******",i,slxtn.miso_pad_i[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(negedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                            $display("AAAA from mon miso_pad_i[%0d] = %b at %t \n *******",i,slxtn.miso_pad_i[i],$time);
                    end
                end
            end
        end
        else begin 
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i<128; i++) begin
                        @(posedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(posedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(posedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                            $display("from mon miso_pad_i[%0d] = %b at %t \n *******",i,slxtn.miso_pad_i[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(posedge vif.sl_mon_cb.sclk_pad_o)
                            slxtn.miso_pad_i[i] = vif.sl_mon_cb.miso_pad_i;
                            slxtn.mosi_pad_o[i] = vif.sl_mon_cb.mosi_pad_o;
                    end
                end
            end
        end*/

monitor_port.write(slxtn);
	
//slxtn.print();		
endtask

function void sl_monitor::report_phase(uvm_phase phase);

//	`uvm_info("sl_monitor",$sformatf("Printing it from the SL_MONITOR %s",slxtn.sprint()),UVM_LOW)
endfunction










































	
