function fit = ZDT2(var)

n = length(var);

fit(1) = var(1,1);

g = 1 + 9 * sum(var(1,2:n)) / (n - 1);

fit(2) = g * (1-(var(1,1)/g)^2);

end