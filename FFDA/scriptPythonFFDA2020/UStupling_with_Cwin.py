#!/usr/bin/python

import os
import sys
import shutil

#leggo il path del file di log e la dimensione della finestra W
logfile = sys.argv[1]
cwinsize = sys.argv[2]

#leggo il file di log, ho una list di string in loglines
logfiled = open(logfile,"r")
loglines = logfiled.readlines()

#line è una lista che contiene varie stringhe ottenute splittando l'entry corrente rispetto al carattere " " (spazio)
line = loglines[0].split()
#prev contiene il timestamp della prima log entry 
prev = line[0]

#se non esiste creo una directory dove saranno collezionate tutte tuple risultanti
directory="tupling_"+logfile.split(".")[0]+"-"+str(cwinsize)
if not os.path.exists(directory):
    os.makedirs(directory)

i=0
#conteggio del numero di tuple create
tcount=1

#scrivo la prima log entry nella prima tupla
f = open(directory+'/tuple'+str(tcount)+'.txt', 'w')
f.write(loglines[i])

#creo dei file in scrittura per salvare gli interarrivi,
#ovvero la differenza tra il timestamp della prima log entry della tupla corrente e il timestamp dell'ultima log entry della tupla precedente (TTF)
finterarrivals = open(directory+'/interarrivals.txt', 'w')
#la lunghezza della tupla, ovvero la differenza tra il timestamp dell'ultima log entry con quello della prima
flengths = open(directory+'/lengths.txt', 'w')
#startingPoints, ovvero il timestamp della prima log entry di ogni tupla creata
fstartingPoints = open(directory+'/startingPoints.txt', 'w')

i = i + 1
j = 0
#scandisco tutte le log entry
while i < len(loglines):
	line = loglines[i].split()
	#succ contiene il timestamp della log entry corrente
	succ = line[0]

	#calcolo delta, ovvero la differenza tra il timestamp della log entry corrente e il timestamp della log entry precedente
	delta = int(succ) - int(prev)

	#se tale differenza delta è minore della dimensione scelta per la finestra
	if int(delta)<int(cwinsize):
		j = j + 1
		#scrivo la log entry corrente nella tupla corrente
		f.write(loglines[i])
	else:
		#se sono in questo ramo devo concludere la tupla corrente e creare la tupla successiva
		#concludo la tupla corrente
		
		#qui scrivo la lunghezza della tupla
		diffTime=int(loglines[i-1].split()[0])-int(loglines[i-j-1].split()[0])
		flengths.write(str(diffTime)+'\n')
		#qui scrivo startingPoints
		fstartingPoints.write(str(int(loglines[i-j-1].split()[0]))+' '+str(diffTime)+'\n')
		#qui scrivo interarrivi
		finterarrivals.write(str(delta)+'\n')
		#chiudo il file della tupla corrente
		f.close()

		#creo la tupla successiva
		#inizializzo il numero di log entry nella nuova tupla appena creata
		j=0
		#incremento il conteggio delle tuple create
		tcount = int(tcount) + 1
		#apro un file in scrittura per collezionare i risultati della tupla tcount
		f = open(directory+'/tuple'+str(tcount)+'.txt', 'w')
		#scrivo la log entry corrente nella tupla appena creata
		f.write(loglines[i])

	#il timestamp della log entry corrente diventa il timestamp della log entry precendente (mi preparo ad una nuova iterazione)
	prev = succ
	i = i + 1

#chiudo i file
fstartingPoints.close()
flengths.close()
finterarrivals.close()
f.close()

