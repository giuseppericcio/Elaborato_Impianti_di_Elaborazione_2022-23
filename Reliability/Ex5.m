clc, clear

t = 3600;

lambda_CPU = 1/(10000*3600);
lambda_RT = 1/(4500*3600);
lambda_BUS = 1/(60000*3600);
lambda_INS = 1/(2000*3600);
lambda_Doppler = 1/(500*3600);
lambda_AHRS = 1/(2000*3600);

R_CPU = exp(-lambda_CPU*t);
R_RT = exp(-lambda_RT*t);
R_BUS = exp(-lambda_BUS*t);
R_INS = exp(-lambda_INS*t);
R_Doppler = exp(-lambda_Doppler*t);
R_AHRS = exp(-lambda_AHRS*t);

Rsys = (1 - (1 - R_CPU)^2)*(1 - (1 - R_RT)^2)*(1 - (1 - R_BUS)^2)^2*(1 - (1 - R_INS)*(1 - R_Doppler*(1 - (1 - R_AHRS)^3)))

Rsys_parz = (1 - (1 - R_RT)^2)*(1 - (1 - R_BUS)^2)^2*(1 - (1 - R_INS)*(1 - R_Doppler*(1 - (1 - R_AHRS)^3)));

C = 1/R_CPU - 1/R_CPU/(1-R_CPU) + 0.99999/R_CPU/(1-R_CPU)/Rsys_parz