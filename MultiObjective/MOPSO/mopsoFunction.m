%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimization
% v 0.8
% * Function Parameters
% costFunctionName      - The cost function name.
% searchSpace           - The search space used by the cost function.
% dimensions            - The problem dimension. (default = 2)
% particles             - The number of particles used. (default = 20)
% maxIter               - The maximum number of iterations. (default = 500)
% threshold             - The minimum threshold to stop the algorithm. (default = 1e-10)
% direction             - ???????????????????????????????????? (default = 1)
% initialSpeed          - The initial particle speed. (default = 0.5)
% maxSpeed              - The maximum allowed particle speed. (default = 3)
% initialWeigth         - The initial inertial weight. (default = 0.9)
% finalWeigth           - The final inertial weight. (default = 0.1)
% cognitiveCoeff        - The cognitive coefficient to the individual best value. (default = 2)
% socialCoeff           - The cognitive coefficient to the social best value. (default = 2) 
% * Function Results    -
% bestMinimumValue      - The cost function minimum value found.
% bestMinimumPosition   - The position which the minimum value is found.
% bestMinimumValues     - The cost function minimum value found in each iteration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = mopsoFunction(costFunctionName, ...
  objectives, searchSpace, dimensions, particles, maxIter, threshold, direction, initialSpeed, maxSpeed, ...
  initialWeight, finalWeight, cognitiveCoeff, socialCoeff)

format long g;
% cores = 4;
% delete(gcp('nocreate'));
% parpool(cores);

% Start to count time.
tic();

% Cost Function
costFunction = str2func('CostFunction'); 

%% INITIALIZATION
DATA = [];
DATA.CostProblem = costFunctionName;
DATA.NVAR = dimensions;
DATA.NOBJ = objectives;



individualCurPos = zeros(particles, dimensions);
individualBestPos = zeros(particles, dimensions);
individualSpeed = initialSpeed * ones(particles, dimensions);
for j=1:dimensions
    individualCurPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(particles, 1);
    individualBestPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(particles, 1);
end

individualBestResult = 1e80 * ones(particles, objectives); % initialize best fitness
bestOverallResult = 1e80 * ones(maxIter, objectives);

weightSlope = (finalWeight - initialWeight) / maxIter;
weight = initialWeight;

maxSpeeds = maxSpeed * ones(1, dimensions);

%% ITERATIVE PROCESS
for k=1:maxIter
   % Evaluate Fitness and Detection
   functionResults = CostFunction(individualCurPos, DATA);
   
   % Selection Type 3
   population = [];
   populationResults = [];
   for i = 1:particles
      if functionResults(i, :) <= individualBestResult(i, :)
         populationResults = [populationResults; functionResults(i, :)];
         population = [population; individualCurPos(i, :)];
      elseif individualBestResult(i, :) <= functionResults(i, :)
         populationResults = [populationResults; individualBestResult(i, :)];
         population = [population; individualBestPos(i, :)];
      else
         populationResults = [populationResults; individualBestResult(i, :); functionResults(i, :)];
         population = [population; individualBestPos(i, :); individualCurPos(i, :)];
      end
   end
   % Make sure all results are unique
   [uniqueValues, uniqueIndexes] = unique(populationResults, 'rows');
   populationResults = populationResults(uniqueIndexes, :);
   population = population(uniqueIndexes, :);
   
   % Truncate
   [variables, fitness, rankValues, CD] = truncate(population, ...
       populationResults, particles);
   
   paretoFrontier = fitness;
   paretoSet = variables;
   
   % Select the best social result
   uniqueIndexes = fitness(rankValues == 1, :) < [1 1 1];
   

   % Update Particles
   for i = 1:particles
      % Update Speed
      randomValues = rand(1, 2);
      speed = weight * individualSpeed(i, :) + direction * (cognitiveCoeff * randomValues(1) * (individualBestPos(i, :) - individualCurPos(i, :))) + socialCoeff * randomValues(2) * (socialBestPos(:)' - individualCurPos(i, :));
      greaterThanMask = speed > maxSpeeds;
      smallerThanMask = speed < -1 * maxSpeeds;
      speed(greaterThanMask) = maxSpeed;
      speed(smallerThanMask) = -maxSpeed;
      individualSpeed(i, :) = speed;
      
      % Update Positions
      pos = individualCurPos(i, :) + individualSpeed(i, :);
      r2 = searchSpace(:, 2)';
      r1 = searchSpace(:, 1)';
      greaterThanMask = pos > r2;
      smallerThanMask = pos < r1;
      pos(greaterThanMask) = r2(greaterThanMask);
      pos(smallerThanMask) = r1(smallerThanMask);
      individualCurPos(i, :) = pos;
   end
   weight = weight + weightSlope;
   
%    [bestOverallResult(k, :), bestOverallIndex] = min(individualBestResult);
%    socialBestPos = individualBestPos(bestOverallIndex, :);
end

bestMinimumValue = bestOverallResult(length(bestOverallResult));
bestMinimumPosition = socialBestPos;
bestMinimumValues = bestOverallResult;
time = toc();

