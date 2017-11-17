function [time, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = odePIDTunning(plantName, ...
    systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference, searchSpace, ...
    dimensions, population, maxIter, threshold, direction, initialMutationFactor, finalMutationFactor, ...
    crossOverRate, oblLimit)

    % Start to count time.
    tic();

    %% INITIALIZATION
    for j=1:dimensions
        individualPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(population, 1);
    end
    mutated = zeros(population, dimensions);
    newIndividual = zeros(1, dimensions);
    individualResults = zeros(population, 1);
    bestMinimumValues = [];
    bestMinimumPositions = [];

    mutationFactor = initialMutationFactor;
    deltaMutation = abs(initialMutationFactor + finalMutationFactor) / maxIter;

    oblCounter = 0;

    %% ITERATIVE
    for i=1:maxIter
        % for each individual
        for j = 1:population
            % Mutation
            rev = randperm(population,3);       %Create a list of random integers numbers between 1 and Xpop.
            mutated(j,:)= individualPos(rev(1,1),:) + mutationFactor*(individualPos(rev(1,2),:) - individualPos(rev(1,3),:));

            % Check if the mutated element is beyond the matrix
            beyondInd = mutated(j, :) < searchSpace(:, 1)';
            mutated(j, beyondInd) = searchSpace(beyondInd, 1)';
            beyondInd = mutated(j, :) > searchSpace(:, 2)';
            mutated(j, beyondInd) = searchSpace(beyondInd, 2)';

            % Crossover 
            for k = 1:dimensions
                randomValue = rand(1);
                if randomValue < crossOverRate
                    newIndividual(1,k) = mutated(j,k);
                else
                    newIndividual(1,k) = individualPos(j,k);
                end
            end

            % Selection and Evaluate
            newResult = systemControlEvaluation(plantName, newIndividual(1,:)', 0.95, ...
                systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference);
            oldResult = systemControlEvaluation(plantName, individualPos(1,:)', 0.95, ...
                systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference);

            if newResult < oldResult
                individualPos(j,:) = newIndividual(1,:);
                individualResults(j , 1) = newResult;
            else
                individualResults(j , 1) = oldResult;
            end
        end

        % Select the lowest fitness value
        [results, indexes] = sort(individualResults, 1);
        result_min = results(1,1);
        bestMinimumValues = [bestMinimumValues result_min];
        bestMinimumPositions = [bestMinimumPositions; individualPos(1, :)];

        % Shake Particles with OBL
        if (i ~= 1 && bestMinimumValues(i) == bestMinimumValues(i-1))
            oblCounter = oblCounter + 1;
            if (oblCounter == oblLimit)
                oblCounter = 0;
                numberRandomDimensions = floor(dimensions * rand()) + 1; % Number of random dimensions
                randIndex = floor(dimensions * rand(numberRandomDimensions)) + 1;
                randIndex = unique(randIndex);

                individualPos(:, randIndex) = -individualPos(:, randIndex) + 0.1 * rand();
                outsideIndexes = individualPos(:, randIndex) > searchSpace(randIndex, 2)';
                individualPos(outsideIndexes) = min(searchSpace(:, 2));
            end
        end
    end

    [bestMinimumValue index] = min(bestMinimumValues);
    bestMinimumPosition = bestMinimumPositions(index, :);

    time = toc();
