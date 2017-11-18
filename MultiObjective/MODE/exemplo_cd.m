% ilustra crowding distance
clear all
close all

Fit_all = [0.9 0.1;
    0.2 0.7;
    0.1 0.8;
    0.05 0.9;
    0.01 1;
    0.6 0.4];

[Var, Fit, rank, CD] = truncate(Fit_all,Fit_all,3);

plot(Fit_all(:,1),Fit_all(:,2),'bo',Fit(:,1),Fit(:,2),'rx')
legend('FP','FP truncada')