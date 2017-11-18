    clear all;
    clc;
    close all;

    plantNames = [string('suspension') string('dcmotorspeed') string('dcmotorposition') string('cruisecontrol') string('invertedpendulum') string('aircraftpitch') string('ballbeam') string('professor')];
    plantName = plantNames(5);
    
    load('/home/jesseh/workspace/UnB/BioInspirados/Source/BioInspired_Computing/Lista 3/ResultsPSO/minsPID_2017-11-16_23-35-10.mat');
    pidPSOS1 = minimumPID(1,1, :); pidPSOS1 = pidPSOS1(:)';
    pidPSOS2 = minimumPID(2,1, :); pidPSOS2 = pidPSOS2(:)';
    pidPSOS3 = minimumPID(3,1, :); pidPSOS3 = pidPSOS3(:)';
    
    load('/home/jesseh/workspace/UnB/BioInspirados/Source/BioInspired_Computing/Lista 3/ResultsOPSO/minsPID_2017-11-16_23-35-10.mat');
    pidOPSOS1 = minimumPID(1,1, :); pidOPSOS1 = pidOPSOS1(:)';
    pidOPSOS2 = minimumPID(2,1, :); pidOPSOS2 = pidOPSOS2(:)';
    pidOPSOS3 = minimumPID(3,1, :); pidOPSOS3 = pidOPSOS3(:)';
    
    load('/home/jesseh/workspace/UnB/BioInspirados/Source/BioInspired_Computing/Lista 3/ResultsDE/minsPID_2017-11-16_23-35-10.mat');
    pidDES1 = minimumPID(1,1, :); pidDES1 = pidDES1(:)';
    pidDES2 = minimumPID(2,1, :); pidDES2 = pidDES2(:)';
    pidDES3 = minimumPID(3,1, :); pidDES3 = pidDES3(:)';
   
    load('/home/jesseh/workspace/UnB/BioInspirados/Source/BioInspired_Computing/Lista 3/ResultsODE/minsPID_2017-11-17_06-52-57.mat');
    pidODES1 = minimumPID(1,1, :); pidODES1 = pidODES1(:)';
    pidODES2 = minimumPID(2,1, :); pidODES2 = pidODES2(:)';
    pidODES3 = minimumPID(3,1, :); pidODES3 = pidODES3(:)';

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
    
    closedLoopSystemPSO1 = closeLoop(plantName, systemNoiseTF, systemTF, pidPSOS1);
    closedLoopSystemPSO2 = closeLoop(plantName, systemNoiseTF, systemTF, pidPSOS2);
    closedLoopSystemPSO3 = closeLoop(plantName, systemNoiseTF, systemTF, pidPSOS3);
    
    closedLoopSystemOPSO1 = closeLoop(plantName, systemNoiseTF, systemTF, pidOPSOS1);
    closedLoopSystemOPSO2 = closeLoop(plantName, systemNoiseTF, systemTF, pidOPSOS2);
    closedLoopSystemOPSO3 = closeLoop(plantName, systemNoiseTF, systemTF, pidOPSOS3);

    closedLoopSystemDE1 = closeLoop(plantName, systemNoiseTF, systemTF, pidDES1);
    closedLoopSystemDE2 = closeLoop(plantName, systemNoiseTF, systemTF, pidDES2);
    closedLoopSystemDE3 = closeLoop(plantName, systemNoiseTF, systemTF, pidDES3);
    
    closedLoopSystemODE1 = closeLoop(plantName, systemNoiseTF, systemTF, pidODES1);
    closedLoopSystemODE2 = closeLoop(plantName, systemNoiseTF, systemTF, pidODES2);
    closedLoopSystemODE3 = closeLoop(plantName, systemNoiseTF, systemTF, pidODES3);
    
   
    [yPSO1, tPSO1] = impulse(closedLoopSystemPSO1, evaluationSignalTime);
    [yPSO2, tPSO2] = impulse(closedLoopSystemPSO2, evaluationSignalTime);
    [yPSO3, tPSO3] = impulse(closedLoopSystemPSO3, evaluationSignalTime);
    
    [yOPSO1, tOPSO1] = impulse(closedLoopSystemOPSO1, evaluationSignalTime);
    [yOPSO2, tOPSO2] = impulse(closedLoopSystemOPSO2, evaluationSignalTime);
    [yOPSO3, tOPSO3] = impulse(closedLoopSystemOPSO3, evaluationSignalTime);
    
    [yDE1, tDE1] = impulse(closedLoopSystemDE1, evaluationSignalTime);
    [yDE2, tDE2] = impulse(closedLoopSystemDE2, evaluationSignalTime);
    [yDE3, tDE3] = impulse(closedLoopSystemDE3, evaluationSignalTime);
    
    [yODE1, tODE1] = impulse(closedLoopSystemODE1, evaluationSignalTime);
    [yODE2, tODE2] = impulse(closedLoopSystemODE2, evaluationSignalTime);
    [yODE3, tODE3] = impulse(closedLoopSystemODE3, evaluationSignalTime);

    [ys, ts] = impulse(tf(1), evaluationSignalTime);
    [yp, tp] = impulse(systemTF);

    referenceLabel = string('Impulse');

    cnt = 1000;
    
	% Plotting PSO
    figure(1000); clf;
    hold on;
    plot(ts, ys);
    plot(tPSO1, yPSO1);
    plot(tPSO2, yPSO2);
    plot(tPSO3, yPSO3);
    title('System Response to a Disturbance on Ref = 0');
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend(referenceLabel, 'Response S=6', 'Response S=12', 'Response S=18');
    print(char(string(string('FillPageFigure') + string(cnt))),'-dpdf','-fillpage');
    cnt = cnt + 1;
    
    % Plotting OPSO
    figure(1001); clf;
    hold on;
    plot(evaluationSignalTime, ys);
    plot(evaluationSignalTime, yOPSO1);
    plot(evaluationSignalTime, yOPSO2);
    plot(evaluationSignalTime, yOPSO3);
    title('System Response to a Disturbance on Ref = 0');
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend(referenceLabel, 'Response S=6', 'Response S=12', 'Response S=18');
    print(char(string(string('FillPageFigure') + string(cnt))),'-dpdf','-fillpage');
    cnt = cnt + 1;
    
    % Plotting DE
    figure(1002); clf;
    hold on;
    plot(evaluationSignalTime, ys);
    plot(evaluationSignalTime, yDE1);
    plot(evaluationSignalTime, yDE2);
    plot(evaluationSignalTime, yDE3);
    title('System Response to a Disturbance on Ref = 0');
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend(referenceLabel, 'Response S=6', 'Response S=12', 'Response S=18');
    print(char(string(string('FillPageFigure') + string(cnt))),'-dpdf','-fillpage');
    cnt = cnt + 1;
    
	% Plotting ODE
    figure(1003); clf;
    hold on;
    plot(evaluationSignalTime, ys);
    plot(evaluationSignalTime, yODE1);
    plot(evaluationSignalTime, yODE2);
    plot(evaluationSignalTime, yODE3);
    title('System Response to a Disturbance on Ref = 0');
    xlabel('Time (s)');
    ylabel(string('System Response (') + string(systemResponseUnit) + string(')'));
    legend(referenceLabel, 'Response S=6', 'Response S=12', 'Response S=18');
    print(char(string(string('FillPageFigure') + string(cnt))),'-dpdf','-fillpage');
    cnt = cnt + 1;

