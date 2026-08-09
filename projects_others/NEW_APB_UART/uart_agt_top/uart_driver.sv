

class uart_driver extends uvm_driver#(uart_trans);

	`uvm_component_utils(uart_driver)

	function new (string name = "uart_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

	virtual uart_if uartf;
	uart_config uart_cfg;
	
	bit[7:0] LCR;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(uart_config)::get(this,"","uart_config",uart_cfg))
			`uvm_fatal(get_type_name(),"FAILED TO GET CONFIG")

		if(!uvm_config_db#(bit[7:0])::get(this,"","LCR",LCR))
			`uvm_fatal(get_type_name(),"FAILED TO GET LCR")	
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		uartf = uart_cfg.uartf;
		
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);


	endtask

endclass	



/*

task run_phase(uvm_phase phase);

$display("LCCCCCCCCCRRRRRRRRRRRRRRRR IN UART DRIVER %0d",LCR);
    vif.tx=1'b1;

	forever
		begin

			seq_item_port.get_next_item(req);
			`uvm_info ("UART DRIVER","PRINTING FROM UARTB SEQUENCE",UVM_LOW)
			req.print;

			send_to_dut(req);
			seq_item_port.item_done();
		end
endtask

task send_tx(int b);
vif.tx <= b;
repeat(16) 
@(posedge vif.baud_o);
endtask

task send_to_dut(uart_xtn xtn);
int bits;
bit parity;
bits = LCR[1:0] + 5;   // 00->5, 01->6, 10->7, 11->8



//    repeat(32) 
  //  @(posedge vif.baud_o);
vif.tx <= 0;

    repeat(16)      //start bit 
    @(posedge vif.baud_o);
for (int i = 0; i < bits; i++)
begin
  send_tx(xtn.tx[i]);
end

// Parity bit (if enabled)
if (LCR[3]) begin
 /* parity = 0;
  for (int i = 0; i < bits; i++)
    parity ^= xtn.tx[i];*
  send_tx(parity);
end

// Stop bit
send_tx(xtn.stop_bit); //rand fgor this and make 0 for framing and break
  if(LCR [2]==1)
	if(LCR[1:0]==2'b00)
 repeat(8)      
    @(posedge vif.baud_o);

//Start  Data bits {5,6,7,8}, parity, stopbit{1, 2(6,7,8), 1.5(5)}

endtask

*/
