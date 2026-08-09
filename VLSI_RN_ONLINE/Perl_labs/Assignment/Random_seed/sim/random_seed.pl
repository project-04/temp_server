#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   random_seed.pl   

#Description:      Script to extract seed number 

#Author Name:      Susmita Nayak

#Version: 1.0
#********************************************************************************************* 

     $RTL = "../rtl/*.v";
     $INC = "+incdir+../env +incdir+../test";
     $SVTB1= "../env/ram_if.sv ../env/ram_pkg.sv ";
     $SVTB = "../env/top.sv";
     $VSIMCOV= "run -all; exit";
     $VSIMBATCH= "-c -do \"$VSIMCOV\"";


print " \U Run simulation with a seed number till all transactions are successfull for a single testcase \n\n";
print " \U Enter the testcase : TEST1 or TEST2 or TEST3  \n\n" ;

$testtype = <STDIN>;
chomp ($testtype);
$testtype = uc($testtype);

print " \U Whether this is the first simulation run for the current testcase :\L 'y' or 'n' \n\n" ;
$first_run = <STDIN>;
chomp($first_run);

if($first_run eq 'y')
 {
   &SIM_1;
 }

 
      sub SIM_1{
         if(($testtype eq 'TEST1') or ($testtype eq 'TEST2') or ($testtype eq 'TEST3')) 
          {
            system "vlib lib";
            system "vmap work lib";
            system "vlog -work lib $RTL $SVTB1 $INC  $SVTB ";
            system "vsim -vopt  lib.top $VSIMBATCH  -sv_seed random   -l test1_sim.log +$testtype |more";
	    print "\n \n \n ";
            &SIM_2;
          }
     }

       sub SIM_2  {
                    print "Seed Number extraction Continued \n" ;
                    &SIM_3;

                  }


     sub SIM_3 {
     open (FILEH1,"test1_sim.log");
     @string = <FILEH1>;
     foreach $string(@string)
      {
        if($string =~ /\s+seed\s+value/)
	 {
	   open(FILEH2,">test1_filtered.log");
	   print FILEH2 "$string \n" ;
	 }
      }

     open(FILEH2,"test1_filtered.log");
     $var = <FILEH2>;
     if($var  =~ /(\d+)/)
     {
       open (FILEH3,">file4.txt");
       print FILEH3 "$1 \n" ;
     }

     open (FILEH3,"file4.txt");
     $seed_num = <FILEH3> ;
     if($seed_num =~ /\s*(\d+)/)
      {
        print "The Seed number extracted : $1 \n \n \n  " ;
        print " \U Run simulation with a Hard coded seed number till all transactions are successfull for the selected testcase \n \n \n ";
	#DELAY IN PERL SCRIPT 
	sleep(5); #Sleep for 5seconds 
	{
          system "vlog -work lib $(RTL) $(SVTB1) $(INC)  $(SVTB)";
          system "vsim -lib lib.top   $(VSIMBATCH) -sv_seed $1 -l test1_sim.log  +$testtype |more";
	  print " \n \n \n" ;
	  print " \U Whether the last transaction for the current testcase is completed  : \L 'y' or 'n'  \n \n \n " ;
          $status = <STDIN>;
          chomp ($status);
	  $status = lcfirst($status);
	  print "\n \n \n " ;
          if($status eq 'n')
          {
           redo ;
          }
	  else
	   {
            last;
	   }
	}
      }
     &CLEAN ;
  }

      sub CLEAN { 
        system "rm -rf  lib modelsim.ini transcript" ;
         }



    
