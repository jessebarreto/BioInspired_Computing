%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% Multi-objective Differential Evolution Function
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [paretoFrontier, paretoSet] = modeFunction(costFunctionName, generations, populationSize, ...
	initialPopulation, numberOfDecisionVariables, numberOfObjectives, numberOfConstraints, searchSpace, ...
	scalingFactor, crossOverValue) 


%% 
% Initialize random population
parentPopulation = zeros(populationSize, numberOfDecisionVariables);
mutantVectors = zeros(populationSize, numberOfDecisionVariables);
childrenPopulation = zeros(populationSize, numberOfDecisionVariables);
evalParent = ones(populationSize, numberOfDecisionVariables) * 1e80;
evalChildren = ones(populationSize, numberOfDecisionVariables) * 1e80;
FES = 0;

if isempty(initialPopulation)
	parentPopulation = repmat(searchSpace(:, 1)', 20, 1) + (repmat(searchSpace(:, 2)', 20, 1) - repmat(searchSpace(:, 1)', 20, 1)) .* rand(populationSize, numberOfDecisionVariables);
else
	parentPopulation = initialPopulation;
end

% Initial parents' evaluation
evalParent = costFunction(costFunctionName, parentPopulation, numberOfDecisionVariables, numberOfObjectives);
FES = FES + populationSize;

%%
% Start evolution process 
for n = 1:generations
	% Mutation
	for index = 1:populationSize
		% Calculate mutation vector
		rev = randperm(populationSize);
		mutantVectors(index, :) = parentPopulation(rev(1,1), :) + scalingFactor * (parentPopulation(rev(1,2),:) - parentPopulation(rev(1,3), :));

		% Check whether the bounds are respected
		for indexM = 1:numberOfDecisionVariables
			if mutantVectors(index, indexM) < searchSpace(indexM, 1)
				mutantVectors(index, indexM) = searchSpace(indexM, 1);
			elseif mutantVectors(index, indexM) > searchSpace(indexM, 1)
				mutantVectors(index, indexM) = searchSpace(indexM, 2);
			end
		end

		% CrossOver operation
		for indexM = 1:numberOfDecisionVariables
            randomValue = rand();
			if randomValue > crossOverValue
				childrenPopulation(index, indexM) = parentPopulation(index, indexM);
			else
				childrenPopulation(index, indexM) = mutantVectors(index, indexM);
			end
		end
	end

	% Evaluate Children
	evalChildren = costFunction(costFunctionName, childrenPopulation, numberOfDecisionVariables, numberOfObjectives);
	FES = FES + populationSize;

	% Selection
	population = [];
	evalPopulation = [];

	for index = 1:populationSize
		if evalChildren(index, :) <= evalParent(index, :)
			population = [population; childrenPopulation(index, :)];
			evalPopulation = [evalPopulation; evalChildren(index, :)];
		elseif evalParent(index, :) <= evalChildren(index, :)
			population = [population; parentPopulation(index, :)];
			evalPopulation = [evalPopulation; evalParent(index, :)];
		else
			population = [population; parentPopulation(index, :); childrenPopulation(index, :)];
			evalPopulation = [evalPopulation; evalParent(index, :); evalChildren(index, :)];
		end
	end

	% Check whether there are only unique rows
	[uniquePop, indexes] = unique(evalPopulation, 'rows');
	evalPopulation = evalPopulation(indexes, :);
	population = population(indexes, :);
    clear uniquePop;

	% Truncate to calculate rank and sort it
	[parentPopulation, evalParent, rankValues, crowdingDistance] = truncate(population, evalPopulation, populationSize);

	paretoFrontier = evalParent;
	paretoSet = parentPopulation;
end
