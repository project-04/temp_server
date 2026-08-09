#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   lab1_template   

#Description:      Print a string

#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************

#Step1 : Print the string "Hello World" ....

print "Hello World \n"; 
#Hello World 

$str = "abc";#scalar data type
@arrayyy = (1,"a");#array data type
%hashaa = ("key1" => 2, "key2" => "b");#hash data type

print ("$str \n"); 
#abc
print ("$str \n" x3); 
#abc
#abc
#abc
print ('$str \n' x3); 
print "\n";
#$str \n$str \n$str \n

print("@arrayyy \n");
#1 a

print ("%hashaa \n");
#%hashaa

print (%hashaa);
print "\n";
#key12key2b



