class c_1_2;
    rand int d_0_; // rand_mode = ON 
    rand int d_1_; // rand_mode = ON 
    rand int d_2_; // rand_mode = ON 
    rand int d_3_; // rand_mode = ON 
    rand int d_4_; // rand_mode = ON 
    rand int d_5_; // rand_mode = ON 
    rand int d_6_; // rand_mode = ON 
    rand int d_7_; // rand_mode = ON 
    rand int d_8_; // rand_mode = ON 
    rand int d_9_; // rand_mode = ON 
    rand int d_10_; // rand_mode = ON 
    rand int d_11_; // rand_mode = ON 
    rand int d_12_; // rand_mode = ON 
    rand int d_13_; // rand_mode = ON 
    rand int d_14_; // rand_mode = ON 

    constraint c2_this    // (constraint_mode = ON) (../1223334444.sv:10)
    {
       (d_0_ == 1);
       (d_1_ == d_0_);
       (d_2_ == d_1_);
       (d_3_ == d_2_);
       (d_4_ == d_3_);
       (d_5_ == d_4_);
       (d_6_ == d_5_);
       (d_7_ == d_6_);
       (d_8_ == d_7_);
       (d_9_ == d_8_);
       (d_10_ == d_9_);
    }
    constraint c3_this    // (constraint_mode = ON) (../1223334444.sv:16)
    {
       ((32'((((((((((((((((signed'((32'((d_0_ == d_10_))))) + (signed'((32'((d_1_ == d_10_)))))) + (signed'((32'((d_2_ == d_10_)))))) + (signed'((32'((d_3_ == d_10_)))))) + (signed'((32'((d_4_ == d_10_)))))) + (signed'((32'((d_5_ == d_10_)))))) + (signed'((32'((d_6_ == d_10_)))))) + (signed'((32'((d_7_ == d_10_)))))) + (signed'((32'((d_8_ == d_10_)))))) + (signed'((32'((d_9_ == d_10_)))))) + (signed'((32'((d_10_ == d_10_)))))) + (signed'((32'((d_11_ == d_10_)))))) + (signed'((32'((d_12_ == d_10_)))))) + (signed'((32'((d_13_ == d_10_)))))) + (signed'((32'((d_14_ == d_10_)))))))) == d_10_);
    }
endclass

program p_1_2;
    c_1_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1x011zx11x01z01x1x1xxzxx1zz011xxxzxzzxxxzxxzzzzxzxzzxxzxxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
