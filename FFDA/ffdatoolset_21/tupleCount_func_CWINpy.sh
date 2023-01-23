#!/bin/bash

#
#       Estimate the tuple count. Software is distributed
#       without any warranty.
#
#       Bugs should be reported to antonio.pecchia@unina.it
#



#******* INPUT ********#
#$1 ==> log nel formato "TIMESTAMP NODE ERR-CATEGORY MESSAGE"
#$2 ==> file con le finestre di coalescenza "tentativo"
#**********************#



FNAME2=`echo $1 | perl -p -i -e "s/\.txt\///gi"`
FNAME3=`echo $FNAME2 | perl -p -i -e "s/\.txt//gi"`


FNAME=`echo "tupleCount-$FNAME3.txt"`
touch $FNAME
echo -n "" > $FNAME

cat "$2" | while read CWIN
do
	python tuplesWithCWIN.py $1 $CWIN >> $FNAME	
done 

cat $FNAME
