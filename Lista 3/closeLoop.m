



function [systemClosedLoop] = closeLoop(plantName, systemModelDisturbance, systemModel, pidConstants)

	% Integrator Laplace
	s = zpk(0, [], 1);

	% PID Controller Transfer Function
    controllerTF = pidConstants(1) + pidConstants(2) / s + pidConstants(3) * s;

	% based on the plant name chooses the correct model
    switch plantName
    	case 'suspension'
    		% Bus suspension system model

    		% Close Loop
    		systemClosedLoop = systemModelDisturbance * feedback(systemModel, controllerTF);

    	case 'dcmotorspeed'
    		% DC Motor Speed - System Modelling
    		
    		% Close Loop
    		systemClosedLoop = feedback(systemModel * controllerTF, 1);

        case 'dcmotorposition'
        	% DC Motor Position - System Modelling
        	% Close Loop
    		systemClosedLoop = feedback(systemModel * controllerTF, 1);

		case 'cruisecontrol'
			% Cruise Control - System Modelling
			% Close Loop
    		systemClosedLoop = feedback(systemModel * controllerTF, 1);

		case 'invertedpendulum'
			% Inverted Pendulum - System Modelling
			% Close Loop
    		systemClosedLoop = feedback(systemModel, controllerTF);

		case 'aircraftpitch'
			% Aircraft Pitch: System Modeling
			% Close Loop
    		systemClosedLoop = feedback(systemModel * controllerTF, 1);

		case 'ballbeam'
			% Ball & Beam: System Modeling
			% Close Loop
    		systemClosedLoop = 	feedback(systemModel * controllerTF, 1);
		otherwise
			% Example System
			% Close Loop
    		systemClosedLoop = feedback(systemModel * controllerTF, 1);
    end
