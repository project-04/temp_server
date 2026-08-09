#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   ram.pl   

#Description:      File input operation

#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************

  $RTL =  "ram.v" ;
  $TB  =  "ram_tb.v" ;
  print("\tGoing to start RAM simulation \n\n ") ;
  print("\tDo you want to create the library ? 'y' or 'n' \n\n") ;
  $LIB_Y_N = <STDIN> ;
  chomp($LIB_Y_N);
  print"Enter the library name: \n";
  $LIB = <STDIN>;
  chomp($LIB);
  if($LIB_Y_N eq 'y')
    {
     system "vlib $LIB" ;  
    }
  print("Do you want to compile your SOURCE codes? 'y' or 'n' \n\n");
  $COMP_Y_N = <STDIN>;
  chomp($COMP_Y_N);
  if($COMP_Y_N eq 'y')
    {
     system "vlog -work $LIB $RTL $TB" ;  #Incremental compilation
    }
  print("Simulate the TOP TB in BATCH MODE : \n");
  $test_case = $ARGV[0];
  open(FILE_H,"$test_case"); #Read the file 

  @test_arry = <FILE_H>;
  close(FILE_H);

  #Step1:Traverse through the array in a non-random order
  foreach $test(@test_arry)
    {
      system "vsim -vopt $LIB.ram_tb -c -do \"run -all;exit\" +$test";
    }

  #Step2:Randomize the index
 # $index = 4;
 # for($i = 0;$i < 4 ; $i++)
 #   {
 #     $rand_test = rand($index);
 #     print "THE TEST_CASE INDEX : $rand_test \n" ;
 #     system "vsim -vopt $LIB.ram_tb -c -do \"run -all;exit\" +$test_arry[$rand_test]";
 #   }
   

   system "rm -rf modelsim.ini transcript  $(LIB) " ;
    

  
  
  

  








   
