#!/usr/bin/python

import os
import sys
import shutil

#
#       Estimate the tuple count. Software is distributed
#       without any warranty.
#
#       Bugs should be reported to antonio.pecchia@unina.it
#

#$1 file with lines
#$2 CWIN 

logfile = sys.argv[1]
cwin = sys.argv[2]

logfiled = open(logfile,"r")
loglines = logfiled.readlines()

tcount=1

i=0
line = loglines[i].split()
prev = line[0]

i = i + 1
while i < len(loglines):
	line = loglines[i].split()
	succ = line[0]

	
	#calcolo delta
	delta = int(succ) - int(prev)

	#print str(delta) +" " +str(cwin)

	if int(delta)<int(cwin):		
		j=0		
	else:
		tcount = int(tcount) + 1

	prev = succ
	i = i + 1

print str(cwin)+" "+str(tcount)
