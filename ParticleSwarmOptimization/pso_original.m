% Sistemas Bioinspirados Aplicados a Engenharia
% Exemplo do algoritmo PSO canonico
% Daniel Mauricio Mu�oz Arboleda
% Graco - UnB
% Agosto de 2014.

function [out] = pso()

format long g;
close all;
clc;

%% PSO PARAMETERS %%
S = 20; %number of particles
N = 6; %number of dimensions
maxiter = 1000; % max number of iterations
w0 = 0.9; % initial weight
wf = 0.1; % final weight
w= w0;
slope = (wf-w0)/maxiter;
c1 = 2; % cognitive coefficient
c2 = 2; % social coefficient
max_v = 3; % max velocity
ini_v = max_v/10; % initial velocity
% Range domain for fitness function
x_max = 5.12; %500 for Schwefel and 32 for Ackley
x_min = -5.12; %-500 for Schwefel and -32 for Ackley
threshold = 1e-10;
k = 1;  % index of iteration

% Just for testing particles with the same intial position. 
% Uses the same seed for the random number generator
rand('twister',12092014); 

% INITIALIZATION
for j=1:N
    for i=1:S
        x(i,j) = x_min + (x_max-x_min) * rand();
        y(i,j) = 1e10;
        v(i,j) = ini_v;
    end
end

f_ind = 1e10*ones(S,1); % initialize best local fitness 

%% ITERATIVE PROCESS
while k<= maxiter
    % Evaluates fitness and local detection
    for i = 1:S
    %% Dica SBIE: implementar como fun��o recebendo parametros x(i,:) e N
        fx(i) = x(i,1)^2+x(i,2)^2+x(i,3)^2+x(i,4)^2+x(i,5)^2+x(i,6)^2; % Sphere function 
%         fx(i) = x(i,1)^2+(x(i,1)+x(i,2))^2+(x(i,1)+x(i,2)+x(i,3))^2+...
%                 (x(i,1)+x(i,2)+x(i,3)+x(i,4))^2+(x(i,1)+x(i,2)+x(i,3)+x(i,4)+x(i,5))^2+...
%                 (x(i,1)+x(i,2)+x(i,3)+x(i,4)+x(i,5)+x(i,6))^2; % Quadric function
%         fx(i) = 60+x(i,1)^2+x(i,2)^2+x(i,3)^2+ x(i,4)^2+x(i,5)^2+x(i,6)^2-...
%                 10*cos(2*pi*x(i,1))-10*cos(2*pi*x(i,2))-10*cos(2*pi*x(i,3))-...
%                 10*cos(2*pi*x(i,4))-10*cos(2*pi*x(i,5))-10*cos(2*pi*x(i,6)); % Rastrigin Function                 
%         fx(i) = 100*(x(i,2)-x(i,1)^2)^2+(1-x(i,1))^2+...
%                 100*(x(i,4)-x(i,3)^2)^2+(1-x(i,3))^2+...
%                 100*(x(i,6)-x(i,5)^2)^2+(1-x(i,5))^2; % Rosenbrock function
        if fx(i) < f_ind(i)
            y(i,:) = x(i,:);
            f_ind(i) = fx(i);           
        end
    end
    
    % global detection
    [bestfitness(k), p] = min(f_ind);
    ys = y(p,:);
    
    % update particles
    for j = 1:N               
        for i=1:S
            r1 = rand();
            r2 = rand();
            v(i,j) = w*v(i,j) + c1*r1*(y(i,j)-x(i,j)) + c2*r2*(ys(j) - x(i,j));
            if abs(v(i,j)) > max_v
                if v(i,j) > 0
                    v(i,j) = max_v;
                else
                    v(i,j) = -max_v;
                end
            end
            x(i,j) = x(i,j) + v(i,j);
        end
    end         
    k=k+1;
    w = w + slope;    
end

out = bestfitness(k-1); % gets the global best fitness after 1000 iterations
disp(ys) % display the solution of the optimization problem
