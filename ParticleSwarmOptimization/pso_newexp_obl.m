% Daniel Mauricio Mu�oz Arboleda
% Algoritmo PSO basico
% Maio de 2009.

function [out] = pso_numexp(num_exp)

format long g;
close all;
clc;

%% PSO PARAMETERS %%
dir = 1;
S = 20; %number of particles
N = 6; %number of dimensions
maxiter = 1500; % max number of iterations
w0 = 0.9; % initial weight
wf = 0.1; % final weight
w=zeros(maxiter,1);
w(1)= w0;
slope = (wf-w0)/maxiter;
c1 = 2; % cognitive coefficient
c2 = 2; %1.9999;%1.9999; % social coefficient
c3 = 0.5; % coeff de congregacao passiva
max_v = 3; % max velocity
ini_v = 0.5;
% Range domain for fitness function
x_max = 30.0;%8; %30; %500
x_min = -30.0; %-8; %-30; %-500
objfun=3; %1:fourpeaks, 2:sphere, 3:quadric, 4:rosenbrock, 5:rastrigin, 6:schwefel, 7:ackley, 8:griewangk
threshold = 1e-10;
k = 1;  % index of iteration

% INITIALIZATION
for j=1:N
    for i=1:S
        x(i,j) = x_min + (x_max-x_min) * rand();
        y(i,j) = x_min + (x_max-x_min) * rand();
        v(i,j) = ini_v;
    end
end
f_ind = 1e10*ones(maxiter,1); % initialize best fitness = 100

%% ITERATIVE PROCESS
while k<= maxiter
    % Evaluates fitness and detection
    for i = 1:S      
        switch objfun
            case 1 
                fx(i) = sphere(x(i,:));
            case 2 
                fx(i) = sphere(x(i,:));
            case 3 
                fx(i) = quadric(x(i,:));    
            case 4 
                fx(i) = rosenbrock(x(i,:));
            case 5 
                fx(i) = rastrigin(x(i,:));
            case 6 
                fx(i) = schwefel(x(i,:));
            case 7 
                fx(i) = ackley(x(i,:));
            case 8 
                fx(i) = griewangk(x(i,:));
            otherwise
                fx(i) = sphere(x(i,:));
        end

        if fx(i) < f_ind(i)
            y(i,:) = x(i,:);
            f_ind(i) = fx(i);           
        end
    end

    [bestfitness(k), p] = min(f_ind);
%     if bestfitness(k) < threshold
%         iter = k
%         bestfitness(k)
%         break;
%     end

    ys = y(p,:);

    sys = f_ind;
    sys(p) = [];
    [sys p] = min(sys);
    sys = y(p, :);
    
    % update particles
    for j = 1:N               
        for i=1:S
            r1 = rand();
            r2 = rand();
            r3 = rand();
            v(i,j) = w(k)*v(i,j) + dir*(c1*r1*(y(i,j)-x(i,j)) + c2*r2*(ys(j) - x(i,j)) + + c3*r3*(sys(j) - x(i,j)));
            if abs(v(i,j)) > max_v
                if v(i,j) > 0
                    v(i,j) = max_v;
                else
                    v(i,j) = -max_v;
                end
            end
            x(i,j) = x(i,j) + v(i,j);
            if abs(x(i,j)) > x_max
                if x(i,j) > 0
                    x(i,j) = x_max;
                else
                    x(i,j) = -x_max;
                end
            end            
        end
    end         
    k=k+1;
    w(k) = w(k-1) + slope;    
end

figure(2);
semilogy(bestfitness,'-r');
xlabel('Number of iterations','FontSize',12);
ylabel('best fitness function','FontSize',12);
legend('PSO basico')
axis([0 maxiter 1E-10 1E2]);
title('Curva de convergencia');
out = bestfitness(k-1);
disp(ys)
disp(sys);

