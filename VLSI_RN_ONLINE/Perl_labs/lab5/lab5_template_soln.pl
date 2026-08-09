#!/usr/bin/perl
##********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   lab5_temp   

#Description:     Write a subroutine ,called "total" ,which returns the 4
#                 times value of  the same number for  first 10 integers.
#                 The  subroutine  shouldn't  perform any I/O. It should 
#                 simply process its parameters and return a value to its
#                 caller. Try this out in this sample program,which merely
#                 exercises the subroutine to see that it works.

#
#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************


		#Step1 :Declaration of the subroutine called "total"
		sub total
			{
			my (@numbers) = @_;  #Setting up local variables to the subroutine
			#and without assigning them values right away						 
			return $numbers[0] + $numbers[1] + $numbers[2] + $numbers[3]; #Return the summed up value
			}


	  #Step2 :Define a for loop for first 10 integers     
                   for($i = 0; $i < 10 ; $i++) 		
			{
				print "$i is summed up to ",&total($i,$i,$i,$i), "\n";
			}
       













         
           
          
            
         
