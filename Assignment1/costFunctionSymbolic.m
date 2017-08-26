%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Implementation of benchmark cost functions symbolic.
%
% Function parameters: 
% functionName - The function name as a string.
% dimension - The search space dimension.
% Function results:
% symbolicSpace - As a vector of symbolic variables;
% symbolicFunction - As a symbolic function which depends on the variables in symbolic space;
%
% Bibliography: CEC2010
%               https://www.sfu.ca/~ssurjano/optimization.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [symbolicFunction, symbolicSpace] = costFunctionSymbolic(functionName, dimension)
% Symbolic
syms X F
X = sym('x', [1 dimension]);
if functionName == string('sphere')
    F = 0;
    for i=1:dimension
       F = F + X(i)^2;
    end
elseif functionName == string('elliptic')
    F = 0;
    for i=1:dimension
       F = F + (10)^((i - 1)/(dimension - 1)) * X(i)^2; 
    end
elseif functionName == string('rastrigin')
    F = 0;
    for i=1:dimension
       F = F + (X(i)^2 - 10 * cos(2 * pi * X(i)) + 10); 
    end
elseif functionName == string('rosenbrock')
    F = 0;
    for i=1:dimension-1
        F = F + 100 * (X(i)^2 - X(i+1))^2 + (X(i) - 1)^2;
    end
elseif functionName == string('ackley')
    S1 = 0;
    S2 = 0;
    for i=1:dimension
       S1 = S1 + X(i)^2;
       S2 = S2 + cos(2 * pi * X(i));
    end
    F = -20.0 * exp(-0.2 * sqrt(S1 / dimension)) - exp(S2 / dimension) + 20 + exp(1);
elseif functionName == string('schwefel')
    F = 418.9829 * dimension;
    for i=1:dimension
       F = F - X(i) * sin(sqrt(abs(X(i)))); 
    end
elseif functionName == string('bukin6')
    if dimension == 2
        F = 100 * sqrt(abs(X(2) - 0.01 * X(1)^2)) + 0.01 * abs (X(1) + 10);
    else
       disp('This function has to have 2-dimensions.') 
       pause;
    end
elseif functionName == string('cross-in-tray')
    if dimension == 2
        F = -0.0001 * (abs(sin(X(1)) * sin(X(2)) * exp(abs(100 - (sqrt(X(1)^2 + X(2)^2))/(pi)))) + 1)^0.1;
    else
        disp('This function has to have 2-dimensions.') 
        pause;
    end
elseif functionName == string('drop-wave')
    if dimension == 2
        F = -(1 + cos(12 * sqrt(X(1)^2 + X(2)^2)))/(0.5 * (X(1)^2 + X(2)^2) + 2);
    else
        disp('This function has to have 2-dimensions.') 
        pause;
    end
elseif functionName == string('eggholder')
    if dimension == 2
        F = -(X(2) + 47) * sin(sqrt(abs(X(2) + X(1)/2 + 47))) - X(1) * sin(sqrt(abs(X(1) - (X(2) + 47))));
    else
        disp('This function has to have 2-dimensions.') 
        pause;
    end
elseif functionName == string('griewank')
    S1 = 0;
    P1 = 1;
    for i=1:dimension
       S1 = S1 + (X(i)^2);
       P1 = P1 * cos(X(i) / sqrt(i));
    end
    F = S1 / 4000 - P1 + 1;
elseif functionName == string('holdertable')
    if dimension == 2
        F = -abs(sin(X(1)) * cos(X(2)) * exp(abs(1 - sqrt(X(1)^2 + X(2)^2) / pi)));
    else
        disp('This function has to have 2-dimensions.') 
        pause;
    end
elseif functionName == string('levy')
    S = 0;
    for i=1:dimension-1
        Wi = 1 + (X(i) - 1) / 4;
        S = S + (Wi - 1)^2 * (1 + 10 * sin(pi * Wi + 1)^2);
    end
    Wd = 1 + (X(dimension) - 1) / 4;
    F = S + sin(pi * (1 + (X(1) - 1) / 4))^2 + (Wd - 1)^2 * (1 + sin(2 * pi * Wd)^2);
elseif functionName == string('michalewicz')
    m = 10;
    F = 0;
    for i=1:dimension
        F = F - sin(X(i)) * sin((i * X(i)^2) / 2)^(2 * m);
    end
elseif functionName == string('styblinskitang')
    F = 0;
    for i=1:dimension
        F = F + (X(i)^4 - 16 * X(i)^2 + 5 * X(i));
    end
    F = 0.5 * F;
else % Quadric
    F = 0;
    for i=1:dimension
       S = 0;
       for j=1:i
           S = S + X(j);
       end
       F = F + S^2;
    end
end
symbolicFunction = F;
symbolicSpace = X;
end
