%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% Multi-objective Cost Function implementations
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [functionValues] = costFunction(costFunctionName, population, ...
	numberOfVariables, numberOfObjectives)

	switch costFunctionName
		case string('ZDT1')
            functionValues = 1e80 * ones(size(population, 1), 2);
			n = numberOfVariables;
			for index = 1:size(population, 1)
				x = population(index, :);
				f(1) = x(1);
				g = 1 + 9 * sum(x(2:n)) / (n - 1);
				f(2) = g * (1 - sqrt(x(1)/g));

				functionValues(index, :) = f(:);
			end
		case string('ZDT2')
            functionValues = 1e80 * ones(size(population, 1), 2);
			n = numberOfVariables;
			for index = 1:size(population, 1)
				x = population(index, :);
				f(1) = x(1);
				g = 1 + 9 * sum(x(2:n)) / (n - 1);
				f(2) = g * (1 - (x(1) / g)^2);

				functionValues(index, :) = f(:);
			end
		case string('ZDT3')
            functionValues = 1e80 * ones(size(population, 1), 2);
			n = numberOfVariables;
			for index = 1:size(population, 1)
				x = population(index, :);
				f(1) = x(1);
				g = 1 + 9 * sum(x(2:n)) / (n - 1);
				f(2) = g * (1 - sqrt(x(1)/g)  - x(1)/g * sin(10 * pi * x(1)));

				functionValues(index, :) = f(:);
			end
		case string('ZDT4')
			functionValues = 1e80 * ones(size(population, 1), 2);
			n = numberOfVariables;
			for index = 1:size(population, 1)
				x = population(index, :);
				f(1) = x(1);
				g = 1 + 10 * (n - 1) + sum(x(2:n).^2 - 10 * cos(4 * pi * x(2:n)));
				f(2) = g * (1 - sqrt(x(1)/g));

				functionValues(index, :) = f(:);
			end
		case string('DTLZ1')
			functionValues = 1e80 * ones(size(population, 1), numberOfObjectives);
			n = numberOfVariables;
			m = numberOfObjectives;
			k = 5;

			for index = 1:size(population, 1)
				x = population(index, :);
				g = 100 * (k + sum((x(m:n) - 0.5).^2 - cos(20 * pi * (x(m:n) - .5) ) ) );

				functionValues(index, 1) = (1 + g) * 0.5 * prod(x(1:(m-1)));

				for nobj = 1:(m-1)
					functionValues(index, nobj+1) = functionValues(index, 1) / prod(x(m-nobj:m-1)) * (1 + x(m - nobj));
				end

			end
		case string('DTLZ3')
			functionValues = 1e80 * ones(size(population, 1), numberOfObjectives);
			n = numberOfVariables;
			m = numberOfObjectives;
			k = 10;

			for index = 1:size(population, 1)
				x = population(index, :);
				
				g = 100 * (k + sum((x(m:n) - 0.5).^2 - cos(20 * pi * (x(m:n) - .5) ) ) );

				cosVals = cos(x(1:(m-1)) * pi/2);

				functionValues(index, 1) = (1 + g) * 0.5 * prod(cosVals);

				for nobj = 1:(m-1)
					functionValues(index, nobj+1) = functionValues(index, 1) / prod(cosVals(1, m-nobj:m-1)) * sin(x(m-nobj) * pi / 2);
				end
			end
		case string('DTLZ5')
			functionValues = 1e80 * ones(size(population, 1), numberOfObjectives);
			n = numberOfVariables;
			m = numberOfObjectives;

			for index = 1:size(population, 1)
				x = population(index, :);
				g = sum((x(m:n) - 0.5).^2);

				theta = (pi / (4 * (1 + g))) * (1 + 2* g * x);

				cosVal = cos(theta(index, 1:(m-1)) * pi/2);


				functionValues(index, 1) = (1 + g) * prod(cosVal);
				for nobj = 1:(m-1)
					functionValues(index, nobj+1) = (functionValues(index, 1) / prod(cosVal(1, m-nobj:m-1))) * sin(theta(index, m-nobj) * pi / 2);
				end
			end
		otherwise %case string('DTLZ2')
			functionValues = 1e80 * ones(size(population, 1), numberOfObjectives);
			n = numberOfVariables;
			m = numberOfObjectives;

			for index = 1:size(population, 1)
				x = population(index, :);

				g = sum((x(m:n) - 0.5).^2);

				cosVal = cos(x(1:(m-1)) * pi/2);

				functionValues(index, 1) = (1 + g) * prod(cosVal);
				for nobj = 1:(m-1)
					functionValues(index, nobj+1) = (functionValues(index, 1) / prod(cosVal(m-nobj:m-1))) * sin(x(m-nobj) * pi / 2);
				end
            end
	end
