function teste_hipotese(t1, t2)
% Esta função recebe duas fronteiras de Pareto para avaliação estatística.
%1) As fronteiras são ajustadas em tamanho
%2) Verifica se as sequência de valores são uma distribuição normal.
%3) Realiza o teste ANOVA se a distribuição for normal ou o teste
%Kruskal-Wallis se a distribuição não for normal.
erro_1 = t1;
erro_2 = t2;

%Ajustando o tamanho dos vertores erro_1 e erro_2
[m1, ~]=size(erro_1);
[m2, ~]=size(erro_2);
%% Igualando as duas sequências
if (m1 == m2)
    
elseif (m1 > m2)
    aux = randsample(m1,m2); %m2 é a quantidade de linhas de aux e m1 é o limite superior
    erro_1 = erro_1(aux,1);
else
    aux = randsample(m2,m1); %m1 é a quantidade de linhas de aux e m2 é o limite superior
    erro_2 = erro_2(aux,1);
end
%% Verificando se as duas frenquências vêm da mesma distribuição
h1 = kstest2(erro_1,erro_2);
if (h1 == 0)
    disp('Data in vectors "Data I" and "Data II" comes from populations with the same distribution.')
    return
else
    disp('Data in vectors "Data I" and "Data II" comes from populations with the different distribution.\n')
end


std_erro1 = std(erro_1);
std_erro2 = std(erro_2);

if ((std_erro1 == 0) || (std_erro2 == 0))
    disp('Desvio padrão igual a zero de uma das sequências.')
    erro_1
    erro_2
    return
end

erro_n1 = (erro_1 - mean(erro_1))/std_erro1;
erro_n2 = (erro_2 - mean(erro_2))/std_erro2;

h1 = kstest(erro_n1);        %O kstest exige (conforme ajuda do Matlab) que os dados sejam normalizados.
h2 = kstest(erro_n2);
y = [erro_1 erro_2];

if (h1 == 0 )&&(h2 == 0)
    [p, tbl, stats] = anova1(y);
    disp('Both series come from normal distribution')
else
    [p2,h,stat] = ranksum(y(:,1),y(:,2)) %apenas para distribuições que não são normais.
    figure(1);
    boxplot(y, 'notch', 'on');
    disp('One of them does not come from normal distribuition')
end
mediana1 = median(y(:,1))
mediana2 = median(y(:,2))

end