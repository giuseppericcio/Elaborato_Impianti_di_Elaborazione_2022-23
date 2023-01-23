clc, clear

% Inserire i dati della variabile indipendente (X) e della variabile dipendente (Y)
Y = xlsread("HomeWork_Regression_2022","EXP1","D:D");
X = xlsread("HomeWork_Regression_2022","EXP1","A:A");

% Calcolare l'intercetta e la pendenza della retta di regressione di Theil-Sen
[m,b,slopes] = theilslope(X,Y);

% Calcolare l'intervallo di confidenza al 95% per la pendenza utilizzando bootci
CI = bootci(1000, @(X,Y) theilslope(X,Y), 'alpha', 0.95);

% Stampa dei risultati
fprintf('L''intervallo di confidenza per la pendenza è: [%f, %f]\n', CI(1), CI(2))