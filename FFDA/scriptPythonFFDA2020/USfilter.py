#!/usr/bin/python

import os
import sys
import shutil
import re

#leggo il path del file di log e il campo su cui effettuare il filtraggio
logfile = sys.argv[1]
filtro = sys.argv[2]

#leggo il file di log, ho una list di string in loglines
logfiled = open(logfile,"r")
loglines = logfiled.readlines()

#determino se ho a che fare con un filtraggio su nodo o su categoria
decisione=0
if re.search("^tg.*", filtro) or re.search("^R.*", filtro):
	decisione=1

#apri un file in scrittura per collezionare i risultati
nameFile=filtro+".txt"
i=0
f = open(nameFile, 'w')

#scandisco tutte le entry del log
while i < len(loglines):
	#line è una lista che contiene varie stringhe ottenute splittando l'entry corrente rispetto al carattere " " (spazio)
	line = loglines[i].split()
	
	#sto effettuando un filtraggio sulla categoria
	if decisione == 0:
		#se la categoria della log entry corrente è uguale a quella di interesse
		if line[2] == filtro:
			#scrivi la log entry corrente nel file di output
			f.write(loglines[i])
	#filtraggio su nodo
	else:
		#se il nodo della log entry corrente è uguale a quello di interesse
		if line[1] == filtro:
			#scrivi la log entry corrente nel file di output
			f.write(loglines[i])			

	i = i + 1

#chiudo il file
f.close()

