clc, clear, close all

t = linspace(0,10^7,1000);

lambda_a = 1/(900*3600);
lambda_b = 1/(7000*3600);
lambda_c = 1/(1000*3600);
Ra = exp(-lambda_a*t);
Rb = exp(-lambda_b*t);
Rc = exp(-lambda_c*t);

Rsys11 = 1 - (1 - Ra.*Rb).*(1 - Ra.*Rc);

Rsys21 = Ra .* (1 - (1 - Rb).*(1 - Rc));

plot(t,Rsys11)
hold on, plot(t,Rsys21)

xlabel('secondi');
ylabel('reliability');
legend('Primo Sistema','Secondo Sistema');

pause(), close all

Rsys12 = Ra .* (1 - (1 - Ra).*(1 - Rb));

Rsys22 = Ra;

plot(t,Rsys12)
hold on, plot(t,Rsys22)

xlabel('secondi');
ylabel('reliability');
legend('Primo Sistema','Secondo Sistema');

pause(), close all

Rsys13 = Ra .* Rb .* (1 - (1 - Ra).*(1 - Rb));

Rsys23 = Ra .* Rb;

plot(t,Rsys13)
hold on, plot(t,Rsys23)

xlabel('secondi');
ylabel('reliability');
legend('Primo Sistema','Secondo Sistema');

pause(), close all

Rsys14 = (1 - (1 - Ra).*(1 - Ra.*Rb));

Rsys24 = Ra;

plot(t,Rsys14)
hold on, plot(t,Rsys24)

xlabel('secondi');
ylabel('reliability');
legend('Primo Sistema','Secondo Sistema');