#!/bin/bash

#
#       Fiter by node or category field. Software is distributed
#       without any warranty.
#
#       Bugs should be reported to antonio.pecchia@unina.it
#



#******* INPUT ********#
#$1 ==> log nel formato "TIMESTAMP NODE ERR-CATEGORY MESSAGE"
#$2 ==> filter: node name or category name
#**********************#

FILTER=$2


X=`echo $FILTER | grep -e "tg\-" -e "R[0-9][0-9]*-M"`

if [ $? -eq 0 ]
then
	echo ""
	echo -n "Filtering by NODE: $FILTER ... "
	cat $1 | awk '($2=="'$FILTER'") {print $0}' > $FILTER-$1
	echo "[DONE]"
	echo ""

else
	echo ""
	echo -n "Filtering by CATEGORY/CARD: $FILTER ... "
	cat $1 | awk '($3=="'$FILTER'") {print $0}' > $FILTER-$1
	echo "[DONE]"
	echo ""
fi
