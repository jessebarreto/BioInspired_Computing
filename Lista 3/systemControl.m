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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [systemTF, systemNoiseTF, evaluationStepAmplitude, evaluationSignalTime, reference, optimalRange] = systemControl(plantName)
    format long

    % Laplace Differentiator
    s = tf([1 0], [1]);

    % based on the plant name chooses the correct model
    switch plantName
    	case 'suspension'
    		% Bus suspension system model
    		m1 = 2500;
			m2 = 320;
			k1 = 80000;
			k2 = 500000;
			b1 = 350;
			b2 = 15020;

			nump=[(m1+m2) b2 k2];
			denp=[(m1*m2) (m1*(b1+b2))+(m2*b1) (m1*(k1+k2))+(m2*k1)+(b1*b2) (b1*k2)+(b2*k1) k1*k2];
			G1=tf(nump,denp);

			num1=[-(m1*b2) -(m1*k2) 0 0];
			den1=[(m1*m2) (m1*(b1+b2))+(m2*b1) (m1*(k1+k2))+(m2*k1)+(b1*b2) (b1*k2)+(b2*k1) k1*k2];
			G2=tf(num1,den1);

			numf=num1;
			denf=nump;
			F=tf(numf,denf);

			% Model for the bus suspension response to a force actuator
    		systemTF = G1;

    		% Model for the bus suspension response to a disturbance force
    		systemNoiseTF = F;

    		% Evaluation Signal
    		evaluationSignalTime = 0:0.01:5;
    		evaluationStepAmplitude = 0.1;

    		reference = 0;

    		% Range of constant search
			optimalRange = [[0 2*208025];[0 2*832100];[0 2*624075]];

    	case 'dcmotorspeed'
    		% DC Motor Speed - System Modelling
            J = 0.01;
            b = 0.1;
            K = 0.01;
            R = 1;
            L = 0.5;

			systemTF = K/((J*s+b)*(L*s+R)+K^2);

			% Model doesnt have noise
			systemNoiseTF = 1;

			evaluationSignalTime = 0:0.01:5;
    		evaluationStepAmplitude = 1;

    		reference = evaluationStepAmplitude;

    		% Range of constant search
			optimalRange = [[0 250];[0 250];[0 250]];

			% Calculated ~Values
			% Kp = 100;
	  		% Ki = 200;
	  		% Kd = 10;

        case 'dcmotorposition'
        	% DC Motor Position - System Modelling
        	J = 3.2284E-6; 	%moment of inertia of the rotor
			b = 3.5077E-6; 	%motor viscous friction constant
			K = 0.0274;		%motor viscous friction constant
			R = 4;			%electric resistance
			L = 2.75E-6;	%electric inductance
				
			systemTF = K/(s*((J*s+b)*(L*s+R)+K^2));

			% Model doesnt have noise
			systemNoiseTF = 0;

			evaluationSignalTime = 0:0.01:5;
    		evaluationStepAmplitude = 1;

    		reference = evaluationStepAmplitude;

    		% Range of constant search
			optimalRange = [[0 250];[0 600];[0 250]];

    		% Calculated ~Values
   			% Kp = 21;
			% Ki = 500;
			% Kd = 0.05;

		case 'cruisecontrol'
			% Cruise Control - System Modelling
			m = 1000; %Vehicle mass
			b = 50; %Damping Coefficient

			systemTF = 1/(m*s+b);

			% Model doesnt have noise
			systemNoiseTF = 0;

			evaluationSignalTime = 0:0.1:20;
			evaluationStepAmplitude = 10;

    		reference = evaluationStepAmplitude;

			% Range of constant search
			optimalRange = [[0 900];[0 200];[0 100]];

			% Calculated ~Values
			% Kp = 800;
			% Ki = 40;
			% Kd = 0;

		case 'invertedpendulum'
			% Inverted Pendulum - System Modelling
			M = 0.5;
			m = 0.2;
			b = 0.1;
			I = 0.006;
			g = 9.8;
			l = 0.3;
			q = (M+m)*(I+m*l^2)-(m*l)^2;

			% P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);

			P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);

			% Pendulum System
			systemTF = P_pend;

			systemNoiseTF = 1;

			evaluationSignalTime = 0:0.001:2;
			evaluationStepAmplitude = NaN; % Impulse response

    		reference = 0;

			% Range of constant search
			optimalRange = [[0 900];[0 200];[0 100]];

			% Calculated ~Values
			% Kp = 100;
			% Ki = 1;
			% Kd = 20;

		case 'aircraftpitch'
			% Aircraft Pitch: System Modeling
			systemTF = (1.151*s+0.1774)/(s^3+0.739*s^2+0.921*s);

			% Model doesnt have noise
			systemNoiseTF = 0;

			evaluationSignalTime = 0:0.01:20;
			evaluationStepAmplitude = 0.2;

    		reference = evaluationStepAmplitude;

			% Range of constant search
			optimalRange = [[0 5];[0 5];[0 5]];

			% Calculated ~Values
			% $K_i$ = 0.5241, $K_p$ = 1.0482, and $K_d$ = 0.5241

		case 'ballbeam'
			% Ball & Beam: System Modeling
			m = 0.111;
			R = 0.015;
			g = -9.8;
			L = 1.0;
			d = 0.03;
			J = 9.99e-6;

			systemTF = -m*g*d/L/(J/R^2+m)/s^2;

			% Model doesnt have noise
			systemNoiseTF = 0;

			evaluationSignalTime = 0:0.01:8;
			evaluationStepAmplitude = 0.25;

    		reference = evaluationStepAmplitude;

			% Range of constant search
			optimalRange = [[0 100];[0 100];[0 100]];

			% Calculated ~Values
			% Kp = 15;
			% Ki = 0;
			% Kd = 40;	
		otherwise
			% Example System
			systemTF = tf([5], [1 3 7 5 0]);

			% Model doesnt have noise
			systemNoiseTF = 0;

			evaluationSignalTime = 0:0.01:5;
			evaluationStepAmplitude = 1;

    		reference = evaluationStepAmplitude;

			% Range of constant search
			optimalRange = [[0 100];[0 100];[0 100]];

			% Calculated ~Values
			% pidValues = [0.9470 0.0023 0.8524];
    end
