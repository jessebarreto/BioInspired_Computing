%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% Multi-objective Evolution Algorithms Spacing Metric
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function spacingValue = spacing(paretoFrontier)

	variablesSize = size(paretoFrontier, 1);
	objectivesSize = size(paretoFrontier, 2);

	solutionIndexes = 1:variablesSize;

	distances = zeros(1, variablesSize);

	for index = 1:variablesSize

		solution = paretoFrontier(index, :);
		othersIndexes = setdiff(solutionIndexes, index);

		otherSolutions = paretoFrontier(othersIndexes, :);

		sumValue = [];

		for indexObj = 1:objectivesSize
			sumValue(:, indexObj) = abs(repmat(solution(1, indexObj), variablesSize-1, 1) - otherSolutions(:, indexObj));
		end

		distances(index) = min(sum(sumValue'));
	end

	averageDistances = mean(distances);

	spacingValue = sqrt((1/variablesSize) * sum((distances - averageDistances).^2));