%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Plot implemented cost functions in 2-D.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear;

% Plot characteristics
dimension = 2;
npoints = 100;


for costFunctionNumber = 1:9
	switch costFunctionNumber
		case 1
			functionName = 'griewank';   
		case 2
			functionName = 'rastrigin';  
		case 3
			functionName = 'rosenbrock';
		case 4
			functionName = 'ackley';  
		case 5
			functionName = 'schwefel';  
		case 6
			functionName = 'michalewicz'; 
		case 7
			functionName = 'quadric';  
		case 8
			functionName = 'sphere';  
		case 9
			functionName = 'levy';
		otherwise
			functionName = 'sphere';
	end
	[res, ranges] = costFunction(functionName, zeros(dimension, 1));
	spaces = cell(dimension, 1);
	for i=1:dimension
	   spaces{i} = linspace(ranges(i, 1) ,ranges(i, 2), npoints); 
	end
	[spaces{1:dimension}] = ndgrid(spaces{:});

	x = [];
	for i=1:dimension
	    x = [x; reshape(spaces{i}, [1 npoints^dimension])];
	end
	[res, ranges] = costFunction(functionName, x);

	figure(costFunctionNumber);
	mesh(spaces{1}, spaces{2}, reshape(res, [npoints npoints]));
    title(functionName);
end
