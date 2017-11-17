
% Clean MatLab Environment
clear all;
close all;
clc;

S = [6 12 18]; %number of particles
N = [3]; %number of dimensionsions

plantNames = [string('suspension') string('dcmotorspeed') string('dcmotorposition') string('cruisecontrol') string('invertedpendulum') string('aircraftpitch') string('ballbeam') string('professor')];
plantName = plantNames(5);

% Use Dimension
d = 1;

% Load Algorithm Values and Data
experimentARPSO = load('./ResultsPSO/experimentValues_2017-11-16_23-35-10.mat');
load('./ResultsPSO/medians_2017-11-16_23-35-10.mat');
valuesARPSO = experimentARPSO.experimentValues(3, d, :);
medianARPSO = medians(3, d, :);

experimentOBLPSO = load('./ResultsOPSO/experimentValues_2017-11-16_23-35-10.mat');
load('./ResultsOPSO/medians_2017-11-16_23-35-10.mat')
valuesOBLPSO = experimentOBLPSO.experimentValues(3, d, :);
medianOBLPSO = medians(3, d, :);

experimentARDE = load('./ResultsDE/experimentValues_2017-11-16_23-35-10.mat');
load('./ResultsDE/medians_2017-11-16_23-35-10.mat');
valuesARDE = experimentARDE.experimentValues(3, d, :);
medianARDE = medians(3, d, :);


experimentOBLDE = load('./ResultsODE/experimentValues_2017-11-17_06-52-57');
load('./ResultsODE/medians_2017-11-17_06-52-57.mat');
valuesOBLDE = experimentOBLDE.experimentValues(3, d, :);
medianOBLDE = medians(3, d, :);

% Uses Kolmogorov-Smirnov to discover if the algorithms are parametric
alpha = 0.95;
hARPSO = kstest(valuesARPSO(:));
hOBLPSO = kstest(valuesOBLPSO(:));
hARDE = kstest(valuesARDE(:));
hOBLDE = kstest(valuesOBLDE(:));

% Uses Kruskal-Wallis to check whether the distributions follow distributions with same medians
% DE Algorithms
pDE = kruskalwallis([valuesARDE(:) valuesOBLDE(:)]);

% PSO Algorithms
pPSO = kruskalwallis([valuesARPSO(:) valuesOBLPSO(:)]);

% All tested algorithms
pAll = kruskalwallis([valuesARDE(:) valuesOBLDE(:) valuesARPSO(:) valuesOBLPSO(:)]);


if medianOBLDE < medianARDE && medianOBLDE < medianOBLPSO && medianOBLDE < medianARPSO
	disp('OBLDE has the best median!');
	[pOBLDE_ARDE, hOBLDE_ARDE, statOBLDE_ARDE] = ranksum(valuesOBLDE(:), valuesARDE(:));
	[pOBLDE_OBLPSO, hOBLDE_OBLPSO, statOBLDE_OBLPSO] = ranksum(valuesOBLDE(:), valuesOBLPSO(:));
	[pOBLDE_ARPSO, hOBLDE_ARPSO, statOBLDE_ARPSO] = ranksum(valuesOBLDE(:), valuesARPSO(:));
elseif medianOBLPSO < medianARDE && medianOBLPSO < medianOBLDE && medianOBLPSO < medianARPSO
	disp('OBLPSO has the best median!');
	[pOBLPSO_ARDE, 		hOBLPSO_ARDE, 		statOBLPSO_ARDE] = 		ranksum(valuesOBLPSO(:), valuesARDE(:));
	[pOBLPSO_OBLDE, 	hOBLPSO_OBLDE, 		statOBLPSO_OBLDE] =		ranksum(valuesOBLPSO(:), valuesOBLDE(:));
	[pOBLPSO_ARPSO, 	hOBLPSO_ARPSO, 		statOBLPSO_ARPSO] = 	ranksum(valuesOBLPSO(:), valuesARPSO(:));
elseif medianARDE < medianOBLDE && medianARDE < medianOBLPSO && medianARDE < medianARPSO
	disp('ARDE has the best median!');
	[pARDE_OBLPSO, 		hARDE_OBLPSO, 		statARDE_OBLPSO] = 		ranksum(valuesARDE(:), valuesOBLPSO(:));
	[pARDE_OBLDE, 		hARDE_OBLDE, 		statARDE_OBLDE] =		ranksum(valuesARDE(:), valuesOBLDE(:));
	[pARDE_ARPSO, 		hARDE_ARPSO, 		statARDE_ARPSO] = 		ranksum(valuesARDE(:), valuesARPSO(:));
else
	disp('ARPSO has the best median!');
	[pARPSO_OBLPSO, 	hARPSO_OBLPSO, 		statARPSO_OBLPSO] = 	ranksum(valuesARPSO(:), valuesOBLPSO(:));
	[pARPSO_OBLDE, 		hARPSO_OBLDE, 		statARPSO_OBLDE] =		ranksum(valuesARPSO(:), valuesOBLDE(:));
	[pARPSO_ARDE, 		hARPSO_ARDE, 		statARPSO_ARDE] = 		ranksum(valuesARPSO(:), valuesARDE(:));
end


		
