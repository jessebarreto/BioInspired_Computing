%% MODEparam
% Generates the required parameters to run the MODE optimization algorithm.
%%
%% Beta version 
% Copyright 2006 - 2012 - CPOH  
% Predictive Control and Heuristic Optimization Research Group
%      http://cpoh.upv.es
% ai2 Institute
%      http://www.ai2.upv.es
% Universitat Polit�cnica de Val�ncia - Spain.
%      http://www.upv.es
%%
%% Author
% Gilberto Reynoso Meza
% gilreyme@upv.es
% http://cpoh.upv.es/en/gilberto-reynoso-meza.html
% http://www.mathworks.es/matlabcentral/fileexchange/authors/289050
%%
%% For new releases and bug fixing of this Tool Set please visit:
% http://cpoh.upv.es/en/research/software.html
% Matlab Central File Exchange
%%
%% Overall Description
% This code implements a basic multi-objective optimization algorithm based
% on Diferential Evolution (DE) algorithm:
%
% Storn, R., Price, K., 1997. Differential evolution: A simple and 
% efficient heuristic for global optimization over continuous spaces. 
% Journal of Global Optimization 11, 341 � 359.
%
% When one objective is optimized, the standard DE runs; if two or more
% objectives are optimized, the greedy selection step in DE algorithm is 
% performed using a dominance relation.
%%
clear all;
close all;
clc;
%% Variables regarding the optimization problem

MODEDat.NOBJ = 3;                          % Number of objectives
MODEDat.NRES = 0;                          % Number of constraints
MODEDat.NVAR   = 10;                       % Numero of decision variables
MODEDat.mop = str2func('CostFunction');    % Cost function
MODEDat.CostProblem='DTLZ2';               % Cost function instance

MODEDat.FieldD =[zeros(MODEDat.NVAR,1)...
                    ones(MODEDat.NVAR,1)]; % Initialization bounds
MODEDat.Initial=[zeros(MODEDat.NVAR,1)...
                    ones(MODEDat.NVAR,1)]; % Optimization bounds

%% Variables regarding the optimization algorithm
% For guidelines for the parameter tuning see:
%
% Storn, R., Price, K., 1997. Differential evolution: A simple and 
% efficient heuristic for global optimization over continuous spaces. 
% Journal of Global Optimization 11, 341 � 359.
%
% Das, S., Suganthan, P. N., 2010. Differential evolution: A survey of the 
% state-of-the-art. IEEE Transactions on Evolutionary Computation. Vol 15,
% 4 - 31.
%
MODEDat.XPOP = 20;             % Population size
MODEDat.Esc = 0.5;                         % Scaling factor
MODEDat.Pm= 0.2;                           % Croosover Probability
%
%% Other variables
%
MODEDat.InitialPop=[];                     % Initial population (if any)
MODEDat.MAXGEN =250;                     % Generation bound
MODEDat.MAXFUNEVALS = 150*MODEDat.NVAR...  % Function evaluations bound
    *MODEDat.NOBJ;                         
MODEDat.SaveResults='yes';                 % Write 'yes' if you want to 
                                           % save your results after the
                                           % optimization process;
                                           % otherwise, write 'no';
%% Initialization (don't modify)
MODEDat.CounterGEN=0;
MODEDat.CounterFES=0;
%% Put here the variables required by your code (if any).
%
%
%
%% 
%
OUT=MODE(MODEDat);                         % Run the algorithm.
%
%% Release and bug report:
%
% November 2012: Initial release
