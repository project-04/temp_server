#!/usr/bin/perl
#********************************************************************************************
#Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
#All Rights Reserved.

#This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

#It is not to be shared with or used by any third parties who have not enrolled for our paid training 

#courses or received any written authorization from Maven Silicon.


#Webpage:  www.maven-silicon.com

#Filename:	   split.pl   

#Description:      Script to split a scalar

#Author Name:      Susmita Nayak

#Version: 1.0
#*********************************************************************************************    

open(IN,$ARGV[0]); #Open a file in read mode 
$RDLN = <IN>;
@IN_WORDS = split(/\s+/,$RDLN); #Matches any white space character 
close(IN);
@low_up_words = @IN_WORDS;
print ("@low_up_words \n ");

foreach $tmp(@IN_WORDS)
  {
    print  ("\t","\t",$tmp,"\t","\t","\n");	   
    print  ("\t","\t",lc($tmp),"\t","\t","\n");
    push(@low_up_words,lc($tmp));
  }
print ("@low_up_words[4..7] \n ");






