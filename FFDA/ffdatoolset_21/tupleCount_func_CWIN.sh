#!/bin/bash

#
#	Estimate the tuple count. Software is distributed
#	without any warranty.
#
#	Bugs should be reported to antonio.pecchia@unina.it
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



cat "$2" | while read CW
do

##echo "Tentative Cwin: $CW" 

declare -i tcount=0
declare -i CWIN=$CW
declare -i TsPrec=0
declare -i TsSucc=0
declare -i txcnt=1
declare -i diffx=0
declare -i first=0

cat "$1" | while read LINE
do
	if [ "$first" -eq 0 ]
	then
#		echo "  - creating tuple # $txcnt"

		TsPrec=`echo $LINE | awk '{print $1}'`
		msg=`echo $LINE | awk '{print $0}'`
	#	echo "$msg" >> tuple_$txcnt
		first=1
		echo "$txcnt" > current
	else
		TsSucc=`echo $LINE | awk '{print $1}'`
		msg=`echo $LINE | awk '{print $0}'`
		diffx=$TsSucc-$TsPrec

		if [ $diffx -lt $CWIN ]
		then
			echo -n ""
		#	echo "$msg" >> tuple_$txcnt
		else
			txcnt=$txcnt+1
			#echo "	- creating tuple # $txcnt"
			#echo "$msg" >> tuple_$txcnt
			echo "$txcnt" > current
		fi
		TsPrec=$TsSucc
	fi
done

tcount=`cat current`
rm current

echo "$CWIN  $tcount"
echo "$CWIN  $tcount" >> $FNAME

done
