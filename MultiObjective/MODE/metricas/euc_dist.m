function ED = euc_dist(pf)
% calcula a media da distancia euclidiana ate a origem da fronteira
[nsols, nobj] = size(pf);

po = zeros(1,nobj);
ed = zeros(nsols,1);

for i=1:nsols
    vec = pf(i,:) - po; 
    ed(i) = norm(vec);
end
ED = mean(ed);

end