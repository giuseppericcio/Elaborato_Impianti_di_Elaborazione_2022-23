#!/bin/bash


#
#       Group log entries in to tuples given a CWIN value. 
#	Software is distributed without any warranty.
#
#       Bugs should be reported to antonio.pecchia@unina.it
#




#******* INPUT ********#
#$1 ==> log nel formato "TIMESTAMP NODE ERR-CATEGORY MESSAGE"
#$2 ==> coalescence window selezionata con la "knee" rule
#**********************#


FNAME2=`echo $1 | perl -p -i -e "s/\.txt\///gi"`
FNAME3=`echo $FNAME2 | perl -p -i -e "s/\.txt//gi"`

FOLDER=`echo "tupling_$FNAME3-$2"`
mkdir $FOLDER

echo -n "" > $FOLDER/interarrivals.txt
echo -n "" > $FOLDER/lenghts.txt
echo -n "" > $FOLDER/startingPoints.txt


declare -i CWIN=$2
declare -i TsPrec=0
declare -i TsSucc=0
declare -i txcnt=1
declare -i diffx=0
declare -i tlen=0
declare -i first=0
declare -i ST=0
declare -i ED=0

echo "*** Grouping the entries for CWIN=$CWIN ***"

cat "$1" | while read LINE
do
	if [ "$first" -eq 0 ]
	then
		TsPrec=`echo $LINE | awk '{print $1}'`
		msg=`echo $LINE | awk '{print $0}'`
		echo "$msg" >> $FOLDER/tuple_$txcnt
		first=1
		echo "$txcnt" > $FOLDER/current
	else
		TsSucc=`echo $LINE | awk '{print $1}'`
		msg=`echo $LINE | awk '{print $0}'`
		diffx=$TsSucc-$TsPrec

		if [ $diffx -lt $CWIN ]
		then
			echo "$msg" >> $FOLDER/tuple_$txcnt
		else

			#==== salva i dati della "vecchia" tupla  === #
			echo "$diffx" >> $FOLDER/interarrivals.txt
			ST=`head -n 1 $FOLDER/tuple_$txcnt | awk '{print $1}'` 
			ED=`tail -n 1 $FOLDER/tuple_$txcnt | awk '{print $1}'`
			tlen=$ED-$ST

			echo "$tlen" >> $FOLDER/lenghts.txt
			echo "$ST $tlen" >> $FOLDER/startingPoints.txt
			#===============#

			echo "  - creating tuple # $txcnt"

			txcnt=$txcnt+1
			echo "$msg" >> $FOLDER/tuple_$txcnt
			echo "$txcnt" > $FOLDER/current
		fi

		TsPrec=$TsSucc
	fi
done


#====== ultima tupla =======#
txcnt=`cat $FOLDER/current`
ST=`head -n 1 $FOLDER/tuple_$txcnt | awk '{print $1}'`
ED=`tail -n 1 $FOLDER/tuple_$txcnt | awk '{print $1}'`
tlen=$ED-$ST
echo "$tlen" >> $FOLDER/lenghts.txt
echo "$ST $tlen" >> $FOLDER/startingPoints.txt
rm $FOLDER/current
#========== DONE =====================#


#sort $FOLDER/lenghts | uniq -c | sort -n | awk '{print $2,$1}' | sort -n > $FOLDER/temp
#mv $FOLDER/temp $FOLDER/lenghts
#sort $FOLDER/interarrivals | uniq -c | sort -n | awk '{print $2,$1}' | sort -n > $FOLDER/temp
#mv $FOLDER/temp $FOLDER/interarrivals
