function [result] = plantEvaluator(plantName, pidConstants)

    % Laplace Differentiator
    s = tf([1 0], [1]);

    % based on the plant name chooses the correct model
    switch plantName
    	case 'suspension'
            
            systemResponseUnit = 'm';

    	case 'dcmotorspeed'
            
            systemResponseUnit = 'rad/s';

        case 'dcmotorposition'
            
            systemResponseUnit = 'rad';

		case 'cruisecontrol'

            systemResponseUnit = 'm/s';
		case 'invertedpendulum'
            
            systemResponseUnit = 'rad';

		case 'aircraftpitch'
            
            systemResponseUnit = 'rad';

		case 'ballbeam'
            
            systemResponseUnit = 'm';
        otherwise
            
            systemResponseUnit = '-';
    end
    
    [systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference, optimalRange] = systemControl(plantName);
    
    closedLoopSystem = closeLoop(plantName, systemNoiseTF, systemTF, pidConstants);
    
 % 	LC = systemTF * controllerTF / (1 + systemTF * controllerTF);
 % 	C = controllerTF / (1 + systemTF * controllerTF);

 %    % Prepare to connect blocks
 %    controllerTF.u = 'e';
 %    controllerTF.y = 'u';
 %    systemTF.u = 'u';
 %    systemTF.y = 'y';

 %    % % Sum block
 %    sumBlock = sumblk('e = r - y');

 %    % % Closed Loop Transfer Function
 %    closedLoopSystem = connect(systemTF, controllerTF, sumBlock,'r','y','u');

	% % Plant System Sensor Transfer Function
 %    sensorGain = -1;

 %    % % Loop transfer function
 %    controlEffortTF = getIOTransfer(closedLoopSystem, 'r', 'u');

    % Feedback system response to a step
    % [y, t] = step(closedLoopSystem, stepDataOptions('StepAmplitude', 1)); % System Response

    if (isnan(evaluationStepAmplitude) == 0)
	    % Step Response
	    [y] = step(closedLoopSystem, evaluationSignalTime, stepDataOptions('StepAmplitude', evaluationStepAmplitude));
	    ys = evaluationStepAmplitude * ones([1 numel(evaluationSignalTime)]);
	    [yp, tp] = step(systemTF, stepDataOptions('StepAmplitude', evaluationStepAmplitude));

	    referenceLabel = string('Step');
    else
		[y] = impulse(closedLoopSystem, evaluationSignalTime);
		ys = impulse(tf(1), evaluationSignalTime);
		[yp, tp] = impulse(systemTF);

		referenceLabel = string('Impulse');
	end	

	% Plotting
    figure(1000); clf;
    subplot(2, 1, 1);
    hold on;
    plot(evaluationSignalTime, ys);
    plot(evaluationSignalTime, y);
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend(referenceLabel, 'Response');

	subplot(2, 1, 2);
    hold on;
    plot(tp, yp);
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend('Plant Response - Open Loop');
    
    result = 1;
%     systemControlEvaluation(plantName, pidConstants, ...
%         0.95, systemTF, systemNoiseTF, evaluationStepAmplitude, ...
%         evaluationSignalTime, reference);
    
    a = 1;

