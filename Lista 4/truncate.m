function [Var, Fit, rank, CD] = truncate(Pop,PopFit,N)

D = size(Pop,2);
M = size(PopFit,2);

Var   = zeros(N,D);
Fit   = zeros(N,M);
rank  = zeros(N,1);
CD    = zeros(N,1);
n_Var = 0;

r = nonDominatedRank(PopFit);
n_ranks = max(r);

for i=1:n_ranks
    % sols. do rank = i 
    ind_r = r == i;
    n_ind_r = sum(ind_r);    
    rPop = Pop(ind_r,:);
    rFit = PopFit(ind_r,:);
    
    % calcula crowding distance (CD)
    cf = computecf(rFit);
    [aux2,I] = sort(cf,'descend');
    
    % sort de acordo com CD
    rPop = rPop(I,:);
    rFit = rFit(I,:);
    cf = cf(I);
    
    % concatena sols
    ind_new = n_Var+1 : n_Var+n_ind_r;
    
    Var(ind_new,:) = rPop;
    Fit(ind_new,:) = rFit;    
    rank(ind_new,:) = i;
    CD(ind_new,:) = cf;
    
    % atualiza counter
    n_Var = n_Var + n_ind_r;    
    if n_Var > N % sai se já tem o no. de sols maximo
        break;
    end
end

Var = Var(1:N,:);
Fit = Fit(1:N,:);
rank = rank(1:N,:);
CD = CD(1:N,:);

end