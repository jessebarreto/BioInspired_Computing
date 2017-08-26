%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Plot implemented cost functions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

% Plot characteristics
dimension = 2;
ranges = [-10, 10; -10, 10];
npoints = 100;

% Plot Spheric Cost Function
functionName = string('sphere');
[space, sphere] = costFunction(functionName, dimension, ranges, npoints);
figure(1);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, sphere);
view(20,40);
mesh(space{1}, space{2}, sphere);
title('Sphere Cost Function - Z = X^2 + Y^2');
saveas(figure(1), 'Figures/Sphere.png');

% Plot Quadric Cost Function
functionName = string('quadric');
[space, quadric] = costFunction(functionName, dimension, ranges, npoints);
figure(2);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, quadric);
view(20,40);
mesh(space{1}, space{2}, quadric);
title('Quadric Cost Function - Z = X^2 + (X + Y)^2');
saveas(figure(2), 'Figures/Quadric.png');

% Plot Elliptic Cost Function
functionName = string('elliptic');
[space, elliptic] = costFunction(functionName, dimension, ranges, npoints);
figure(3);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, elliptic);
view(20,40);
mesh(space{1}, space{2}, elliptic);
title('Elliptic Cost Function - Z = X^2 + 10 Y^2');
saveas(figure(3), 'Figures/Elliptic.png');

% Plot Rastrigin Cost Function
functionName = string('rastrigin');
[space, rastrigin] = costFunction(functionName, dimension, ranges, npoints);
figure(4);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, rastrigin);
view(20,40);
mesh(space{1}, space{2}, rastrigin);
title('Rastrigin Cost Function - $$X^2 - 10cos(2\pi X) + 10 + (Y^2 - 10cos(2\pi Y) + 10$$','Interpreter','latex');
saveas(figure(4), 'Figures/Rastrigin.png');

% Plot Rosenbrock Cost Function
functionName = string('rosenbrock');
[space, rosenbrock] = costFunction(functionName, dimension, ranges, npoints);
figure(5);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, rosenbrock);
view(20,40);
mesh(space{1}, space{2}, rosenbrock);
title('Rosenbrock Cost Function - 100 (X^2 - Y)^2 + (X - 1)^2');
saveas(figure(5), 'Figures/Rosenbrock.png');


% Plot Ackley Cost Function
functionName = string('ackley');
[space, ackley] = costFunction(functionName, dimension, ranges, npoints);
figure(6);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, ackley);
view(20,40);
mesh(space{1}, space{2}, ackley);
title('Ackley Cost Function - $$-20 e^{(-0.2 \sqrt{\frac{(X^2 + Y^2)}{2}})} - e^{((\frac{cos(2\pi X) + cos(2\pi Y))}{2})} + 20 + e$$','Interpreter','latex');
saveas(figure(6), 'Figures/Ackley.png');

% Plot Schwefel Cost Function
functionName = string('schwefel');
[space, schwefel] = costFunction(functionName, dimension, ranges, npoints);
figure(7);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, schwefel);
view(20,40);
mesh(space{1}, space{2}, schwefel);
title('Schwefel Cost Function - $$837.9658 - X sin(\sqrt{|X|}) - Y sin(\sqrt{|Y|})$$','Interpreter','latex');
saveas(figure(7), 'Figures/Schwefel.png');
