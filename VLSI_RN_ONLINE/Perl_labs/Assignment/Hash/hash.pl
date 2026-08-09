#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   hash.pl   

#Description:      Hash data-type operation

#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************    
     # => represents a comma arrow

     %NIC_CARDS= ("CISCO"   => "01-23-45-67-89-ab",
	          "D-Link"  => "01-24-44-66-77-ac",
	          "Realtek" => "10-40-54-22-ba-41");

	  #1st Method using while loop
	  #while(($NIC_VENDOR,$MAC_ADDR)= each (%NIC_CARDS))
	  #   {
	  #     print "$NIC_VENDOR -> $MAC_ADDR \n" ;
	  #   }

    ####################################################
    #2nd Method using foreach loop

    foreach $NIC_VENDOR(sort keys %NIC_CARDS)
      {
           $VALUE = $NIC_CARDS{$NIC_VENDOR} ;
            print "$NIC_VENDOR -> $VALUE \n";
      }

		
		
		
		
		
		
		
		
		
		
		
