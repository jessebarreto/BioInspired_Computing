%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Implementation of benchmark cost functions.
%
% Function parameters: 
% functionName - The function name as a string.
% point - The N-dimensional point;
% Function results:
% functionResult - The function result;
%
% References:
% http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page364.htm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [res, optimalRange] = costFunction(functionName, x)
    format long
    [dim, elements] = size(x);

    switch functionName
        case 'griewank'
            optimalRange = repmat([-512 512], dim, 1);
            dims = 1:dim;
            res = 1 + (sum(x.^2)/4000.0) - prod(cos(x./sqrt(dims')));
        case 'rastrigin'
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(x.^2 - 10 * cos(2 * pi * x) + 10);
        case 'rosenbrock'
            optimalRange = repmat([-8 8], dim, 1);
            res = zeros(1, elements);
            for i=1:dim/2
               res = res + 100 * (x(2*i, :) - x(2*i-1, :).^2).^2 + (1 - x(2*i, :)).^2; 
            end
        case 'ackley'
            optimalRange = repmat([-32.768 32.768], dim, 1);
            res = -20 * exp(-0.2 * sqrt(sum(x.^2)/dim)) - exp(sum(cos(2 * pi * x)) / dim) + 20 + exp(1);
        case 'schwefel'
            optimalRange = repmat([-500 500], dim, 1);
            res = 418.9829 * dim - sum(x .* sin(sqrt(abs(x))));
        case 'michalewicz'
            optimalRange = repmat([0 pi], dim, 1);
            m = 10;
            dims = 1:dim;
            res = -1 * sum(sin(x) .* sin(dims' .* x.^2 / pi).^2);
        case 'quadric'
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(cumsum(x).^2);
        case 'sphere'
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(x.^2);
        case 'styblinskitang'
            optimalRange = repmat([-5 5], dim, 1);
            res = sum(x.^4 - 16 * x.^2 + 5 * x);
        case 'levy'
            optimalRange = repmat([-10 10], dim, 1);
            w = 1 + (x - 1) / 4;
            res = sum((w(1:dim-1,:) - 1).^2 .* (1 + 10 * sin(pi * w(1:dim-1,:) + 1).^2), 1) + sin(pi * w(1))^2 + (w(dim) - 1)^2 * (1 + sin(2 * pi * w(dim))^2);
        otherwise
            disp('Default State!');
            [res, optimalRange] = costFunction('sphere', x);
    end
end
