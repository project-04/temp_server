 class ahb_sequence_base extends uvm_sequence#(ahb_trans);
   `uvm_object_utils(ahb_sequence_base)

   environment_config env_cfg;

   extern function new(string name="ahb_sequence_base");
 endclass
 //---------------------- new ---------------------
 function ahb_sequence_base::new(string name="ahb_sequence_base");
   super.new(name);
 endfunction
 


class ahb_seq extends ahb_sequence_base;
   `uvm_object_utils(ahb_seq);
        
   extern function new (string name="ahb_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function ahb_seq::new(string name="ahb_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task ahb_seq::body();
static int a;

   req=ahb_trans::type_id::create("req");
 
  if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration fail in ahb_sequence")
  

 $display("ahb_length :%p",env_cfg.ahb_length);	
   
repeat(((env_cfg.ahb_length.pop_front())))
     begin
	a++;
       start_item(req);
       assert(req.randomize() with {delay_cycles==2;});
       finish_item(req);
     end
	$display("############################################# -- %p",a);
 endtask

 

class ahb_read_seq extends ahb_sequence_base;
   `uvm_object_utils(ahb_read_seq);
        
   extern function new (string name="ahb_read_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function ahb_read_seq::new(string name="ahb_read_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task ahb_read_seq::body();
   req=ahb_trans::type_id::create("req");
  
 if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration fail in ahb_sequence")
 
  $display("ahb_length :%p",env_cfg.ahb_length);	
  
 repeat(((env_cfg.ahb_length.pop_front())))
     begin
       start_item(req);
       assert(req.randomize() with {delay_cycles==2;resp==0;});
       finish_item(req);
     end
 endtask




class ahb_seq1 extends ahb_sequence_base;
   `uvm_object_utils(ahb_seq1)
        
   extern function new (string name="ahb_seq1");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function ahb_seq1::new(string name="ahb_seq1");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task ahb_seq1::body();
   req=ahb_trans::type_id::create("req");
 
  if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration fail in ahb_sequence")
  

 $display("ahb_length :%p",env_cfg.ahb_length);	
   
repeat(((env_cfg.ahb_length.pop_front())))
     begin
       start_item(req);
       assert(req.randomize() with {delay_cycles==2;resp==1;});
       finish_item(req);
     end
 endtask

