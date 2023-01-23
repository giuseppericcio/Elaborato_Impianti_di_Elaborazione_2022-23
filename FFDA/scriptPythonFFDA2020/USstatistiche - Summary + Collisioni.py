#!/usr/bin/python

import os
import sys
import shutil

#leggo il path della directory che contiene le tuple di cui voglio generare le statistiche
directory = sys.argv[1]
if not os.path.exists(directory):
	print("La directory in input non esiste.")

from os import listdir
from os.path import isfile, join
#onlyfiles è una lista di tutti i nomi dei file contenuti nella directory in input
onlyfiles = [f for f in listdir(directory) if isfile(join(directory, f))]

#vado a rimuovere dalla lista i nomi dei file passati, ovvero tutti i nomi dei file che non sono tuple
if 'interarrivals.txt' in onlyfiles:
	onlyfiles.remove('interarrivals.txt')
if 'lengths.txt' in onlyfiles:
	onlyfiles.remove('lengths.txt')
if 'startingPoints.txt' in onlyfiles:
	onlyfiles.remove('startingPoints.txt')
if 'statistiche.txt' in onlyfiles:
	onlyfiles.remove('statistiche.txt')
if 'collisioni.txt' in onlyfiles:
	onlyfiles.remove('collisioni.txt')
if 'troncamenti.txt' in onlyfiles:
	onlyfiles.remove('troncamenti.txt')

import re
#ordina le tuple in maniera crescente, ovvero rispetto al numero della tupla
onlyfiles.sort(key=lambda var:[int(x) if x.isdigit() else x for x in re.findall(r'[^0-9]|[0-9]+', var)])

#apro un file in scrittura per collezionare i risultati (summary)
f=open(directory+"/statistiche.txt","w")
#scrivo l'intestazione
f.write("file #elem startingPoint length interarrivo result \n")

#apro un file in scrittura per collezionare i risultati delle possibili collsioni
fcollisioni=open(directory+"/collisioni.txt","w")

prec=0

#determino il file di log da aprire (se BGL o Mercury)
if not re.search(".*BGL.*",directory):
	logfileorigin=open("Mercury/MercuryErrorLog.txt","r")
else:
	logfileorigin=open("BGL/BGLErrorLog.txt","r")

#per ogni tupla
for namefile in onlyfiles:
	#leggo la tupla 
	logfiled = open(directory+"/"+namefile,"r")
	loglines = logfiled.readlines()
	
	#scrivo le statistiche summary sul file di output
	#nome del file della tupla
	f.write(namefile+" ")
	# num di elementi della tupla
	f.write(str(len(loglines))+" ")
	# startingPoint della tupla
	f.write(loglines[0].split()[0]+" ")
	# length della tupla
	f.write(str(int(loglines[len(loglines)-1].split()[0])-int(loglines[0].split()[0]))+" ")
	# interarrivo della tupla
	f.write(str(int(loglines[0].split()[0])-prec)+" ")

	#conto per ogni tupla il numero di log entry relative ad ogni nodo contenuto nella tupla e ad ogni categoria contenuta nella tupla
	countList=[]
	valuesList=[]
	for i in range(1,3):
		count={}
		values = set(map(lambda x:x.split()[i], loglines))
		for x in values:
			for y in loglines:
				if y.split()[i]==x:
						if x not in count:
							count[x] = 1
						else:
							count[x] = count[x] + 1
		countList.append(count)
		valuesList.append(values)
	#scrivo i risulati nel file
	f.write(str(countList[0])+" ")
	f.write(str(countList[1])+" ")
	f.write("\n")
	
	#il timestamp dell' ultima log entry della tupla corrente viene conservato per calcolare l'interarrivo
	prec=int(loglines[len(loglines)-1].split()[0])

	#mi occupo delle collisioni
	#se sono stati rilevati all'interno della stessa tupla almeno due nodi diversi allora considero una collisione in quella tupla
	if len(valuesList[0])>1:
		fcollisioni.write(namefile+" -> "+str(len(valuesList[0]))+"\n")

#chiudo il file
fcollisioni.close()
f.close()
