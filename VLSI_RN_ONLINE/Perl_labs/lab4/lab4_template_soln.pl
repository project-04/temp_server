#!/usr/bin/perl
##********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   lab4_template   

#Description:  Script that reads a list of strings on separate lines
#              until end of input and prints out the lists in reverse 
#              order.
#
#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************


 #Step1 :Take the inputs for an array & then press ctrl+D

 #Inputs to be taken from the keyboard 
 print " Enter 5 elements to the array :\n";
 @lines = <STDIN>;
 print " Elements are:\n @lines \n";

 #Reverse the entered list of strings using keyword "reverse" 
 @reverse_lines = reverse @lines;

 #Step2:Print the final output
 print "Elements are: \n @reverse_lines \n";





  


