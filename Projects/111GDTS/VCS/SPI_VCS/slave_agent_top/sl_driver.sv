class sl_driver extends uvm_driver #(sl_xtn);
	`uvm_component_utils(sl_driver)

	virtual spi_if.SL_DRV vif;
	sl_agent_config s_cfg;
int ctrl;
 bit [6:0] char_len;
    bit drv_edge;
    bit lsb;
    int i;

extern function new(string name ="sl_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_spi(sl_xtn xtn);
extern  function void report_phase(uvm_phase phase);

endclass


function sl_driver::new(string name ="sl_driver", uvm_component parent);
	super.new(name,parent);
endfunction


function void sl_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
`uvm_info("sl_driver","This is in Slave_Driver",UVM_LOW)

	/////////  Getting from sl agt config////////
if(!uvm_config_db#(sl_agent_config)::get(this,"","sl_agent_config",s_cfg))
`uvm_fatal("VIF_CFG","Unable to get the sl_agent_config in sl driver")

	////////// getting ctrl signal which is set in test//////
if(!uvm_config_db#(int)::get(this,"","int",ctrl))
`uvm_fatal("ctrl","Unable to get the ctrl signal from test")
 char_len = ctrl [6:0];
        drv_edge = ctrl[9];
        lsb = ctrl [11];

endfunction


function void sl_driver::connect_phase(uvm_phase phase);

	vif = s_cfg.vif_1;
endfunction


task sl_driver::run_phase(uvm_phase phase);

	forever
	begin
		seq_item_port.get_next_item(req);	
		send_to_spi(req);
		seq_item_port.item_done();
	end
endtask
 
task sl_driver::send_to_spi(sl_xtn xtn);
xtn.print(); 

if(ctrl[9]==1)
	begin
		$display("Entered slave driverrrrrrrrrrrrrrrrr");
		if(ctrl[6:0]==0)
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<=127;i++)
							begin
								@(negedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
					end
				else
					begin
							for(int i=127;i>=0;i--)
							begin
								@(negedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
					end
			end
		else
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<ctrl[6:0];i++)			
							begin
									$display("Entered slave driver +++++++++++++++++ i=%d",i);

								@(negedge vif.sl_drv_cb.sclk_pad_o);
								$display("Entered slave driverrrrrrrrrrrrrrrrr1111111");
									
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							$display("%0d",xtn.miso_pad_i[i]);
		$display(" slave driver Yeah here is done ");
							end
					end

				else
					begin
						for(int i=ctrl[6:0]-1;i>=0;i--)
							begin
								@(negedge vif.sl_drv_cb.sclk_pad_o);
								$display("Entered slave driverrrrrrrrrrrrrrrrr22222222");
								
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
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
						for(int i=0;i<128;i++)
							begin
								@(posedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
//	`uvm_info("wb_driver",$sformatf("Printing it from the WB_Driver %s",xtn.sprint()),UVM_LOW)
					end
				else
					begin
							for(int i=127;i>=0;i--)
							begin
								@(posedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
					end
			end
		else
			begin
				if(ctrl[11])
					begin
						for(int i=0;i<ctrl[6:0];i++)			
							begin
								@(posedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
//	`uvm_info("wb_driver",$sformatf("Printing it from the WB_Driver %s",xtn.sprint()),UVM_LOW)
					end
				else
					begin
						for(int i=ctrl[6:0]-1;i>=0;i--)
							begin
								@(posedge vif.sl_drv_cb.sclk_pad_o);
								vif.sl_drv_cb.miso_pad_i<=xtn.miso_pad_i[i];
							end
					end
			end
	end


xtn.print();

endtask

	
function void sl_driver::report_phase(uvm_phase phase);

	//`uvm_info("wb_driver",$sformatf("Printing it from the WB_Driver %s",xtn.sprint()),UVM_LOW)
endfunction


					

						

						
				
								
	
