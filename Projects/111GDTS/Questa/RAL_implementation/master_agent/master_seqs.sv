class m_sequence extends uvm_sequence#(trans);

	`uvm_object_utils(m_sequence)

	 rand  uvm_reg_data_t  data;
      uvm_status_e status;
        reg_block regh; 
    env_config m_cfg; 
     function new(string name="m_sequence");
		super.new(name);
	endfunction

		task body;

            	if(!uvm_config_db #(env_config)::get(null, get_full_name(), "env_config", m_cfg))
			`uvm_fatal(get_full_name(), "Could not find env_config") 
            		
		 regh = m_cfg.regh ;

	endtask


endclass

class single_seq extends m_sequence;

	`uvm_object_utils(single_seq)

	
	function new(string name="single_seq");
		super.new(name);
	endfunction

	task body;
     super.body();
		req=trans::type_id::create("req");
		start_item(req);
		assert(req.randomize);

     //regh.data.write(status,req.data_in, .parent(this));
		finish_item(req);
	endtask

endclass




