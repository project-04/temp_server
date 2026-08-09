#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   Netlist.pl   

#Description:      Netlist filtering operation

#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************    
#Creating PERL SCRIPT for filtering components name from the  NETLIST file 
#By providing arguments during RUN-TIME 

 $netlist_file = $ARGV[0];
 open(VERILOG_FILEH,$netlist_file);
      while($line = <VERILOG_FILEH>)
         {
           if($line =~ /(\s*LUT\w+)/)
             {
	             $component_hash{$1}++;
             }
					if($line =~ /(\wBUF\b)/)
						 {
						   $component_hash1{$1}++;
						 }
				  if($line =~ /(\bBUF\w+)/)
						 {
						   $component_hash2{$1}++;
						 }
				 }
				 
				 
  @name_array   = keys %component_hash;
  @name_array1  = keys %component_hash1;
  @name_array2  = keys %component_hash2;
	
  print "ELEMENTS OF THE ARRAY = @name_array \n" ;
  print "ELEMENTS OF THE ARRAY = @name_array1 \n" ;
  print "ELEMENTS OF THE ARRAY = @name_array2 \n" ;

		
		
		
		
		
		
		
		
		
		
		