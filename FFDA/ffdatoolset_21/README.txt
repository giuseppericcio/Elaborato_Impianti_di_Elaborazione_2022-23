Contenuto di ffdatoolset:

Software di analisi descritto nella presentazione:
--------------------------------------------------

	1-tupleCount_func_CWIN.sh (oppure tupleCount_func_CWINpy.sh) 	*tuples count
		NOTA: tuplesWithCWIN.py NON va usato direttamente (è richiamato da tupleCount_func_CWINpy.sh)

	2-tupling_with_Cwin.sh						*tupling con CWIN selezionata
	3-logStatistics.sh						*statistiche sulle entry nel log
	4-filter.sh							*filtra per nodo o categoria error (o card nel caso BGL)


I 3 file di log:
--------------------------------------------------
	MercuryErrorLog.txt		-> HOMEWORK
	BGLErrorLog.txt			-> HOMEWORK

	MercuryErrorLogTEST.txt		-> (contiene le prime 10000 righe di MercuryErrorLog.txt, ed è stato usato
						per ottenere i risultati di esempio mostrati in aula)


I files .txt misc/sample_*
--------------------------------------------------
Alcuni valori del tuple count per MercuryErrorLog.txt e BGLErrorLog.txt, rispettivamente, da usare
come verifica della correttezza del count per i log dell'homework


Il file .txt tentative-Cwin.txt
--------------------------------------------------
Alcuni valori di finestre di coalescenza in sec da passare in input a tupleCount_func_CWIN* . E' possibile
inserire in tentative-Cwin.txt ulteriori valori per i quali determinare il tuple count.


Il file .txt misc/dictionary.txt 
--------------------------------------------------
Un esempio di dizionario da un datacenter reale.
