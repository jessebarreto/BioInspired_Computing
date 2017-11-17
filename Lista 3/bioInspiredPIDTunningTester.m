%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% BioInspired PID Tunning tester.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

numberOfExperimentsPerParameters = 32;

% Max number of iterations
maxIterations = 150;
%                       1                       2                       3                       4                       5                       6                       7                        8
plantNames = [string('suspension') string('dcmotorspeed') string('dcmotorposition') string('cruisecontrol') string('invertedpendulum') string('aircraftpitch') string('ballbeam') string('professor')];
plantName = plantNames(5);

algorithms = [string('PSO') string('OPSO') string('DE') string('ODE')];

PSOParameters = [1 1 0.1 15 1 1.5 1.5];
OPSOParameters = [1 1 0.1 15 1 1.5 1.5 40];
DEParameters = [1 1.0 1.35 0.95];
ODEParameters = [1 1.0 1.35 0.95 40];

algorithmsParameters = {PSOParameters; OPSOParameters; DEParameters; ODEParameters};

parfor algorithmIndex = 4:numel(algorithms)
	algorithmParameters = algorithmsParameters{algorithmIndex};

	switch algorithms(algorithmIndex)
        case string('ODE')
            ODETester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);
		case string('DE')
			DETester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);
		case string('OPSO')
			OPSOTester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);
		otherwise
			PSOTester(algorithmParameters, maxIterations, numberOfExperimentsPerParameters, plantName);
    end
end
