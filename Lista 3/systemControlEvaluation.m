%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 3 - Implementation of transfer functions for the PID experiment.
%
% Function parameters: 
% 
% overshootFactor 	- The importance to the overshooting value. Range [0 1)
% errorFactor		- The importance to the results speed. 		Range [0 1)
% plantName      	- The plant name as a string.
% pidConstants 		- The PID constant values. [Kp Ki Kd]
% Function results:
% result            - Evaluation function result;
%
% References:
% http://ctms.engin.umich.edu/CTMS/index.php?aux=Home
% http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=4434126&tag=1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [result] = systemControlEvaluation(plantName, pidConstants, beta, systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference)
    format long

    closedLoopSystem = closeLoop(plantName, systemNoiseTF, systemTF, pidConstants);

    if (isnan(evaluationStepAmplitude) == 0)

        [data, stepTime] = step(closedLoopSystem, stepDataOptions('StepAmplitude', evaluationStepAmplitude));

        stepInformation = stepinfo(data, stepTime);
        
        timeFactor = stepInformation.SettlingTime * stepInformation.RiseTime;
        
%         overshootFactor = stepInformation.Overshoot;
       peakFactor = abs(stepInformation.Peak - reference);
    else
        [data, impulseTime] = impulse(closedLoopSystem);

        % Epsilon 10^-4
        epsilon = 1e-4;

        indexes = find(data < reference + epsilon);
        if numel(indexes) > 3
            timeFactor = impulseTime(indexes(2));
        else
            % Does not have a settling time
            timeFactor = 1e24; % Infinity
        end
        
        peakFactor = max(abs(data - reference));
    end

    % Error Reference
	errorRef = data - reference;
    
    % Steady-state error
    steadyStateError = abs(errorRef(end));

    %%% The function cost represents the optimization of differrent variables of step responde.
    % Sum-Squared Error
%     ssError = sse(errorRef);

    
    % Cost Function
%     result =  settlingTime * ssError *  max(abs(errorRef)) * exp(1 + beta * abs(steadyStateError)); %((1 - exp(-beta)) * (settlingTime) + exp(-beta) * (ssError) * max(abs(errorRef))) + abs(steadyStateError);
    
%     result =  ((1 - exp(-beta)) * (10 * peakFactor + steadyStateError) + ...
%                 beta * exp(-beta) * (timeFactor) + 1);
    
%     result = beta * ssError + peakFactor + timeFactor;
    % ssError + peakFactor + steadyStateError + timeFactor;

    result = timeFactor * peakFactor + steadyStateError;
