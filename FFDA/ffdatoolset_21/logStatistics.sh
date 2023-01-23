#!/bin/bash

#
#       Produces the event count by category and node. 
#	Software is distributed without any warranty.
#
#       Bugs should be reported to antonio.pecchia@unina.it
#



#******* INPUT ********#
#$1 ==> log nel formato "TIMESTAMP NODE ERR-CATEGORY MESSAGE"
#**********************#



TOT=`wc -l $1 | awk '{print $1}'`

echo ""
echo "== Total error entries ==" 
echo "$TOT"
echo ""

echo "== Breakup by CATEGORY =="
cat $1 | awk '{print $3}' | sort | uniq -c | sort -nr | awk '{print $2,$1}'
echo ""

echo "== Breakup by NODE* =="
cat $1 | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 10 | awk '{print $2,$1}'
echo "  * only the 10 most occurring nodes are reported"
echo ""
