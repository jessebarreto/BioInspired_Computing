function y = DTLZ1_3obj(x)
% Objective function : Test problem 'DTLZ2'.
%*************************************************************************


y = [0, 0, 0];
N= size(x,2);
k = 2;
g = 100*(k + sum((x(N-k+1:end)-0.5).^2 - cos(20*pi*(x(N-k+1:end)-0.5)) ) );

y(1) = (1+g) * 0.5 * x(1) * x(2);
y(2) = (1+g) * 0.5 * x(1) * (1-x(2));
y(3) = (1+g) * 0.5 * (1-x(1));



