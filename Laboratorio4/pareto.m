clc, clear all, close all

[iter, f1, f2] = textread('resultsHops.dat', '%s %f %f', 20);

figure
plot(f1,f2,'-o')
title('Frente de Pareto')
xlabel('f1')
ylabel('f2')


