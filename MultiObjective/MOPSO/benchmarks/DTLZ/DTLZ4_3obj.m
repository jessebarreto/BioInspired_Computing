function y = DTLZ4_3obj(x)
% Objective function : Test problem 'DTLZ2'.
%*************************************************************************


y = [0, 0, 0];
N = size(x,2);
k = 10;
g = sum((x(N-k+1:end)-0.5).^2);
a = 100;

y(1) = (1+g) * cos(x(1)^a*pi/2) * cos(x(2)^a*pi/2);
y(2) = (1+g) * cos(x(1)^a*pi/2) * sin(x(2)^a*pi/2);
y(3) = (1+g) * sin(x(1)^a*pi/2);




