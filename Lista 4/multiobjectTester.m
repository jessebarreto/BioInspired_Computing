%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% MultiObject Tester Parameters
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

% PARAMETERS
moData.numberOfExperimentsPerParameters = 17;

% Max number of iterations
moData.maxIterations = 250;

% Variables regarding the optimization problem
moData.numberOfObjectives = 3;
moData.numberOfContraints = 0;
moData.numberOfDecisionVariables = 30 ;

% Fitness function benchmark
moData.fitnessFunctionList = [string('ZDT1') string('ZDT2') string('ZDT3') string('ZDT4') ...
						string('DTLZ1') string('DTLZ2') string('DTLZ3') string('DTLZ5')];
moData.benchmarkZDTFunctionsUsed = [6 3];
moData.benchmarkDTLZFunctionsUsed = [5 6];

% Search Space
moData.searchSpace = [zeros(moData.numberOfDecisionVariables, 1) ...
				ones(moData.numberOfDecisionVariables, 1)];

% Save results
moData.saveResultsFlag = true;

% MultiObjective Tester
modeParetoFunction = modeTester(moData);


