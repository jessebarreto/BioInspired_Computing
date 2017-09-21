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

function L=TourLength(tour,model)

    n=length(tour);
    
    % the salesman must return to the first city
    tour=[tour tour(1)];
    
    % calculates tour's total distance
    L=0;
    for i=1:n
        L=L+model.D(tour(i),tour(i+1));
    end

end