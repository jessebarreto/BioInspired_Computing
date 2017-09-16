%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Plot implemented cost functions in 2-D.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear;

% Plot characteristics
dimension = 2;
ranges = [-10, 10; -10, 10];
npoints = 100;

% Plot Spheric Cost Function
functionName = string('sphere');
[space, sphere] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
[space, quadric] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
[space, elliptic] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
[space, rastrigin] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
[space, rosenbrock] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
[space, ackley] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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
ranges = [-500 500; -500 500];
[space, schwefel] = costFunctionSymNum(functionName, dimension, ranges, npoints);
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

% Plot Bukin6 Cost Function
functionName = string('bukin6');
ranges = [-10 10; -10 10];
[space, bukin6] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(8);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, bukin6);
view(20,40);
mesh(space{1}, space{2}, bukin6);
title('Bukin6 Cost Function - $$100 * \sqrt{\mid Y - 0.01 X^2 \mid} + 0.01 \mid X + 10 \mid$$','Interpreter','latex');
saveas(figure(8), 'Figures/Bukin6.png');

% Plot Cross-In-Tray Cost Function
functionName = string('cross-in-tray');
[space, crossintray] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(9);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, crossintray);
view(20,40);
mesh(space{1}, space{2}, crossintray);
title('Cross-In-Tray Cost Function - $$-0.0001 \big( \mid sin(X) sin(Y) e^{\mid 100 - \frac{(\sqrt{X^2 + Y^2}}{\pi} \mid} \mid + 1 \big)^{0.1}$$','Interpreter','latex');
saveas(figure(9), 'Figures/CrossInTray.png');

% Plot Drop-Wave Cost Function
functionName = string('drop-wave');
ranges = [-5, 5; -5, 5];
[space, dropwave] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(10);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, dropwave);
view(20,40);
mesh(space{1}, space{2}, dropwave);
title('Drop-Wave Cost Function - $$-\frac{1 + cos(12 \sqrt{X^2 + Y^2})}{0.5 (X^2 + Y^2) + 2}$$','Interpreter','latex');
saveas(figure(10), 'Figures/DropWave.png');

% Plot Eggholder Cost Function
functionName = string('eggholder');
ranges = [-512, 512;-512, 512];
[space, eggholder] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(11);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, eggholder);
view(20,40);
mesh(space{1}, space{2}, eggholder);
title('EggHolder Cost Function - $$-(Y + 47) \sin\bigg(\sqrt{\mid Y + \frac{X}{2} + 47 \mid}\bigg) - X \sin\bigg(\sqrt{\mid X - (Y + 47) \mid }\bigg)$$','Interpreter','latex');
saveas(figure(11), 'Figures/EggHolder.png');

% Plot Griewank Cost Function
functionName = string('griewank');
ranges = [-25, 25;-25, 25];
[space, griewank] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(12);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, griewank);
view(20,40);
mesh(space{1}, space{2}, griewank);
title('Griewank Cost Function - $$\sum_{i=1}^{N}\frac{{X_i}^2}{4000} - \prod_{i=1}^{N}\cos\bigg( \frac{X_i}{\sqrt{i}}\bigg) + 1$$','Interpreter','latex');
saveas(figure(12), 'Figures/Griewank.png');

% Plot Holder Table Cost Function
functionName = string('holdertable');
ranges = [-10, 10;-10, 10];
[space, holdertable] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(13);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, holdertable);
view(20,40);
mesh(space{1}, space{2}, holdertable);
title('Holder Table Cost Function - $$- \mid \sin(X) cos(Y) e^{\mid 1 - \frac{\sqrt{X^2 + Y^2}}{\pi} \mid}\mid$$','Interpreter','latex');
saveas(figure(13), 'Figures/HolderTable.png');

% Plot Levy Cost Function
functionName = string('levy');
ranges = [-10, 10;-10, 10];
[space, levy] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(14);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, levy);
view(20,40);
mesh(space{1}, space{2}, levy);
title('Levy Cost Function','Interpreter','latex');
saveas(figure(14), 'Figures/Levy.png');

% Plot Michalewicz Cost Function
functionName = string('michalewicz');
ranges = [-pi, pi;-pi, pi];
[space, michalewicz] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(15);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, michalewicz);
view(20,40);
mesh(space{1}, space{2}, michalewicz);
title('Michalewicz Cost Function','Interpreter','latex');
saveas(figure(15), 'Figures/Michalewicz.png');

% Plot Styblinski-Tang  Cost Function
functionName = string('styblinskitang ');
ranges = [-5, 5;-5, 5];
[space, styblinskitang] = costFunctionSymNum(functionName, dimension, ranges, npoints);
figure(16);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Cost Function Value');
contour(space{1}, space{2}, styblinskitang);
view(20,40);
mesh(space{1}, space{2}, styblinskitang);
title('Styblinski-Tang Cost Function','Interpreter','latex');
saveas(figure(16), 'Figures/StyblinskiTang .png');
