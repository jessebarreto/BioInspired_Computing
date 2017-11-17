%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% OBL-Particle Swarm Optimiation
% v 0.5
% OPSO PID Tunning tester.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = OPSOTester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);

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

	% OPSO Parameters [1 1.2 0.9 50 5 0.2 1.2]
	% Direction
	direction = algorithmParameters(1); %direction

	% Iterations Weights
	initialWeight = algorithmParameters(2);
	finalWeight = algorithmParameters(3);

	% Max speed is half the range space
	vMax = algorithmParameters(4);
	vInitial = algorithmParameters(5);

	% Cognitive Coefficients
	c1 = algorithmParameters(6);
	c2 = algorithmParameters(7);

	% Threshold
	threshold = 0.01;

	limitValue = algorithmParameters(8);

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
					[spentTime, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = opsoPIDTunning(plantName, systemTF, systemNoiseTF, ...
						evaluationStepAmplitude, evaluationSignalTime, reference, optimalRange, ...
						dimensions, npar, maxIterations, threshold, direction, vInitial, vMax, initialWeight, finalWeight, ...
						c1, c2, limitValue);
                    
%                     plantEvaluator(plantName, bestMinimumPosition);
                    
                    figure(figureNumber);
                    set(gcf,'Visible', 'off');
                    hold on;
                    plot(bestMinimumValues,'-.r');

                    xlabel('Number of iterations','FontSize',12);
                    ylabel('best fitness function','FontSize',12);
                    % 				axis([0 maxIterations 1E-10 1E2]);
                    title('Curva de convergencia OPSO S=' + string(npar) + ' N=' + string(dim) + ' ' + string(plantName));

                    % Saves individual results to later analysis
                    times(experiment, :) = spentTime;
                    bestPositions(experiment, :) = bestMinimumPosition;
                    bestValues(experiment, 1) = bestMinimumValue;
                    allValues(:, experiment) = bestMinimumValues;
                    
                end
                
                plotFinal = plot(mean(allValues, 2), '-b'); 
                legend(plotFinal, 'OPSO Average');

                saveas(figure(figureNumber), char(string(string('ResultsOPSO/OPSO_S=') + string(npar) + string('_N=') + string(dim) + string('_') + string(plantName) + string('_') + string(timedate) + string('.fig'))));

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

    save(char(string(string('ResultsOPSO/experimentValues_') + string(timedate) + string('.mat'))), 'experimentValues');
	save(char(string(string('ResultsOPSO/averages_') + string(timedate) + string('.mat'))), 'averages');
	save(char(string(string('ResultsOPSO/medians_') + string(timedate) + string('.mat'))), 'medians');
	save(char(string(string('ResultsOPSO/mins_') + string(timedate) + string('.mat'))), 'minimums');
	save(char(string(string('ResultsOPSO/minsPID_') + string(timedate) + string('.mat'))), 'minimumPID');
	save(char(string(string('ResultsOPSO/stdDevs_') + string(timedate) + string('.mat'))), 'stdDevs');
	save(char(string(string('ResultsOPSO/goalReachPercentage_') + string(timedate) + string('.mat'))), 'goalReachPercentage');
