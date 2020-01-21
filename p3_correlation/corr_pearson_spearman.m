% Lectura de datos
T = readtable('DatosCorrelacion.xlsx');
% Es necesario convertir los datos a un arreglo numerico
T = table2array(T); 
edad = T(:,1);
calculo = T(:,2);
informatica = T(:,3);

figure(1)
scatter(calculo,informatica,'filled','red');
title('Calculo vs Informatica')
xlabel('Calculo')
ylabel('Informatica')

% la grafica sugiere que puede haber una relacion lineal entre las notas
% de ambas materias, se espera una correlacion de pearson menor a 1 pero 
% positivo y no tan 
% cercano a 0 ya que se puede ver la relación lineal visualmente

figure(2)
scatter(edad,calculo,'filled','red');
title('Edad vs Calculo')
xlabel('Edad')
ylabel('Calculo')


figure(3)
scatter(edad,informatica,'filled','red');
title('Edad vs Informatica')
xlabel('Edad')
ylabel('Informatica')

% las graficas de edad contra las notas de ambas materias sugieren que no
% hay una relacion lineal entre estas, se espera una correlacion de 
% pearson cercana a 0.

% Notacion de correlaciones: [tipo]_[inicial campo 1][inicial campo 2]
% s -> spearman
% p -> pearson
% i -> informatica
% c -> calculo
% e -> edad


s_ci = corr(calculo,informatica,'Type','Spearman'); 
s_ec = corr(edad,calculo,'Type','Spearman');
p_ci = corr(calculo,informatica,'Type','Pearson');
p_ec = corr(edad,calculo,'Type','Pearson');

s_ei = corr(edad,informatica,'Type','Spearman');
p_ei = corr(edad,informatica,'Type','Pearson');

fprintf('Pearson Cálculo vs Informática: %f\n',p_ci)
fprintf('Spearman Cálculo vs Informática: %f\n',s_ci)

fprintf('Pearson Edad vs Cálculo: %f\n',p_ec)
fprintf('Spearman Edad vs Cálculo: %f\n',s_ec)
