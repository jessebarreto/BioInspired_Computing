% X = matriz 
% M = Tamaho da população
% F = Fator de mutação
% m = número do indivíduo atual

function [V]=rand1(X,M,F,m)%,div)

    div_min = 0.25;
    div_max = 0.50;

    dir = 1;
%     if (div < div_min)
%         dir = -1;
%     elseif (div > div_max)
%         dir = 1;
%     end
	R=randperm(M);
	j=R(1);
	k=R(2);
	p=R(3);
	u=R(4);
	v=R(5);
	if j==m
	   j=R(6);
	elseif k==m
	   k=R(6);
	elseif p==m
	   p=R(6);	
	elseif u==m
	   u=R(6);	
	elseif v==m
	   v=R(6);					   
	end
	V=X(j,:)+dir*F*(X(k,:)-X(p,:));