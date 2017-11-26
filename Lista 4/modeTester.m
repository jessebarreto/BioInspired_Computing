%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Particle Swarm Optimiation
% v 0.5
% Multi-objective Differential Evolution Tester Parameters
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [modeResults] = modeTester(moData)

% MODE Parameters
populationSize = 20;
scalingFactor = 0.5;
crossOverProbability = 0.2;

% Other variables
initialPopulation = [];
functionEvaluation = 150 * moData.numberOfDecisionVariables * ...
						moData.numberOfObjectives;

% Figure Number 
figureNumber = 1;

% Used Functions
usedFunctions = [moData.benchmarkZDTFunctionsUsed, moData.benchmarkDTLZFunctionsUsed];

% % Variables which will hold all results
% modeResults.experimentValues = zeros(numel(usedFunctions), moData.numberOfExperimentsPerParameters);
modeResults.paretoFrontiers = zeros(numel(usedFunctions), moData.numberOfExperimentsPerParameters, populationSize, moData.numberOfObjectives);
modeResults.paretoSets = zeros(numel(usedFunctions), moData.numberOfExperimentsPerParameters, populationSize, moData.numberOfDecisionVariables);

modeResults.averagesIGD = 	zeros(numel(usedFunctions));
modeResults.mediansIGD = 	zeros(numel(usedFunctions));
modeResults.minimumsIGD = 	zeros(numel(usedFunctions));
modeResults.maximumsIGD = 	zeros(numel(usedFunctions));
modeResults.stdDevsIGD = 	zeros(numel(usedFunctions));

modeResults.averagesSpacing = 	zeros(numel(usedFunctions));
modeResults.mediansSpacing = 	zeros(numel(usedFunctions));
modeResults.minimumsSpacing = 	zeros(numel(usedFunctions));
modeResults.maximumsSpacing = 	zeros(numel(usedFunctions));
modeResults.stdDevsSpacing = 	zeros(numel(usedFunctions));

% modeResults.paretoFrontiers = cell(numel(usedFunctions), moData.numberOfExperimentsPerParameters);

% % Holds the current day and time
YMDHMS = clock;
timedate = [num2str(YMDHMS(1)) '-' num2str(YMDHMS(2),'%02d') '-' num2str(YMDHMS(3),'%02d') '_' num2str(YMDHMS(4),'%02d') '-' num2str(YMDHMS(5),'%02d') '-' num2str(floor(YMDHMS(6)),'%02d')];

for f = 1:numel(usedFunctions)
	for experimentNumber = 1:moData.numberOfExperimentsPerParameters
		[paretoFrontier, paretoSet] = modeFunction(moData.fitnessFunctionList(usedFunctions(f)), moData.maxIterations, ...
			populationSize, initialPopulation, moData.numberOfDecisionVariables, moData.numberOfObjectives, ...
			moData.numberOfContraints, moData.searchSpace, ...
			scalingFactor, crossOverProbability)

		% Save Experiment Values
		modeResults.paretoFrontiers(f, experimentNumber, :, :) = paretoFrontier;
		modeResults.paretoSets(f, experimentNumber, :) = paretoSet;
	end;


end;
