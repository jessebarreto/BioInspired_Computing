close all
clear all
clc

%Common Parameter Setting
N=2; 		% Number of variables
M=15; 		% Populations size
F=1.25; 		% Mutation factor
C=0.95; 		% Crossover rate
I_max=200; 	% Max iteration time
Run=1;      % The number of test time
% 	X_max=5.12;
% 	X_min=-5.12;
% ------ Four peak functions ---------------------
%  str1='-(exp(-(x-4)^2-(y-4)^2)+exp(-(x+4)^2-(y-4)^2))';
%  str2='-(+2*exp(-x^2-(y+4)^2)+2*exp(-x^2-y^2))';
%  X_min = -8;
%  X_max =  8;
% ------ Sphere ---------------------
% str1='x^2';
% str2='+y^2';
% X_min = -8;
% X_max =  8;
% ------ Rastrigim --------------------
% str1='x^2-10*cos(2*pi*x)+10';
% str2='+y^2-10*cos(2*pi*y)+10';
% X_min = -8;
% X_max =  8;
%------Ackley ---------
a=20; b=0.2; c=2*pi;
str2='-exp(1/2*(cos(2*pi*x)+cos(2*pi*y)))+20+exp(1)';
str1='-20*exp(-0.2*sqrt(1/2*(x^2+y^2)))';
X_min = -10;
X_max =  10;

funstr=strcat(str1,str2);
Func=vectorize(inline(funstr));

% Initializing variables
X = zeros(M,N);
V = zeros(M,N);
U = zeros(1,N);

% Grid values are used for display only
Ngrid=100;
dx=(X_max-X_min)/Ngrid;
dy=(X_max-X_min)/Ngrid;
[x1,y1]=meshgrid(X_min:dx:X_max, X_min:dy:X_max);
z=Func(x1,y1);
figure(1);
surfc(x1,y1,z);
% 2.The whole test loop
for r=1:Run
    iter=0;
    % 1.Generate MxN matrix
    for m=1:M
        for n=1:N
            X(m,n)=X_min+rand()*(X_max-X_min);
        end
    end
    figure(2);
    % Plotando as partículas iniciais
    contour(x1,y1,z);
    hold on;
    plot(X(:,1),X(:,2),'.','markersize',10,'markerfacecolor','r');

    for i=1:I_max  % Stop when the iteration large than the max iteration time
        iter=iter+1;
        for m=1:M % For each individual
            % Mutation
            %[V]=rand1(X,M,F,m);
            rev=randperm(M,3);       %Create a list of random integers numbers between 1 and Xpop.
            V(m,:)= X(rev(1,1),:) + F*(X(rev(1,2),:) - X(rev(1,3),:));
            % Check if the element in the V matrix beyond the boundary.
            for n=1:N
                if V(m,n)>X_max
                    V(m,n)=X_max;
                end
                if V(m,n)<X_min
                    V(m,n)=X_min;
                end
            end
            
            % Crossover put the result in the U matrix
            for n=1:N
                R1=rand();
                if (R1<C)
                    U(1,n)=V(m,n);
                else
                    U(1,n)=X(m,n);
                end
            end
            
            % Selection
            if Func(U(1,1),U(1,2)) < Func(X(m,1), X(m,2))
                X(m,:)=U(1,:);
            end
            
            % Evaluate each individual's fitness value, and put the result in the Y matrix.
            Y(m,1)=Func(X(m,1),X(m,2));
            
        end % Now the 1th individual generated
        
        % Select the lowest fitness value
        [y,ind1]=sort(Y,1);
        Y_min=y(1,1);
        [Ymin,ind] = min(Y);
        
          %  plot the picture of iteration
%             figure(3);
%             plot(iter,Ymin,'r.');
%             xlabel('Iteration');
%             ylabel('Fitness');
%             title(sprintf('Iteration=%d, Fitness=%9.9f',i,Ymin));
%             grid on;
%             hold on;
        
    contour(x1,y1,z);
    hold on;
    plot(X(:,1),X(:,2),'r.','markersize',10);
    drawnow
    hold off;    
    end % Finish I_max times iteration
    
    % 		hold off;
    %         PlotR();
    %         hold on;
    %         scatter3(X(ind,1),X(ind,1),Ymin,'fill','ro');
    
end % Run times

out = Ymin;