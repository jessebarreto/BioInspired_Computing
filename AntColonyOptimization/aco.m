%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA103
% Project Title: Ant Colony Optimization for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Problem Definition

model=CreateModel();

CostFunction=@(tour) TourLength(tour,model);

nVar=model.n;


%% ACO Parameters

MaxIt=200;      % Maximum Number of Iterations

nAnt=10;        % Number of Ants (Population Size)

Q=1;

tau0=10*Q/(nVar*mean(model.D(:)));	% Initial Phromone

alpha=1;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight

rho=0.05;       % Evaporation Rate


%% Initialization

eta=1./model.D;             % Heuristic Information Matrix

tau=tau0*ones(nVar,nVar);   % Phromone Matrix

BestCost=zeros(MaxIt,1);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestSol.Cost=inf;


%% ACO Main Loop

for it=1:MaxIt
    
    % for every ant Move Ants
    for k=1:nAnt
        
        % Selects the first city at random
        ant(k).Tour=randi([1 nVar]);
        
        % Complete the route until it visits every city
        for l=2:nVar
            
            i=ant(k).Tour(end);
            
            % Calculates pheromone track to every city
            P=tau(i,:).^alpha.*eta(i,:).^beta;
            % In the same city must be 0 (Can't travel to the same city
            % again)
            P(ant(k).Tour)=0;
            
            % Normalize Vector
            P=P/sum(P);
            
            % Selects Next city at random 
            j=RouletteWheelSelection(P);
            
            % Adds randomly selected next city in Tour array
            ant(k).Tour=[ant(k).Tour j];
            
            % Does it all over again until the ant visits every city
        end
        
        % Calculates the total tour distance
        ant(k).Cost=CostFunction(ant(k).Tour);
        
        % Selects the best tour until now
        if ant(k).Cost<BestSol.Cost
            BestSol=ant(k);
        end
        
    end
    
    % Update Phromones
    % As time passes by pheromone will evaporate and thus the less favored
    % tours will lost it's track leaving only the best tour
    for k=1:nAnt
        
        tour=ant(k).Tour;
        
        tour=[tour tour(1)]; %#ok
        
        for l=1:nVar
            
            i=tour(l);
            j=tour(l+1);
            
            tau(i,j)=tau(i,j)+Q/ant(k).Cost;
            
        end
            
    end
    
    % Evaporation
    tau=(1-rho)*tau;
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Solution
    figure(1);
    PlotSolution(BestSol.Tour,model);
    pause(0.01);
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

