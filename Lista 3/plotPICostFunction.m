%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 3 - Implementation of ploting surface of PI cost function.
%
% Function parameters: 
% 
% overshootFactor 	- The importance to the overshooting value. Range [0 1)
% errorFactor		- The importance to the results speed. 		Range [0 1)
% plantName      	- The plant name as a string.
% Function results:
%
% References:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = plotPICostFunction(overshootFactor, errorFactor, plantName)

	[Kp,Ki] = meshgrid(290:300,1:15);
	result = zeros(size(Kp));

	for i = 1:length(Kp)
		for j = 1:length(Ki)
			pid = [Kp(i) Ki(j) 0];
			result(i, j) = systemControlEvaluation(overshootFactor, errorFactor, plantName, pid);
		end
	end

	surf(result);
