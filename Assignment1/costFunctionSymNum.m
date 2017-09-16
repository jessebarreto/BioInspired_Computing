%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Implementation of benchmark cost functions.
%
% Function parameters: 
% functionName - The function name as a string.
% dimension - The search space dimension.
% range - The search space ranges as a vector of ith dimension of vectors [begin, end]
% npoints - The number points;
% Function results:
% searchSpace - As a vector;
% functionResults - As a vector;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [spaces, numericFunction] = costFunctionSymNum(functionName, dimension, ranges, npoints)

% Symbolic
[symbolicFunction, symbolicSpace] = costFunctionSymbolic(functionName, dimension);

% From Symbolic to Numeric
spaces = cell(dimension, 1);
for i=1:dimension
   spaces{i} = linspace(ranges(i, 1) ,ranges(i, 2), npoints); 
end
[spaces{1:dimension}]=ndgrid(spaces{:});
numericFunction = double(subs(symbolicFunction, symbolicSpace, {spaces{:}}));
    
end
