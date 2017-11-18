%% MODE
% Multi-objective Evolutionary Algorithm (MOEA) based on Differential
% Evolution (DE).
% It implements a greedy selection based on pure dominance.
% DE algorithm has been introduced in:
%
% Storn, R., Price, K., 1997. Differential evolution: A simple and 
% efficient heuristic for global optimization over continuous spaces. 
% Journal of Global Optimization 11, 341 � 359.
%%
%% Beta version 
% Copyright 2006 - 2012 - CPOH  
% Predictive Control and Heuristic Optimization Research Group
%      http://cpoh.upv.es
% ai2 Institute
%      http://www.ai2.upv.es
% Universitat Polit�cnica de Val�ncia - Spain.
%      http://www.upv.es
%%
%% Author
% Gilberto Reynoso Meza
% gilreyme@upv.es
% http://cpoh.upv.es/en/gilberto-reynoso-meza.html
% http://www.mathworks.es/matlabcentral/fileexchange/authors/289050
%%
%% For new releases and bug fixing of this Tool Set please visit:
% http://cpoh.upv.es/en/research/software.html
% Matlab Central File Exchange
%%
%% Overall Description
% This code implements a basic multi-objective optimization algorithm based
% on Diferential Evolution (DE) algorithm.
%
% When one objective is optimized, the standard DE runs; if two or more
% objectives are optimized, the greedy selection step in DE algorithm is 
% performed using a dominance relation.
%%
%
%% 

function OUT=MODE(MODEDat)

%% Reading parameters from MODEDat
Generaciones  = MODEDat.MAXGEN;    % Maximum number of generations.
Xpop          = MODEDat.XPOP;      % Population size.
Nvar          = MODEDat.NVAR;      % Number of decision variables.
Nobj          = MODEDat.NOBJ;      % Number of objectives.
Bounds        = MODEDat.FieldD;    % Optimization bounds.
Initial       = MODEDat.Initial;   % Initialization bounds.
ScalingFactor = MODEDat.Esc;       % Scaling fator in DE algorithm.
CrossOverP    = MODEDat.Pm;        % Crossover probability in DE algorithm.
mop           = MODEDat.mop;       % Cost function.

PFstar = load('ZDT1.txt');

%% Initial random population
Parent = zeros(Xpop,Nvar);  % Parent population.
Mutant = zeros(Xpop,Nvar);  % Mutant population.
Child  = zeros(Xpop,Nvar);  % Child population.
FES    = 0;                 % Function Evaluation.
%Gera a população inicial
for xpop=1:Xpop
    for nvar=1:Nvar
        Parent(xpop,nvar) = Initial(nvar,1)+(Initial(nvar,2)...
                            - Initial(nvar,1))*rand();
    end
end
%Limita o espaço de busca aqui 1 x 1.
if size(MODEDat.InitialPop,1)>=1
    Parent(1:size(MODEDat.InitialPop,1),:)=MODEDat.InitialPop;
end

JxParent = mop(Parent,MODEDat); %A variável mop chama a função custo para avaliar Parent e MODEDat é o nome da função a ser otimizada
FES = FES+Xpop;   

%% Evolution process

for n=1:Generaciones 
    
    for xpop=1:Xpop
        rev=randperm(Xpop);
        
        %% Mutant vector calculation
        Mutant(xpop,:)= Parent(rev(1,1),:)+ScalingFactor*...
                       (Parent(rev(1,2),:)-Parent(rev(1,3),:));
        
        for nvar=1:Nvar %Bounds are always verified
            if Mutant(xpop,nvar)<Bounds(nvar,1)
                Mutant(xpop,nvar) = Bounds(nvar,1);
            elseif Mutant(xpop,nvar)>Bounds(nvar,2)
                Mutant(xpop,nvar)=Bounds(nvar,1);
            end
        end
        
        %% Crossover operator
        for nvar=1:Nvar
            if rand() > CrossOverP
                Child(xpop,nvar) = Parent(xpop,nvar);
            else
                Child(xpop,nvar) = Mutant(xpop,nvar);
            end
        end
    end

    JxChild = mop(Child,MODEDat);
    FES = FES + Xpop;

    %% Selection
    tipo = 3;
    switch tipo
        case 1
            for xpop=1:Xpop
                if JxChild(xpop,:) <= JxParent(xpop,:) 
                    Parent(xpop,:) = Child(xpop,:);
                    JxParent(xpop,:) = JxChild(xpop,:);
                end
            end
        case 2
            Pop = [Parent;Child];
            JxPop = [JxParent; JxChild];
                        
            [aux1,ia]=unique(JxPop, 'rows');
            JxPop = JxPop (ia,:);
            Pop = Pop(ia,:);
            
            [Parent, JxParent, rank, CD] = truncate(Pop, JxPop, Xpop);
        case 3
            Pop = [];
            JxPop = [];
            for xpop=1:Xpop
                if JxChild(xpop,:) <= JxParent(xpop,:)
                    Pop = [Pop; Child(xpop,:)];
                    JxPop = [JxPop; JxChild(xpop,:)];
                elseif (JxParent(xpop,:)<= JxChild(xpop))
                    Pop = [Pop; Parent(xpop,:)];
                    JxPop = [JxPop; JxParent(xpop,:)];
                else
                    Pop = [Pop; Child(xpop,:); Parent(xpop,:)];
                    JxPop = [JxPop; JxChild(xpop,:); JxParent(xpop,:)];
                end
            end
            [aux2,ia]=unique(JxPop, 'rows');
            JxPop = JxPop (ia,:);
            Pop = Pop(ia,:);
            
            [Parent, JxParent, rank, CD] = truncate(Pop, JxPop, Xpop);
    end
	PFront=JxParent;
	PSet=Parent;

    OUT.Xpop           = Parent;   % Population
    OUT.Jpop           = JxParent; % Poopulation's Objective Vector
    OUT.PSet           = PSet;     % Pareto Set
    OUT.PFront         = PFront;   % Pareto Front
    OUT.Param          = MODEDat;  % MODE Parameters
    MODEDat.CounterGEN = n;
    MODEDat.CounterFES = FES;
    
%     [OUT MODEDat]=PrinterDisplay(OUT,MODEDat); % To print results on screen
%     plot(JxParent(:,1),JxParent(:,2), '*r', PFstar(:,1),PFstar(:,2),'-k');
    pause(0.01);
%     if FES>MODEDat.MAXFUNEVALS || n>MODEDat.MAXGEN
%         disp('Termination criteria reached.')
%         break;
%     end
end

OUT.Xpop=PSet;
OUT.Jpop=PFront;
[OUT.PFront, OUT.PSet]=DominanceFilter(PFront,PSet); %A Dominance Filter


if strcmp(MODEDat.SaveResults,'yes')
    save(['OUT_' datestr(now,30)],'OUT'); %Results are saved
end

disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('Red  asterisks : Set Calculated.')
disp('Black diamonds : Filtered Set.')
if strcmp(MODEDat.SaveResults,'yes')
    disp(['Check out OUT_' datestr(now,30) ...
          ' variable on folder for results.'])
end
disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')

F=OUT.PFront;
for xpop=1:size(F,1)
    if Nobj==1
        figure(123); hold on;
        plot(MODEDat.CounterGEN,log(min(F(:,1))),'dk', ...
            'MarkerFaceColor','k'); grid on; hold on;
    elseif Nobj==2
        figure(123); hold on;
        plot(F(xpop,1),F(xpop,2),'dk','MarkerFaceColor','k');...
            grid on; hold on;
    elseif Nobj==3
        figure(123); hold on;
        plot3(F(xpop,1),F(xpop,2),F(xpop,3),'dk','MarkerFaceColor','k');...
            grid on; hold on;
    end
end

%% Print and Display information
% Modify at your convenience
%
function [OUT Dat]=PrinterDisplay(OUT,Dat)

disp('------------------------------------------------')
disp(['Generation: ' num2str(Dat.CounterGEN)]);
disp(['FEs: ' num2str(Dat.CounterFES)]);
disp(['Pareto Front Size: ' mat2str(size(OUT.PFront,1))]);
disp('------------------------------------------------')

if mod(Dat.CounterGEN,1)==0
    if Dat.NOBJ==3
        figure(123);
        plot3(OUT.PFront(:,1),OUT.PFront(:,2),OUT.PFront(:,3),'*r'); 
        grid on;
    elseif Dat.NOBJ==2
        figure(123);
        plot(OUT.PFront(:,1),OUT.PFront(:,2),'*r'); grid on;
    elseif Dat.NOBJ==1
        figure(123);
        plot(Dat.CounterGEN,log(min(OUT.PFront(:,1))),'*r'); ...
            grid on; hold on;
    end
end

%% Dominance Filter
%
% A filter based on dominance criteria
%
function [Frente Conjunto]=DominanceFilter(F,C)

Xpop=size(F,1);
Nobj=size(F,2);
Nvar=size(C,2);
Frente=zeros(Xpop,Nobj);
Conjunto=zeros(Xpop,Nvar);
k=0;

for xpop=1:Xpop
    Dominado=0;
    
    for compara=1:Xpop
        if F(xpop,:)==F(compara,:)
            if xpop > compara
                Dominado=1;
                break;
            end
        else
            if F(xpop,:)>=F(compara,:)
                Dominado=1;
                break;
            end
        end
    end
    
    if Dominado==0
        k=k+1;
        Frente(k,:)=F(xpop,:);
        Conjunto(k,:)=C(xpop,:);
    end
end
Frente=Frente(1:k,:);
Conjunto=Conjunto(1:k,:);

%% Release and bug report:
%
% November 2012: Initial release
