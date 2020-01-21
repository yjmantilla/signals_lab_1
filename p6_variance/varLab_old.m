% Variable Aleatoria
clear all
close all
%% P1
limit = 10;
step = 0.01;
x = -limit:step:limit;
mu0 = 0;
var0 = 1;
sigma0 =sqrt(var0);
y0 =  normpdf(x,mu0,sigma0);
figure()
plot(x,y0);

%% P2
mu = [0 5 -5];
sigma = [1 3 0.3];
figure()
l = 1;

for i = 1:length(mu)
    for j = 1:length(sigma)
        y = normpdf(x,mu(i),sigma(j));
        subplot(length(mu),length(sigma),l)     
        plot(x,y);
        title(['Media: ',num2str(mu(i)),' - Dev.Std: ',num2str(sigma(j))])
        l = l + 1;
        %%
    end
end

%% P3
figure()
N = 10000; % variando N cambia la convergencia a ser uniforme 
rv =(rand(1,N));
hist(rv);

[m,d,v] = stats(rv);
[m_an,d_an,v_an] = stats_analytic(0,1);
% mientras mas datos mas se acerca a las cantidades estadisticas esperadas
disp('-------P3-------')
stats_str = 'Media: %10.9f - Varianza: %10.9f - Desv.Std: %10.9f\n';
N_STR = 'N: %10.0f\n';
fprintf(N_STR,N);
disp('Resultados :')
fprintf(stats_str,m,v,d)
disp('Resultados Analiticos:')
fprintf(stats_str,m_an,v_an,d_an)

% P4
disp('-------P4-------')
mMAT = mean(rv);
dMAT = std(rv);
vMAT = var(rv);


% Diferencias 
error_m = abs(m - mMAT);
error_d = abs(d - dMAT);
error_v = abs(v - vMAT);

stats_str = 'Media: %10.9f - Varianza: %10.9f - Desv.Std: %10.9f\n';
error_str = 'E_Media: %10.9f - E_Varianza: %10.9f - E_Desv.Std: %10.9f\n';

fprintf(N_STR,N);
disp('Resultados Matlab:')
fprintf(stats_str,mMAT,vMAT,dMAT)
disp('Resultados:')
fprintf(stats_str,m,v,d)
disp('Errores:')

fprintf(error_str,error_m,error_v,error_d)

% Correcion con w = 1,de esta manera matlab normaliza sobre N en vez de N-1

disp('w=1')
mMAT1 = mean(rv);
dMAT1 = std(rv,1);
vMAT1 = var(rv,1);


% Diferencias 
error_m1 = abs(m - mMAT1);
error_d1 = abs(d - dMAT1);
error_v1 = abs(v - vMAT1);

stats_str = 'Media: %10.9f - Varianza: %10.9f - Desv.Std: %10.9f\n';
error_str = 'E_Media: %10.9f - E_Varianza: %10.9f - E_Desv.Std: %10.9f\n';

fprintf(N_STR,N);
disp('Resultados Matlab:')
fprintf(stats_str,mMAT1,vMAT1,dMAT1)
disp('Resultados:')
fprintf(stats_str,m,v,d)
disp('Errores:')

fprintf(error_str,error_m1,error_v1,error_d1)



%% P5

channels = 8;
num = 10000;
rvMatrix = rand(channels,num);
%mu5 = 0.5;
%dev = 0.1;
%rvMatrix = [rand(channels/2,num);mu5 + dev.*randn(channels/2,num)];

% single channel
figure()
%nbins = num /100;
histogram(rvMatrix(1,:));
title('Single channel uniform distribution');
%figure()
%histfit(rvMatrix(5,:));
%title('Single channel normal distribution');

y = sum(rvMatrix,1); % sobre los canales

figure()
subplot(2,1,1)
histfit(y);
title('Sum distribution');

y_fit = mean(y) + std(y).*randn(1,num);
%figure()
subplot(2,1,2)
histfit(y_fit);
title('Generated normal distribution from mean and std of the sum.')

% Si se cumple el teorema del limite central.

function [media,dev,var] = stats(rv)
    media = sum(rv)/length(rv);
    var = sum(rv .* rv)/(length(rv))- media^2;
    dev = sqrt(var);
end

function [E] = E_unif(expr,a,b)
    syms x
    E = int((1/(b-a))*expr,x,[a b]);
end

function [me,de,va] = stats_analytic(a,b)
    syms x
    me = eval(E_unif(x,a,b));
    va = eval(E_unif(x*x,a,b))- me*me;
    de = sqrt(va);
end