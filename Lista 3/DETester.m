%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% DE PID Tunning tester.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = DETester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);

	% Parameters
	S = [6 12 18]; %number of particles
	N = [3]; %number of dimensionsions

	% Variables which will hold all results
    experimentValues = zeros(numel(S), numel(N), numberOfExperimentsPerParameters);
	averages = zeros(numel(S), numel(N));
	medians = zeros(numel(S), numel(N));
	minimums = zeros(numel(S), numel(N));
	minimumPID = zeros(numel(S), numel(N), 3);
	stdDevs = zeros(numel(S), numel(N));
	goalReachPercentage = zeros(numel(S), numel(N));

    

	% Holds the current day and time
	YMDHMS = clock;
	timedate = [num2str(YMDHMS(1)) '-' num2str(YMDHMS(2),'%02d') '-' num2str(YMDHMS(3),'%02d') '_' num2str(YMDHMS(4),'%02d') '-' num2str(YMDHMS(5),'%02d') '-' num2str(floor(YMDHMS(6)),'%02d')];

	% Figure number
	figureNumber = 1;

	% DE Parameters [1 1.0 1.35 0.95]
	% Direction
	direction = algorithmParameters(1); %direction

	% Algorithm Parameters
    initialMutationFactor = algorithmParameters(2);
    finalMutationFactor = algorithmParameters(3);
    crossOverRate = algorithmParameters(4);

	% Threshold
	threshold = 0.01;

	% Control System Info
	[systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference, optimalRange] = systemControl(plantName);

    dim = 3;
	for s = 1:numel(S)
	    npar = S(s);
		for d = 1:numel(N)
	        dimensions = N(d);
	            
	            allValues = zeros(maxIterations, numberOfExperimentsPerParameters);
	            bestValues = zeros(numberOfExperimentsPerParameters, 1);
	            bestPositions = zeros(numberOfExperimentsPerParameters, dimensions);
	            times = zeros(numberOfExperimentsPerParameters, 1);

	            % Run all experiments
				for experiment = 1:numberOfExperimentsPerParameters
					[spentTime, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = dePIDTunning(plantName, ...
    				systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference, optimalRange, ...
    				dimensions, npar, maxIterations, threshold, direction, initialMutationFactor, finalMutationFactor, ...
    				crossOverRate);
                    
%                     plantEvaluator(plantName, bestMinimumPosition);
                    
                    figure(figureNumber);
                    set(gcf,'Visible', 'off');
                    hold on;
                    plot(bestMinimumValues,'-.r');

                    xlabel('Number of iterations','FontSize',12);
                    ylabel('best fitness function','FontSize',12);
                    % 				axis([0 maxIterations 1E-10 1E2]);
                    title('Curva de convergencia DE S=' + string(npar) + ' N=' + string(dim) + ' ' + string(plantName));

                    % Saves individual results to later analysis
                    times(experiment, :) = spentTime;
                    bestPositions(experiment, :) = bestMinimumPosition;
                    bestValues(experiment, 1) = bestMinimumValue;
                    allValues(:, experiment) = bestMinimumValues;
                    
                end
                
                plotFinal = plot(mean(allValues, 2), '-b'); 
                legend(plotFinal, 'DE Average');

                saveas(figure(figureNumber), char(string(string('ResultsDE/DE_S=') + string(npar) + string('_N=') + string(dim) + string('_') + string(plantName) + string('_') + string(timedate) + string('.fig'))));

                % saves data
                experimentValues(s, d, :) = bestValues;
                averages(s, d) = mean(bestValues);
                medians(s, d) = median(bestValues);
                [minimums(s, d), index] = min(bestValues);
                minimumPID(s, d, :) = bestPositions(index, :);
                stdDevs(s, d) = std2(bestValues);
                goalReachPercentage(s, d) = sum(bestValues < threshold) / numberOfExperimentsPerParameters;

                figureNumber = figureNumber + 1;
	        end
    end

    save(char(string(string('ResultsDE/experimentValues_') + string(timedate) + string('.mat'))), 'experimentValues');
	save(char(string(string('ResultsDE/averages_') + string(timedate) + string('.mat'))), 'averages');
	save(char(string(string('ResultsDE/medians_') + string(timedate) + string('.mat'))), 'medians');
	save(char(string(string('ResultsDE/mins_') + string(timedate) + string('.mat'))), 'minimums');
	save(char(string(string('ResultsDE/minsPID_') + string(timedate) + string('.mat'))), 'minimumPID');
	save(char(string(string('ResultsDE/stdDevs_') + string(timedate) + string('.mat'))), 'stdDevs');
	save(char(string(string('ResultsDE/goalReachPercentage_') + string(timedate) + string('.mat'))), 'goalReachPercentage');
