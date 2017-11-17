%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation PID Tunning
% v 0.5
% OPSO PID Tunning.
% * Function Parameters
% plantName      		- The plant name.
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
% bestMinimumPIDValues  - The position which the minimum value is found.
% bestMinimumValues     - The cost function minimum value found in each iteration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [time, bestMinimumValue, bestMinimumPIDValues, bestMinimumValues] = opsoPIDTunning(plantName, systemTF, systemNoiseTF, ...
  evaluationStepAmplitude, evaluationSignalTime, reference, searchSpace, dimensions, particles, maxIter, threshold, direction, ...
  initialSpeed, maxSpeed, initialWeight, finalWeight, cognitiveCoeff, socialCoeff, oblLimit)

format long g;

% Start to count time.
tic();

%% INITIALIZATION
individualCurPos = zeros(particles, dimensions);
individualBestPos = zeros(particles, dimensions);
individualSpeed = initialSpeed * ones(particles, dimensions);
for j=1:dimensions
    individualCurPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(particles, 1);
    individualBestPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(particles, 1);
end

individualBestResult = 1e80 * ones(particles, 1); % initialize best fitness
bestOverallResult = 1e80 * ones(maxIter, 1);

weightSlope = (finalWeight - initialWeight) / maxIter;
weight = initialWeight;

maxSpeeds = maxSpeed * ones(1, dimensions);

oblCounter = 0;

%% ITERATIVE PROCESS
for k=1:maxIter
   % Evaluate Fitness and Detection
   for i = 1:particles
      functionResult = systemControlEvaluation(plantName, individualCurPos(i, :)', 0.95, systemTF, ...
        systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference);
      % functionResult = systemControlEvaluation(1.1, plantName, individualCurPos(i, :)');
      % double(subs(costFunctionSymb, spaceSymb, individualCurPos(i, :)));
      % functionResult = rosenbrock(individualBestPos(i, :));
       
      if functionResult < individualBestResult(i)
         individualBestPos(i, :) = individualCurPos(i, :);
         individualBestResult(i) = functionResult;
      end
   end
   
   [bestOverallResult(k), bestOverallIndex] = min(individualBestResult);
   socialBestPos = individualBestPos(bestOverallIndex, :);
   
   % Shake Particles with OBL
   if (k ~= 1 && bestOverallResult(k) == bestOverallResult(k-1))
      oblCounter = oblCounter + 1;
      if (oblCounter == oblLimit)
          oblCounter = 0;
          numberRandomDimensions = floor(dimensions * rand()) + 1; % Number of random dimensions
          randIndex = floor(dimensions * rand(numberRandomDimensions)) + 1;
          randIndex = unique(randIndex);

          individualCurPos(:, randIndex) = -individualCurPos(:, randIndex) + 0.1 * rand();
          outsideIndexes = individualCurPos(:, randIndex) > searchSpace(randIndex, 2)';
          individualCurPos(outsideIndexes) = min(searchSpace(:, 2));
      end
   end
   
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
end

a = 1;

bestMinimumValue = bestOverallResult(length(bestOverallResult));
bestMinimumPIDValues = socialBestPos;
bestMinimumValues = bestOverallResult;
time = toc();
