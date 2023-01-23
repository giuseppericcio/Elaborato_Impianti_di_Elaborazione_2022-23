clc; clear;

real = xlsread('WorkloadRealeLL');
synthetic = xlsread('WorkloadSinteticoLL1');

N = size(real,2);
real = real (:,1:N-1);
synthetic = synthetic(:,1:N-1);

[norm_wl_real, p_value_norm_real] = kstest(real);
[norm_wl_synth, p_value_norm_synth] = kstest(synthetic);

figure();
subplot(2,1,1);
qqplot(real);
title('QQPlot Workload Reale LL')
subplot(2,1,2);
qqplot(synthetic);
title('QQPlot Workload Sintetico LL1')

figure();
subplot(2,1,1);
boxplot(real);
title('Box Plot Workload Reale LL')
subplot(2,1,2);
boxplot(synthetic);
title('Box Plot Workload Sintetico LL1')

%%Test Non Parametrico - Wilcoxon Test
p_wilc = zeros(1,N-1);
h_wilc = zeros(1,N-1);
for i = 1:N-1
    [p_wilc(i), h_wilc(i)] = ranksum(synthetic(:,i), real(:,i));
end