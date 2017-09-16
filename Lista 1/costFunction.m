%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioInspired Computing - UnB 2/2017
% Jessé Barreto - 17/0067033
% Assignment 1 - Implementation of benchmark cost functions.
%
% Function parameters: 
% functionName      - The function name as a string.
% point             - The N-dimensional point;
% Function results:
% res               - The function result;
% optimalRange      - The cost function suggested search space.
% globalMin         - The cost function global minima.
%
% References:
% http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page364.htm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [res, optimalRange, globalMin] = costFunction(functionName, x)
    format long
    [dim, elements] = size(x);

    switch functionName
        case 'griewank'
            globalMin = 0;
            optimalRange = repmat([-512 512], dim, 1);
            dims = 1:dim;
            res = 1 + (sum(x.^2)/4000.0) - prod(cos(x./sqrt(dims')));
        case 'rastrigin'
            globalMin = 0;
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(x.^2 - 10 * cos(2 * pi * x) + 10);
        case 'rosenbrock'
            globalMin = 0;
            optimalRange = repmat([-8 8], dim, 1);
            res = zeros(1, elements);
            for i=1:dim/2
               res = res + 100 * (x(2*i, :) - x(2*i-1, :).^2).^2 + (1 - x(2*i, :)).^2; 
            end
        case 'ackley'
            globalMin = 0;
            optimalRange = repmat([-32.768 32.768], dim, 1);
            res = -20 * exp(-0.2 * sqrt(sum(x.^2)/dim)) - exp(sum(cos(2 * pi * x)) / dim) + 20 + exp(1);
        case 'schwefel'
            globalMin = 0;
            optimalRange = repmat([-500 500], dim, 1);
            res = 418.9829 * dim - sum(x .* sin(sqrt(abs(x))));
        case 'michalewicz'
            gmin = [-1.8013 -4.687658 -9.66015];
            if (dim < 2)
                globalMin = dim * (gmin(2) - gmin(1)) / 3;
            elseif (dim == 2)
                globalMin = gmin(1);
            elseif (dim > 2 && dim < 5)
                globalMin = dim * (gmin(2) - gmin(1)) / 3;
            elseif (dim == 5)
                globalMin = gmin(2);
            elseif (dim > 5 && dim < 9)
                globalMin = dim * (gmin(2) - gmin(1)) / 3;
            elseif (dim == 9)
                globalMin = gmin(3);
            else
                globalMin = dim * (gmin(3) - gmin(2)) / 4;
            end
            optimalRange = repmat([0 pi], dim, 1);
            m = 10;
            dims = 1:dim;
            res = -1 * sum(sin(x) .* sin(dims' .* x.^2 / pi).^2);
        case 'quadric'
            globalMin = 0;
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(cumsum(x).^2);
        case 'sphere'
            globalMin = 0;
            optimalRange = repmat([-8 8], dim, 1);
            res = sum(x.^2);
        case 'styblinskitang'
            globalMin = -39.16599 * dim;
            optimalRange = repmat([-5 5], dim, 1);
            res = sum(x.^4 - 16 * x.^2 + 5 * x);
        case 'levy'
            globalMin = 0;
            optimalRange = repmat([-10 10], dim, 1);
            w = 1 + (x - 1) / 4;
            res = sum((w(1:dim-1,:) - 1).^2 .* (1 + 10 * sin(pi * w(1:dim-1,:) + 1).^2), 1) + sin(pi * w(1))^2 + (w(dim) - 1)^2 * (1 + sin(2 * pi * w(dim))^2);
        otherwise
            disp('Default Function Selected: sphere!');
            [res, optimalRange, globalMin] = costFunction('sphere', x);
    end
end
