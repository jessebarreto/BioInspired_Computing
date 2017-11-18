function fit = ZDT6(var)

n = length(var);

fit(1) = 1 - exp( -4 * var(1,1) ) * ((sin(6 * pi * var(1,1)))^6) ;

g = 1 + 9 * ((sum(var(1,2:n)) / (n - 1))^.25);

fit(2) = g * (1-(fit(1)/g)^2);

end