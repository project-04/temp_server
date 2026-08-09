class count_driver;

virtual count_if.DRV dr_if;

count_trans data2duv;

mailbox #(count_trans)gen2dr;

function new(virtual count_if.DRV dr_if,mailbox #(count_trans)gen2dr);
begin
	this.dr_if=dr_if;
	this.gen2dr=gen2dr;
end
endfunction

virtual task drive();
//$display("==============================");

begin
	@(dr_if.dr_cb);
	dr_if.dr_cb.load<=data2duv.load;
	dr_if.dr_cb.data_in<=data2duv.data_in;
	dr_if.dr_cb.up_down<=data2duv.up_down;
	dr_if.dr_cb.resetn<=data2duv.resetn;
	data2duv.display("From Write Driver");
end
//$display("==============================");

endtask

virtual task start();
fork
     forever
     begin
   	  gen2dr.get(data2duv);
	  //$display("%0t-------------------------------------------------------------------data2duv = %p", $time, data2duv);
	  drive();
     end
     join_none
endtask
endclass
