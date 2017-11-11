%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% PSO+AR Function Tester Parameters
% 

% Colocar o loop for para todo o algoritmo ficar no loop for e inicializar as variaveis que armazenam todos os valores das melhores posicoes globais para cada experimento
% e uma variavel para armazenar os 500 valores para cada experimento e ao final e o tamanho do vetor para que ele represente o correto valor.

% Exportar o grafico como pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

% PARAMETERS
numberOfExperimentsPerParameters = 32;

% Max number of iterations
maxIterations = 1000;

S = [20]; %number of particles
N = [6 9 13 18 22]; %number of dimensions
functionNames = [string('quadric') string('sphere') string('griewank') string('rastrigin') string('rosenbrock') string('ackley') string('schwefel') string('michalewicz')];

figureNumber = 1;

% Variables which will hold all results
experimentValues = zeros(numel(S), numel(N), numel(functionNames), numberOfExperimentsPerParameters);
averages = zeros(numel(S), numel(N), numel(functionNames));
medians = zeros(numel(S), numel(N), numel(functionNames));
minimums = zeros(numel(S), numel(N), numel(functionNames));
stdDevs = zeros(numel(S), numel(N), numel(functionNames));
goalReachPercentage = zeros(numel(S), numel(N), numel(functionNames));

% Holds the current day and time
YMDHMS = clock;
timedate = [num2str(YMDHMS(1)) '-' num2str(YMDHMS(2),'%02d') '-' num2str(YMDHMS(3),'%02d') '_' num2str(YMDHMS(4),'%02d') '-' num2str(YMDHMS(5),'%02d') '-' num2str(floor(YMDHMS(6)),'%02d')];

for s = 1:numel(S)
    npar = S(s);
	for d = 1:numel(N)
        dim = N(d);
		for f = 1:numel(functionNames)
            functionName = functionNames(f);
            
            allValues = zeros(maxIterations, numberOfExperimentsPerParameters);
            bestValues = zeros(numberOfExperimentsPerParameters, 1);
            bestPositions = zeros(numberOfExperimentsPerParameters, dim);
            times = zeros(numberOfExperimentsPerParameters, 1);
            
            % Obtain the range domain for the function
            [res, searchSpace, globalMin] = costFunction(functionName, zeros(dim, 1));

            % Direction
            dir = 1; %direction

            % Threshold
            threshold = globalMin + 0.01;
            if f ~= 8 %Michalewisk
               threshold = globalMin + dim * 0.01;
            end

            % Iterations Weights
            initialWeight = 0.9;
            finalWeight = 0.1;
            weightValues = linspace(initialWeight, finalWeight, maxIterations);

            % Max speed is half the range space
            vMax = abs(searchSpace(1,2)-searchSpace(1,1)) * .5;
            vInitial = vMax / 3;

            % Cognitive Coefficients
            c1 = 2.05;
            c2 = 2.05;

            % Diversity Parameters
            divMin =  5.0e-6;
            divMax = 0.25;
            
            % Run all experiments
            for experiment = 1:numberOfExperimentsPerParameters
                [spentTime, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = psoArFunction(functionName, searchSpace, dim, npar, maxIterations, threshold, dir, vInitial, vMax, initialWeight, finalWeight, c1, c2, divMin, divMax);

                figure(figureNumber);
                set(gcf,'Visible', 'off');
                hold on;
                plot(bestMinimumValues,'-.r');

                xlabel('Number of iterations','FontSize',12);
                ylabel('best fitness function','FontSize',12);
                % 				axis([0 maxIterations 1E-10 1E2]);
                title('Curva de convergencia PSO OBL S=' + string(npar) + ' N=' + string(dim) + ' ' + string(functionName));

                % Saves individual results to later analysis
                times(experiment, :) = spentTime;
                bestPositions(experiment, :) = bestMinimumPosition;
                bestValues(experiment, 1) = bestMinimumValue;
                allValues(:, experiment) = bestMinimumValues;
            end
            
            plotFinal = plot(mean(allValues, 2), '-b'); 
            legend(plotFinal, 'PSOAR Average');
            
            saveas(figure(figureNumber), char(string(string('ResultsPSOAR/PSO_S=') + string(npar) + string('_N=') + string(dim) + string('_') + string(functionName) + string('_') + string(timedate) + string('.fig'))));
            
            % saves data
            experimentValues(s, d, f, :) = bestValues;
            averages(s, d, f) = mean(bestValues);
            medians(s, d, f) = median(bestValues);
            minimums(s, d, f) = min(bestValues);
            stdDevs(s, d, f) = std2(bestValues);
            goalReachPercentage(s, d, f) = sum(bestValues < threshold) / numberOfExperimentsPerParameters;
            
            figureNumber = figureNumber + 1;
		end
    end 
end

save(char(string(string('ResultsPSOAR/experimentValues_') + string(timedate) + string('.mat'))), 'experimentValues');
save(char(string(string('ResultsPSOAR/averages_') + string(timedate) + string('.mat'))), 'averages');
save(char(string(string('ResultsPSOAR/medians_') + string(timedate) + string('.mat'))), 'medians');
save(char(string(string('ResultsPSOAR/mins_') + string(timedate) + string('.mat'))), 'minimums');
save(char(string(string('ResultsPSOAR/stdDevs_') + string(timedate) + string('.mat'))), 'stdDevs');
save(char(string(string('ResultsPSOAR/goalReachPercentage_') + string(timedate) + string('.mat'))), 'goalReachPercentage');
