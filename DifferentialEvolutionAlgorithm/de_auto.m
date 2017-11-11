% Algoritmo DE automatizado

clear all;
format long g;

tic

for funcao = 5%1:6
    ss = 1;
    nn = 1;
    if (funcao == 3)
        threshold = 0.1;
    else
        threshold = 0.01;
    end
    for S = [6 18 25 50 100 150 200 300]
        for N = [2:2:22]
            goal = 0;
            for i = 1:32
                out(i) = de(S,N,funcao);
                if(out(i) < threshold)
                    goal = goal + 1;
                end
            end

            idx = nn+(ss-1)*11;
            tabela(idx,1) = mean(out);
            tabela(idx,2) = median(out);
            tabela(idx,3) = min(out);
            tabela(idx,4) = std(out);
            tabela(idx,5) = goal;

            nn = nn + 1;
        end
        nn = 1;
        ss = ss + 1;
    end
    switch funcao
        case 1
            xlswrite('de_sphere.xls', tabela); % sphere
        case 2
            xlswrite('de_quadric.xls', tabela); % quadric
        case 3
            xlswrite('de_rosenbrock.xls', tabela); % rosenbrock
        case 4
            xlswrite('de_rastrigin.xls', tabela); % rastrigin
        case 5
            xlswrite('de_schwefel.xls', tabela); % schwefel
        case 6
            xlswrite('de_ackley.xls', tabela); % ackley
        otherwise
            disp('invalid value');
    end
end

toc
