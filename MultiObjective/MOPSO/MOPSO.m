%function [out best] = pso2(f_num, N, S, obl_t)

format long g;
close all;
clear all;
clc;

%rng(0);
% rand('twister',12092014); 

%% PSO PARAMETERS %%
S = 100; %number of particles
N = 7; %number of dimensions
maxiter = 500; % max number of iterations
w0 = 0.9; % initial weight
wf = 0.3; % final weight
w= w0;
slope = (wf-w0)/maxiter;
c1 = 2.5; % cognitive coefficient
c2 = 1.5; % social coefficient

% Range domain for fitness function
x_max = 1; % max value no espaco de busca
x_min = 0; % min value no espaco de busca
max_v = 0.5; % max velocity
ini_v = max_v/10; % initial velocity

k = 1;  % index of iteration
x = zeros(S,N);
y = zeros(S,N);
v = zeros(S,N);

arc_size = 100;
n_obj = 3;      %Numero de funcoes objetivos
arc_x = [];
arc_f = [];
f_num = 'DTLZ2_3obj'; % funcao objetivo
PFstar = load ('DTLZ2_3obj.txt'); % carrega fronteira de pareto (quando existe)
% grafica fronteira de pareto
figure(1);
if n_obj == 3
    plot3(PFstar(:,1),PFstar(:,2),PFstar(:,3),'-k'); grid on; axis square
else 
    plot(PFstar(:,1),PFstar(:,2),'-k');
end

% INITIALIZATION
fx=1e10*ones(S,n_obj);
f_ind = 10^10*ones(S, n_obj); % initialize best local fitness 
for j=1:N
    for i=1:S
        x(i,j) = x_min + (x_max-x_min) * rand(); %vetor que armazena as partículas (i número de partículas)
        y(i,j) = 1e10;
        v(i,j) = ini_v;
    end
end
figure(2)
%% ITERATIVE PROCESS
while k<= maxiter
    % Evaluates fitness and local detection
    for i = 1:S
        fx(i,:)= feval(f_num, x(i,:));
        if fx(i,:) <= f_ind(i,:)
            y(i,:) = x(i,:);
            f_ind(i,:) = fx(i,:);           
        end
    end
    
    Arc_all = x;
    Arc_all_f = fx;
    arc_size = S;
%     Arc_all = [arc_x;x];
%     Arc_all_f = [arc_f; fx];
%     [aux,ia]=unique(Arc_all_f, 'rows');
%     Arc_all_f = Arc_all_f(ia,:);
%     Arc_all = Arc_all(ia,:);
%     [arc_x, arc_f, rank, CD] = truncate([Arc_all; x],[Arc_all_f; fx], arc_size);
    [arc_x, arc_f, rank, CD] = truncate(Arc_all,Arc_all_f, arc_size);

    ind_nd = rank == 1;
    nd_sols = sum(ind_nd);
    arc_x = arc_x(ind_nd,:);
    arc_f = arc_f(ind_nd,:);
    
    % global detection
%     ind_gbest = Randi(0.1*arc_size);
%     ys = arc_x(min([ind_gbest nd_sols]),:);  % calcula gbest
    ind_gbest = Randi(nd_sols);
    ys = arc_x(ind_gbest,:);  % calcula gbest
    
    % update particles
    for j = 1:N
        for i=1:S
            r1 = rand();
            r2 = rand();
%             v(i,j) = w*v(i,j) + c1*r1*(y(i,j)-x(i,j)) + c2*r2*(ys(j) - x(i,j));           
            v(i,j) = w*v(i,j) + c1*r1*(y(i,j)-x(i,j)) + c2*r2*(arc_x(Randi(ind_gbest),j) - x(i,j));           
            if abs(v(i,j)) > max_v
                if v(i,j) > 0
                    v(i,j) = max_v;
                else
                    v(i,j) = -max_v;
                end
            end
            x(i,j) = x(i,j) + v(i,j);
            if x(i,j) > x_max
                   x(i,j) = x_max;
            elseif x(i,j) < x_min
                x(i,j) = x_min;            
            end
        end
    end
    k=k+1;
    w = w+slope;
    
    % Grafica resultado
    if mod(k,20)== 0
        fprintf('Iteracao %d, n. sols. nao-dominadas: %d\n', k, size(arc_x,1));
        fprintf('ys = %f\n', ys);
        if n_obj == 3
            plot3(arc_f(:,1),arc_f(:,2),arc_f(:,3), ...
                'r*',PFstar(:,1),PFstar(:,2),PFstar(:,3),'-k'); ...
                grid on; axis auto;
        else
            plot(arc_f(:,1),arc_f(:,2), 'r*', PFstar(:,1),PFstar(:,2),'-k');
        end
        pause(0.1);      
    end
    
    % Obtendo os dados para convergencia
    aux1 = size(arc_f);
    % ind_pf = randi(1000, aux1(1,1), 1);
    ind_pf = Randi(1000, [aux1(1,1), 1]);
    PFstar1 = PFstar(ind_pf,:);
    igd(k)  = IGD(PFstar1, arc_f);
    dist(k) = spacing(arc_f);
    sols(k) = aux1(1,1);
end
figure(2)
if n_obj == 3
    plot3(arc_f(:,1),arc_f(:,2),arc_f(:,3), 'r*',PFstar(:,1),PFstar(:,2),PFstar(:,3),'-k'); grid on; axis auto;
else
    plot(arc_f(:,1),arc_f(:,2), 'r*', PFstar(:,1),PFstar(:,2),'-k');
end

%% Plotando as metricas de verificao da qualidade do PF.
t1 = 1:k;
figure(3)
plot(t1,igd)
title('Metrica IGD')
xlabel('Iteracoes', 'FontSize',12)
ylabel('IGD','FontSize',12)

figure(4)
plot(t1, dist)
title('Metrica Spacing')
xlabel('Iteracoes', 'FontSize',12)
ylabel('Spacing','FontSize',12)

figure(5)
plot(t1,sols)
title('Cardinalidade do conjunto Non-dominate')
xlabel('Iteracoes', 'FontSize',12)
ylabel('Solucoes','FontSize',12)

