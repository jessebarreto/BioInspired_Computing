function y = DTLZ5_3obj(x)
% Objective function : Test problem 'DTLZ2'.
%*************************************************************************


y = [0, 0, 0];
N = size(x,2);
k = 10;
g = sum((x(N-k+1:end)-0.5).^2);
t= x;
t(2:end) = (1 + 2*g.*x(2:end))/(2*(1+g));

y(1) = (1+g) * cos(t(1)*pi/2) * cos(t(2)*pi/2);
y(2) = (1+g) * cos(t(1)*pi/2) * sin(t(2)*pi/2);
y(3) = (1+g) * sin(t(1)*pi/2);




