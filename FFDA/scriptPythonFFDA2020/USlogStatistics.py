#!/usr/bin/python

import os
import sys
import shutil
import re

# leggo da terminale il path del file di log
logfile = sys.argv[1]

#leggo il file di log, ho una list di string in loglines
logfiled = open(logfile,"r")
loglines = logfiled.readlines()

#stampo il numero di righe nel log 
print("== Total error entries ==")
print(len(loglines))

#dichiaro pretty per stampare in modo user-friendly un dizionario d
#in particolare ritorna una list lista a partire dal dizionario d
def pretty(d):
    lista=[]
    for key, value in sorted(d.items(),key=lambda d:-d[1]):
        lista.append(key+" -> "+str(value))
    return lista

#inidica per ogni nodo (i=1) e per ogni categoria (i=2) il numero di entry relative nel file log
for i in range(1,3):
    count={}
    #values contiene tutti i nodi (i=1) e tutte le categorie (i=2) nel file log
    #la funzione di map associa ad ogni elemento di loglines (tutte le tuple) il relativo nodo (i=1) e la relativa categoria (i=2)
    #la funzione set fa in modo che ogni elemento sia presente una sola volta
    values = set(map(lambda x:x.split()[i], loglines))
    for x in values:
        #per ogni log entry
        for y in loglines:
            #se la log entry corrente è stata generata dal nodo x (i=1) o appartiene alla categoria x (i=2) 
            if y.split()[i]==x:
                    #se è il primo elemento, inizializzo il conteggio per quel nodo (i=1) o per quella categoria (i=2)
                    if x not in count:
                        count[x] = 1
                    #incremento il conteggio
                    else:
                        count[x] = count[x] + 1

    #stampo l'output per i nodi                    
    if i==1:
        count1=count
        print("== Breakup by NODE* ==")
        print(pretty(count)[:10])
        print("* only the 10 most occurring nodes are reported")
    #stampo l'output per le categorie
    elif i==2:
        print("== Breakup by CATEGORY ==")
        print(pretty(count))