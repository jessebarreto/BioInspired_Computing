%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Firefly Algorithm Optimization
% based on  Xin-She Yang, Nature-Inspired Metaheuristic Algorithms, Second Edition, Luniver Press, (2010).   www.luniver.com
% v 0.8
% * Function Parameters
% costFunctionName      - The cost function name.
% searchSpace           - The search space used by the cost function.
% dimensions            - The problem dimension. (default = 2)
% numberFireflies       - The number of fireflies. (default = 20)
% maxIter               - The maximum number of iterations. (default = 500)
% threshold             - The minimum threshold to stop the algorithm. (default = 1e-10)
% direction             - ???????????????????????????????????? (default = 1)
% gamma                 - Coefficient de absorção. (default = 0.85)
% initialAlpha          - Coefficient de aleatoriedade inicial. (default = 0.6)
% finalAlpha            - Coefficient de aleatoriedade final. (default = 0.9)
% delta                 - Coeficiente de redução aleatória. (default = 0.99)
% * Function Results    -
% bestMinimumValue      - The cost function minimum value found.
% bestMinimumPosition   - The position which the minimum value is found.
% bestMinimumValues     - The cost function minimum value found in each iteration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time, bestMinimumValue, bestMinimumPosition, bestMinimumValues] = fireflyFunction(costFunctionName, searchSpace, dimensions, particles, maxIter, threshold, direction, gamma, initialAlpha, finalAlpha, delta)

% Start to count time.
tic();

%% DEFAULT VALUES SETTER
if nargin < 2
    error('fireflyFunction requires at least 2 arguments: costFunctionName and seachSpace');
elseif nargin == 2
    direction = 1;
    dimensions = 2;
    particles = 20;
    maxIter = 500; 
    threshold = 0.01; 
    gamma = 0.85;
    initialAlpha = 0.6;
    finalAlpha = 0.9;
    delta = 0.99;
end

%% INITIALIZATION
% Generating the initial locations of n fireflies
firefliesPos  = zeros(particles, dimensions);
firefliesLight = zeros(particles, 1);
functionResults = zeros(particles, 1);
for j=1:dimensions
    firefliesPos(:, j) = searchSpace(j, 1) + (searchSpace(j, 2) - searchSpace(j, 1)) * rand(particles, 1);
end
deltaAlpha = abs(finalAlpha - initialAlpha) / maxIter;
alpha = initialAlpha;
bestMinimumValues = [];


%% ITERATIVE PROCESS
for i=1:maxIter,     %%%%% start iterations

    % Evaluate fitness function
    for j = 1:particles
      functionResults(j) = costFunction(costFunctionName, firefliesPos(j, :)');
    end

    % Ranking the fireflies by their light intensity
    [firefliesLight,indexes] = sort(functionResults);

    % Copy
    firefliesPos = firefliesPos(indexes, :);
    originalPos = firefliesPos;
    originalLight = firefliesLight;

    % Move all fireflies to the better locations
    nj = size(firefliesPos,1); nk = size(originalPos,1);
    counter = 0;
    for j = 1:nj,
        for k = 1:nk,
            r = sqrt(sum((firefliesPos(j, :) - originalPos(k, :)) .^ 2));
            if firefliesLight(j) > originalLight(k) % Brighter and more attractive
                beta0 = 1;
                beta = beta0 * exp(-gamma * r); %beta=beta0*exp(-gamma*r.^2);

                firefliesPos(j, :) = firefliesPos(j, :) .* (1 - beta) + originalPos(k, :) .* beta + alpha .* (rand(1, dimensions)-0.5);
                counter = counter + 1;
            end
        end
    end

    % Make sure the fireflies are within the range
    for j = 1:nj
        outsideIndexes = firefliesPos(j, :) < searchSpace(:, 1)';
        firefliesPos(j, outsideIndexes) = searchSpace(outsideIndexes, 1)';
        outsideIndexes = firefliesPos(j, :) > searchSpace(:, 2)';
        firefliesPos(j, outsideIndexes) = searchSpace(outsideIndexes, 2)';
    end

    % Reduce randomness as iterations proceed
    alpha = alpha + deltaAlpha;
    
    % Save history of values
    bestMinimumValues = [bestMinimumValues firefliesLight(1)];

end   %%%%% end of iterations
bestMinimumValue = firefliesLight(1);
bestMinimumPosition = firefliesPos(1, :);


time = toc();
