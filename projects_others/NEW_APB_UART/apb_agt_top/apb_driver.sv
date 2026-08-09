
class apb_driver extends uvm_driver#(apb_trans);

	`uvm_component_utils(apb_driver)

	function new (string name = "apb_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

	virtual apb_if apbf;
	apb_config apb_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
			`uvm_fatal(get_type_name(),"FAILED TO GET APB CONFIG")
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);


	endtask

endclass	
			
