%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Artificial Bee Colony Algorithm
% v 0.8
% * Function Parameters
% costFunctionName      - The cost function name.
% searchSpace           - The search space used by the cost function.
% dimensions            - The problem dimension. (default = 2)
% maxIter               - The maximum number of iterations. (default = 500)
% threshold             - The minimum threshold to stop the algorithm. (default = 1e-3)
% colonySize			- The number of employed bees and onlooker bees. (default = 24)
% foodSourceSize 		- The number of food sources. (default = 24/2)
% trialsLimits 			- A food source which could not be improved through "limit" trials is abandoned by its employed bee. (default = 20)
% * Function Results    -
% bestMinimumValue      - The cost function minimum value found.
% bestMinimumPosition   - The position which the minimum value is found.
% bestMinimumValues     - The cost function minimum value found in each iteration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = abcFunction(costFunctionName, searchSpace, dimensions, maxIter, threshold, colonySize, foodSourceSize, trialsLimits)

format long g;

%Start to count time.
tic();

%% Default values setter
if nargin < 2
	error('abcFunction requires at least 2 arguments: costFunctionName and seachSpace');
elseif nargin == 2
	dimensions = 2;
	maxIter = 500;
	threshold = 1e-3;
	colonySize = 24;
	foodSourceSize = 12;
	trialsLimits = 20;
end

%% Initialization 
range = repmat((searchSpace(:, 2) - searchSpace(:, 1))', [foodSourceSize 1]);
lower = repmat(searchSpace(:, 1)', [foodSourceSize 1]);
foodPositions = rand(foodSourceSize, dimensions) .* range + lower;

[foodValues functionSearchSpace globalMin] = costFunction(costFunctionName, foodPositions');

% reset the number of trials
trial = zeros(1, foodSourceSize);

% memorize the best food source
[bestFoodValue bestFoodIndex] = min(foodValues);
bestMinimumValue = bestFoodValue;
bestMinimumPosition = foodPositions(bestFoodIndex, :);

%% Iterative Process
bestMinimumValues = zeros(1, maxIter);
for k = 1:maxIter
%% Employed Bee Phase
	for i = 1:foodSourceSize
		% Parameter which will be randomly changed
		paramChangedIndex = fix(rand() * dimensions) + 1;

		% A randomly chosen solution is used in producing a mutant solution of the solution i
		neighbour = fix(rand() * foodSourceSize) + 1;
		while (neighbour == i) 
			neighbour = fix(rand() * foodSourceSize) + 1;
		end

		solution = foodPositions(i, :);
		%  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
	    solution(paramChangedIndex) = foodPositions(i, paramChangedIndex) + (foodPositions(i, paramChangedIndex) - foodPositions(neighbour, paramChangedIndex)) * (rand() - 0.5) * 2;

	    %if generated parameter value is out of boundaries, it is shifted onto the boundaries*/
	    indexes = find(solution < searchSpace(:, 1)');
	    solution(indexes) = searchSpace(indexes, 1)';
	    indexes = find(solution > searchSpace(:, 2)');
	    solution(indexes) = searchSpace(indexes, 2)';

	    % Checks the new solution
	    curFoodValue = costFunction(costFunctionName, solution');

	    % A greedy selection is aplied between the current solution i and its mutant
	    if (curFoodValue < foodValues(i))
			foodPositions(i, :) = solution;
			foodValues(i) = curFoodValue;
			trial(i) = 0;
		else
			trial(i) = trial(i) + 1;
		end

	end

%% Calculate Probabilities
    %/* A food source is chosen with the probability which is proportioal to its quality*/
    %/*Different schemes can be used to calculate the probability values*/
    %/*For example prob(i)=fitness(i)/sum(fitness)*/
    %/*or in a way used in the metot below prob(i)=a*fitness(i)/max(fitness)+b*/
    %/*probability values are calculated by using fitness values and normalized by dividing maximum fitness value*/
    % probabilities = foodValues ./ sum(foodValues);
    % b = 2 * abs(globalMin); probabilities = (0.9 .* (foodValues + b) ./ max(foodValues + b)) + 0.1;
    probabilities = foodValues ./ sum(foodValues);

%% Onlooker Bee Phase
    i = 1;
    t = 0;
	while (t < foodSourceSize)
        randValue = rand();
		if (randValue > probabilities(i))
			t = t + 1;

			% Shake the parameter to be changed
			paramChangedIndex = fix(rand() * dimensions) + 1;

			% Choose randomly a slution to be used
			neighbour = fix(rand() * foodSourceSize) + 1;
			while (neighbour == i) 
				neighbour = fix(rand() * foodSourceSize) + 1;
			end

			solution = foodPositions(i, :);
			%  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
		    solution(paramChangedIndex) = foodPositions(i, paramChangedIndex) + (foodPositions(i, paramChangedIndex) - foodPositions(neighbour, paramChangedIndex)) * (rand() - 0.5) * 2;

		    %if generated parameter value is out of boundaries, it is shifted onto the boundaries*/
		    indexes = find(solution < searchSpace(:, 1)');
		    solution(indexes) = searchSpace(indexes, 1)';
		    indexes = find(solution > searchSpace(:, 2)');
		    solution(indexes) = searchSpace(indexes, 2)';

		    % Checks the new solution
		    curFoodValue = costFunction(costFunctionName, solution');

	    	% A greedy selection is aplied between the current solution i and its mutant
		    if (curFoodValue < foodValues(i))
				foodPositions(i, :) = solution;
				foodValues(i) = curFoodValue;
				trial(i) = 0;
			else
				trial(i) = trial(i) + 1;
			end
		end 

		i = i + 1;
		if (i == foodSourceSize + 1)
			i = 1;
		end
	end 

	% memorize the best food source
	[bestFoodValue bestFoodIndex] = min(foodValues);
	if (bestFoodValue < bestMinimumValue)
		bestMinimumValue = bestFoodValue;
		bestMinimumPosition = foodPositions(bestFoodIndex, :);
	end

%% Scout Bee Phase
	%/*determine the food sources whose trial counter exceeds the "limit" value. 
    %In Basic ABC, only one scout is allowed to occur in each cycle*/
	indexes = find(trial == max(trial));
	indexes = indexes(end);
	if (trial(indexes) > trialsLimits)
		solution = repmat(rand(1, dimensions), [length(indexes) 1]) .* range(indexes, :) + lower(indexes, :);
		curFoodValue = costFunction(costFunctionName, solution');
		foodPositions(indexes, :) = solution;
		foodValues(indexes) = curFoodValue;
	end
	bestMinimumValues(k) = bestMinimumValue;
end

time = toc();
