clc, clear

t = 48;
lambda = 0.005;
Rm = exp(-lambda*t);

Rsys = Rm^8 + 8*Rm^7*(1-Rm) + 20*Rm^6*(1-Rm)^2 + 16*Rm^5*(1-Rm)^3 + 2*Rm^4*(1-Rm)^4