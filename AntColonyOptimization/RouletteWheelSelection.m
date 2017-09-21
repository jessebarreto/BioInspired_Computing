%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA103
% Project Title: Ant Colony Optimization for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function j=RouletteWheelSelection(P)

    r=rand;
    
    % Acumulative sum of the P array
    C=cumsum(P);
    
    % It can't be the same city, that's why P(ant(k).Tour)=0
    % Selects the next city at random by the first pheromone cumulative
    % value that match the random requisite r<=C
    j=find(r<=C,1,'first');

end