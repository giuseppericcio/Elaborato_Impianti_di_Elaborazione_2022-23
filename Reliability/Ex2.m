clc, clear

t = linspace(0,10^7,1000);

lambda = 1/(1400*3600);
R = exp(-lambda*t);

Rsys1 = 1 - (1 - R.^3).^5;

Rsys2 = (1 - (1 - R).^5).^3;

plot(t,Rsys1)
hold on, plot(t,Rsys2)

xlabel('secondi');
ylabel('reliability');
legend('Primo Sistema','Secondo Sistema');

miss_time = (1400*3600);
R_mod = exp(-lambda*miss_time);

R1 = 1 - (1 - R_mod.^3).^5
R2 = (1 - (1 - R_mod).^5).^3