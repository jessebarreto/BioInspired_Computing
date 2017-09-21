%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Algoritmo OABC                                                        %%
%% Modified from runABC.m author: Dervis Karaboga                        %%
%%                                                                       %%
%% Inclusion of the opposition based learning during the scout phase.    %%
%% Experimental data have demonstrated that OABC outperforms the original%%
%% ABC algorithm for the Rastrigin and Rosenbrock problems               %%
%%                                                                       %%
%% Daniel Mauricio Mu�oz Arboleda                                        %%
%% Sistemas Mecatr�nicos                                                 %%
%% Universidade de Bras�lia                                              %%
%% Maio de 2012                                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc
format long e;

%/* Control Parameters of ABC algorithm*/
NP=24; %/* The number of colony size (employed bees+onlooker bees)*/
FoodNumber=NP/2; %/*The number of food sources equals the half of the colony size*/
limit=20; %/*A food source which could not be improved through "limit" trials is abandoned by its employed bee*/
maxCycle=10000; %/*The number of cycles for foraging {a stopping criteria}*/


%/* Problem specific variables*/
minThreshold = 1E-3;
objfun='rosenbrock'; %cost function to be optimized
D=6; %/*The number of parameters of the problem to be optimized*/
ub=ones(1,D)*7; %/*lower bounds of the parameters. */
lb=ones(1,D)*(-7);%/*upper bound of the parameters.*/

runtime=1;%/*Algorithm can be run many times in order to see its robustness*/

%Foods [FoodNumber][D]; /*Foods is the population of food sources. Each row of Foods matrix is a vector holding D parameters to be optimized. The number of rows of Foods matrix equals to the FoodNumber*/
%ObjVal[FoodNumber];  /*f is a vector holding objective function values associated with food sources */
%Fitness[FoodNumber]; /*fitness is a vector holding fitness (quality) values associated with food sources*/
%trial[FoodNumber]; /*trial is a vector holding trial numbers through which solutions can not be improved*/
%prob[FoodNumber]; /*prob is a vector holding probabilities of food sources (solutions) to be chosen*/
%solution [D]; /*New solution (neighbour) produced by v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) j is a randomly chosen parameter and k is a randomlu chosen solution different from i*/
%ObjValSol; /*Objective function value of new solution*/
%FitnessSol; /*Fitness value of new solution*/
%neighbour, param2change; /*param2change corrresponds to j, neighbour corresponds to k in equation v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij})*/
%GlobalMin; /*Optimum solution obtained by ABC algorithm*/
%GlobalParams[D]; /*Parameters of the optimum solution*/
%GlobalMins[runtime]; /*GlobalMins holds the GlobalMin of each run in multiple runs*/

GlobalMins=zeros(1,runtime);

for r=1:runtime
  
% /*All food sources are initialized */
%/*Variables are initialized in the range [lb,ub]. If each parameter has different range, use arrays lb[j], ub[j] instead of lb and ub */

Range = repmat((ub-lb),[FoodNumber 1]);
Lower = repmat(lb, [FoodNumber 1]);
Foods = rand(FoodNumber,D) .* Range + Lower;

for i=1:(FoodNumber)
    ObjVal(i)=rosenbrock(Foods(i,:));
end

%reset trial counters
trial=zeros(1,FoodNumber);

%/*The best food source is memorized*/
BestInd=find(ObjVal==min(ObjVal));
BestInd=BestInd(end);
GlobalMin=ObjVal(BestInd);
GlobalParams=Foods(BestInd,:);

iter=1;
while ((iter <= maxCycle))

%%%%%%%%% EMPLOYED BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:(FoodNumber)
        
        %/*The parameter to be changed is determined randomly*/
        Param2Change=fix(rand*D)+1;
        
        %/*A randomly chosen solution is used in producing a mutant solution of the solution i*/
        neighbour=fix(rand*(FoodNumber))+1;
       
        %/*Randomly selected solution must be different from the solution i*/        
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end;
        
       sol=Foods(i,:);
       %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
       sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
        
       %  /*if generated parameter value is out of boundaries, it is shifted onto the boundaries*/
        ind=find(sol<lb);
        sol(ind)=lb(ind);
        ind=find(sol>ub);
        sol(ind)=ub(ind);
        
        %evaluate new solution
        ObjValSol=rosenbrock(sol);%feval(objfun,sol)+1;
        
       % /*a greedy selection is applied between the current solution i and its mutant*/
       if (ObjValSol<ObjVal(i)) %/*If the mutant solution is better than the current solution i, replace the solution with the mutant and reset the trial counter of solution i*/
%       if (FitnessSol>Fitness(i)) %/*If the mutant solution is better than the current solution i, replace the solution with the mutant and reset the trial counter of solution i*/
            Foods(i,:)=sol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
       else
            trial(i)=trial(i)+1; %/*if the solution i can not be improved, increase its trial counter*/
       end;
         
    end;

    %%%%%%%%%%%%%%%%%%%%%%%% CalculateProbabilities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %/* A food source is chosen with the probability which is proportioal to its quality*/
    %/*Different schemes can be used to calculate the probability values*/
    %/*For example prob(i)=fitness(i)/sum(fitness)*/
    %/*or in a way used in the metot below prob(i)=a*fitness(i)/max(fitness)+b*/
    %/*probability values are calculated by using fitness values and normalized by dividing maximum fitness value*/

    prob=(0.9.*ObjVal./max(ObjVal))+0.1;
    %%%%%%%%%%%%%%%%%%%%%%%% ONLOOKER BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    i=1;
    t=0;
    while(t<FoodNumber)
        if(rand>prob(i))
            t=t+1;
            %/*The parameter to be changed is determined randomly*/
            Param2Change=fix(rand*D)+1;

            %/*A randomly chosen solution is used in producing a mutant solution of the solution i*/
            neighbour=fix(rand*(FoodNumber))+1;

            %/*Randomly selected solution must be different from the solution i*/        
                while(neighbour==i)
                    neighbour=fix(rand*(FoodNumber))+1;
                end;

           sol=Foods(i,:);
           %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
           sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;

           %  /*if generated parameter value is out of boundaries, it is shifted onto the boundaries*/
            ind=find(sol<lb);
            sol(ind)=lb(ind);
            ind=find(sol>ub);
            sol(ind)=ub(ind);

            %evaluate new solution
            ObjValSol=rosenbrock(sol);%feval(objfun,sol)+1;

           % /*a greedy selection is applied between the current solution i and its mutant*/
           if (ObjValSol<ObjVal(i)) %/*If the mutant solution is better than the current solution i, replace the solution with the mutant and reset the trial counter of solution i*/=
                Foods(i,:)=sol;
                ObjVal(i)=ObjValSol;
                trial(i)=0;
            else
                trial(i)=trial(i)+1; %/*if the solution i can not be improved, increase its trial counter*/
           end;
        end;

        i=i+1;
        if (i==(FoodNumber)+1) 
            i=1;
        end;   
    end; 


    %/*The best food source is memorized*/
    ind=find(ObjVal==min(ObjVal));
    ind=ind(end);
    if (ObjVal(ind)<GlobalMin)
    GlobalMin=ObjVal(ind);
    GlobalParams=Foods(ind,:);
    end;
%     if GlobalMin-1 <= minThreshold
%         break;
%     end
         
         
    %%%%%%%%%%%% SCOUT BEE PHASE
    %%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %/*determine the food sources whose trial counter exceeds the "limit" value. 
    %In Basic ABC, only one scout is allowed to occur in each cycle*/

    ind=find(trial==max(trial));
    ind=ind(end);
    if (trial(ind)>limit)
        Bas(ind)=0;
        sol=(ub-lb).*rand(1,D)+lb;
        ObjValSol=feval(objfun,sol);
        Foods(ind,:)=sol;
        ObjVal(ind)=ObjValSol;
   end        

%     %%%%% Apply OABC opposition based ABC in the scout bee phase %%%%%
%     for par=1:FoodNumber
%         if (trial(par)>limit)
%             sol = Foods(par,:);
%             for dim=1:D
%                 alfa=rand()-0.5;
%                 if alfa>0
%                     sol(dim)=-rand()*Range(1) + Lower(1);
%                     pb=1;
%                 end
%             end
% %             ObjValSol=feval(objfun,sol)+1;
% %             if (ObjValSol<ObjVal(par)) %/*If the mutant solution is better than the current solution i, replace the solution with the mutant and reset the trial counter of solution i*/
% %                 Foods(par,:)=sol;
% %                 ObjVal(par)=ObjValSol;
% %             end
%             bp=1;
%         end
%     end

    fprintf('Iter=%d ObjVal=%f\n',iter,GlobalMin);
    iter=iter+1;

end % End of ABC

GlobalMins(r)=GlobalMin;
fprintf('\nGlobalMin=%f\n',GlobalMin-1);
fprintf('GlobalParams=%f\n',GlobalParams);
end; %end of runs

save all

