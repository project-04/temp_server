// In class ram_trans

class ram_trans;
   rand bit[3:0] data_in;
   rand bit load;
   rand bit up;
   rand bit reset_n;
  
   
   // Declare a variable data_out (logic type , size 64)
   logic [3:0] data_out;
 
   // Declare a static variable trans_id (int type), to keep the count of transactions generated

   static int  no_of_reset;
   static int no_of_load;
   static int no_of_up;
   static int no_of_down;
   static int trans_id;

    
   constraint CON1 {data_in inside {[0:11]};}
   constraint CON2 {load dist {1:= 30, 0:=70};}
   constraint CON3 {up dist {0:=50,1:=50};}
   constraint CON4 {reset_n dist {0:=70,1:=30};}






     function void post_randomize();

      trans_id++;

     endfunction: post_randomize




 virtual function void display(input string message);
      $display("=============================================================");
      $display("%s",message);
     /* if(message=="\tRANDOMIZED DATA")
         begin
            $display("\t_______________________________");
            $display("\tTransaction No. %d",trans_id);
            $display("\tDATA LOADED %d", load);
            $display("\tUP_DOWN = %d",up);
            $display("\t count  %d", data_out);
            $display("\t_______________________________");
         end*/
      
      $display("\tTransaction No. %d",trans_id);
      $display("\tDATA LOADED %d", load);
      $display("\tUP_DOWN = %d",up);
      $display("\tData=%d",data_in);
      $display("\tData_out= %d",data_out);
      $display("=============================================================");
   endfunction: display





   
/*   //Understand and include the virtual function compare
   virtual function bit compare (input ram_trans rcvd,output string message);
      compare='0;
      begin
         if(this.data_out != ref_count)
            begin
               $display($time);
               message="--------- DATA MISMATCH ---------";
               return(0);
            end
     
            begin
               message=" SUCCESSFULLY COMPARED";
               return(1);
            end
      end
   endfunction: compare*/

endclass: ram_trans
