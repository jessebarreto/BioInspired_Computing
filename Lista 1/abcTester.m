%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% PSO Function Tester Parameters
% 

% Colocar o loop for para todo o algoritmo ficar no loop for e inicializar as variaveis que armazenam todos os valores das melhores posicoes globais para cada experimento
% e uma variavel para armazenar os 500 valores para cada experimento e ao final e o tamanho do vetor para que ele represente o correto valor.

% Exportar o grafico como pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% PARAMETERS
numberOfExperimentsPerParameters = 32;

% Max number of iterations
maxIterations = 1000;

S = [10 15 20]; %number of particles
N = [6 9 13 18 22]; %number of dimensionsensions
functionNames = [string('griewank') string('rastrigin') string('rosenbrock') string('ackley') string('schwefel') string('michalewicz') string('quadric') string('sphere')];

figureNumber = 1;

% Variables which will hold all results
averages = zeros(numel(S), numel(N), numel(functionNames));
medians = zeros(numel(S), numel(N), numel(functionNames));
minimums = zeros(numel(S), numel(N), numel(functionNames));
stdDevs = zeros(numel(S), numel(N), numel(functionNames));
goalReachPercentage = zeros(numel(S), numel(N), numel(functionNames));

% Holds the current day and time
YMDHMS = clock;
timedate = [num2str(YMDHMS(1)) '-' num2str(YMDHMS(2),'%02d') '-' num2str(YMDHMS(3),'%02d') '_' num2str(YMDHMS(4),'%02d') '-' num2str(YMDHMS(5),'%02d') '-' num2str(floor(YMDHMS(6)),'%02d')];

for s = 1:1
    npar = S(s);
	for d = 1:1
        dimensions = N(d);
		for f = 1:1
            functionName = functionNames(f);
            
            allValues = zeros(maxIterations, numberOfExperimentsPerParameters);
            bestValues = zeros(numberOfExperimentsPerParameters, 1);
            bestPositions = zeros(numberOfExperimentsPerParameters, dimensions);
            times = zeros(numberOfExperimentsPerParameters, 1);
            
            % Obtain the range domain for the function
            [res, searchSpace, globalMin] = costFunction(functionName, zeros(dimensions, 1));

            % Threshold
            threshold = globalMin + 0.01;

            % ABC Parameters
            colonySize = npar;
            foodSourceSize = colonySize / 2;
            trialsLimits = 20;
            
            % Run all experiments
			for experiment = 1:numberOfExperimentsPerParameters
				[spentTime, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = abcFunction(functionName, searchSpace, dimensions, maxIterations, threshold, colonySize, foodSourceSize, trialsLimits);
       			
                hold on
       			figure(figureNumber);
                semilogy(bestMinimumValues,'-.r');
       			
				xlabel('Number of iterations','FontSize',12);
				ylabel('best fitness function','FontSize',12);
				title('Curva de convergencia ABC S=' + string(npar) + ' N=' + string(dimensions) + ' ' + string(functionName));
                
                % Saves individual results to later analysis
                times(experiment, :) = spentTime;
                bestPositions(experiment, :) = bestMinimumPosition;
                bestValues(experiment, 1) = bestMinimumValue;
                allValues(:, experiment) = bestMinimumValues;
            end
            
            plot2 = semilogy(mean(allValues, 2), '-b'); 
            legend(plot2, 'ABC Average');
            
            saveas(figure(figureNumber), char(string(string('ResultsABC/ABC_S=') + string(npar) + string('_N=') + string(dimensions) + string('_') + string(functionName) + string('_') + string(timedate) + string('.fig'))));
            
            % saves data
            averages(s, d, f) = mean(bestValues);
            medians(s, d, f) = median(bestValues);
            minimums(s, d, f) = min(bestValues);
            stdDevs(s, d, f) = std2(bestValues);
            goalReachPercentage(s, d, f) = sum(bestValues < threshold) / numberOfExperimentsPerParameters;
            
            figureNumber = figureNumber + 1;
		end
    end 
end

save(char(string(string('ResultsABC/averages_') + string(timedate) + string('.mat'))), 'averages');
save(char(string(string('ResultsABC/medians_') + string(timedate) + string('.mat'))), 'medians');
save(char(string(string('ResultsABC/mins_') + string(timedate) + string('.mat'))), 'minimums');
save(char(string(string('ResultsABC/stdDevs_') + string(timedate) + string('.mat'))), 'stdDevs');
save(char(string(string('ResultsABC/goalReachPercentage_') + string(timedate) + string('.mat'))), 'goalReachPercentage');