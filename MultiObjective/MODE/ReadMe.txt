**********************************************************************
Multi-Objective Optimization Differential Evolution Algorithm Tool Set
**********************************************************************


**********************************************************************

Beta version 

Copyright 2006 - 2012 - CPOH  

Predictive Control and Heuristic Optimization Research Group
	http://cpoh.upv.es

ai2 Institute
	http://www.ai2.upv.es

Universitat Politècnica de València - Spain.
	http://www.upv.es

**********************************************************************

Author
	Gilberto Reynoso Meza
	gilreyme@upv.es
	http://cpoh.upv.es/en/gilberto-reynoso-meza.html
    http://www.mathworks.es/matlabcentral/fileexchange/authors/289050

**********************************************************************

For new releases and bug fixing of this Tool Set please visit:

	http://cpoh.upv.es/en/research/software.html
	Matlab Central File Exchange

**********************************************************************


**********************************************************************
****************************DESCRIPTION*******************************
**********************************************************************

This Toolset comprises of the following files:


1) MODEparam.m

	Generates the required parameters to run the MODE optimization algorithm.

2) MODE.m

	Runs the optimization algorithm. It implements a basic multi-objective optimization algorithm based on Diferential Evolution (DE) algorithm:

Storn, R., Price, K., 1997. Differential evolution: A simple and 
efficient heuristic for global optimization over continuous spaces. 
Journal of Global Optimization 11, 341 – 359.

	When one objective is optimized, the standard DE runs; if two or more
objectives are optimized, the greedy selection step in DE algorithm is 
performed using a dominance relation.


3) CostFuntion.m
	The cost function to optimize

