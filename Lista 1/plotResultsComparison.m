close all;

load('./ResultsPSO/averages_2017-09-20_18-29-20.mat');
averagesPSO = averages;
load('./ResultsABC/averages_2017-09-20_22-35-37.mat')
averagesABC = averages;

S = [10 16 20]; %number of particles
N = [6 9 13 18 22]; %number of dimensionsensions
functionNames = [string('quadric') string('sphere') string('griewank') string('rastrigin') string('rosenbrock') string('ackley') string('schwefel') string('michalewicz')];

cnt = 0;
for f=1:8
	cnt = cnt+1;
	figure(cnt);
	for s=1:3
		subplot(3,1,s);
		plot(N, averagesPSO(s, :, f), 'r--', N, averagesABC(s, :, f), 'b-');
		title(functionNames(f) + string(' s = ') + string(S(s)));
		xlabel('Dimensão');
		ylabel('Média da função custo');
		legend('PSO', 'ABC');
	end
	print(char(string(string('FillPageFigure') + string(cnt))),'-dpdf','-fillpage');
end
