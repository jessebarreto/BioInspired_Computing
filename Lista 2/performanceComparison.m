
% Clean MatLab Environment
clear all;
close all;
clc;

S = [20]; %number of particles
N = [6 9 13 18 22]; %number of dimensions
functionNames = [string('quadric') string('sphere') string('griewank') string('rastrigin') string('rosenbrock') string('ackley') string('schwefel') string('michalewicz')];

% Use function
f = 3;

% Use Dimension
d = 5;

% Load Algorithm Values and Data
experimentARPSO = load('./ResultsPSOAR/experimentValues_2017-10-28_12-40-26.mat');
load('./ResultsPSOAR/medians_2017-10-28_12-40-26.mat');
valuesARPSO = experimentARPSO.experimentValues(1, d, f, :);
medianARPSO = medians(1, d, f, :);

experimentOBLPSO = load('./ResultsPSOOBL/experimentValues_2017-10-28_15-45-00.mat');
load('./ResultsPSOOBL/medians_2017-10-28_15-45-00.mat')
valuesOBLPSO = experimentOBLPSO.experimentValues(1, d, f, :);
medianOBLPSO = medians(1, d, f, :);

experimentARDE = load('./ResultsDEAR/experimentValues_2017-10-28_14-02-36.mat');
load('./ResultsDEAR/medians_2017-10-28_14-02-36.mat');
valuesARDE = experimentARDE.experimentValues(1, d, f, :);
medianARDE = medians(1, d, f, :);


experimentOBLDE = load('./ResultsDEOBL/experimentValues_2017-10-28_13-13-49.mat');
load('./ResultsDEOBL/medians_2017-10-28_13-13-49.mat');
valuesOBLDE = experimentOBLDE.experimentValues(1, d, f, :);
medianOBLDE = medians(1, d, f, :);

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


		
