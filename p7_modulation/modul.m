function [x_sc,x_gp] = modul(t,fs,Tw,Np,wave,carrier,fa,fb,char,signal_title)

figure()
plot(t(1:Np*Tw*fs),wave(1:Np*Tw*fs));
title(['Wave: ' signal_title]);
% 2. Genere una portadora de al menos 10 veces la frecuencia 
% de la moduladora. La ventana temporal debe ser igual a la 
% de la moduladora
figure()
plot(t(1:Np*Tw*fs),carrier(1:Np*Tw*fs));
title(['Carrier for ' signal_title]);

% 3. Use las señales generadas para realizar una modulación AM de doble banda
% lateral con portadora suprimida. Grafique en una misma figura, 
% la moduladora, la portadora, y señal modulada. ¿Qué puede observar? 
% ¿La señal modulada se parece a la señal de información?

x_sc = carrier .* wave; % supressed carrier
figure()
subplot(4,1,1)
plot(t(1:Np*Tw*fs),wave(1:Np*Tw*fs));
title('Wave');
subplot(4,1,2)
plot(t(1:Np*Tw*fs),carrier(1:Np*Tw*fs));
title('Carrier ');
subplot(4,1,3)
plot(t(1:Np*Tw*fs),x_sc(1:Np*Tw*fs));
title('Suppresed Carrier');
sgtitle(['Modulation Comparison for ' signal_title]);

% 4. Realice ahora una modulación en formato gran portadora con un índice 
% de modulación del 100%. Grafique en una misma figura, la moduladora, 
% la portadora, y señal modulada. ¿Qué puede observar? ¿La señal modulada 
% se parece a la señal de información?

alpha = 1;
x_gp = carrier .* (1 + alpha*wave); % gran portadora

subplot(4,1,4)
plot(t(1:Np*Tw*fs),x_gp(1:Np*Tw*fs));
title('Gran Portadora');

% 5. Varié el índice de modulación para el formato gran portadora y grafiqué los resultados.
% ¿Puede concluir a partir de la grafica que es el índice de modulación?
figure()
j = 1;

max = 21;
rows =  6; %floor(max/2)+1;
subplot(rows,2,j)
plot(t(1:Np*Tw*fs),wave(1:Np*Tw*fs));
title('Original wave')
j = j +1;

for i  = 1:2:max   
   alpha = i * 0.1;
   x_gp = carrier .* (1 + alpha*wave);
   subplot(rows,2,j)
   plot(t(1:Np*Tw*fs),x_gp(1:Np*Tw*fs));
   title(['alpha = ' num2str(alpha)])
   j = j +1;
end

sgtitle(['Variation of Modulation Index for ' signal_title]);

% restore 100% version
alpha = 1;
x_gp = carrier .* (1 + alpha*wave); % gran portadora

% razon de extincion , razon entre nodo y antinodo en la modulada
% alpha > 1 -> sobremodulacion
% repercute en la potencia y en el espectro
% y en la razon de los coeficientes de la portadora y la de informacion 
% en el espectro



% 6. Use la transformada de Fourier para observar el comportamiento espectral 
% de la moduladora, la portadora y la señal modulada. Muestre los resultados 
% obtenidos usando subplots. El procedimiento debe hacerse para cada 
% modulación. En el caso de gran portadora use nuevamente un índice de 
% modulación del 100%

f = [];
[f(1,:),a_w,p_w] = freq_analysis(wave,fs,'Wave',0,0,0,1);
[f(2,:),a_c,p_c] = freq_analysis(carrier,fs,'Carrier',0,0,0,1);
[f(3,:),a_xsc,p_xsc] = freq_analysis(x_sc,fs,'Suppressed Carrier',0,0,0,1);
[f(4,:),a_xgp,p_xgp] = freq_analysis(x_gp,fs,'Gran Portadora',0,0,0,1);

for i = 1: length(fa)
if (fa(i) == 0)
    fa(i) = 1;
end

if (fb(i) == 0)
    fb(i) = length(f(i,:));
else
    fb(i) = interp1(f(i,:),1:length(f(i,:)),fb(i),'nearest');
    fa(i) = interp1(f(i,:),1:length(f(i,:)),fa(i),'nearest');
end
end

if (char == 'p') %plot power
    figure()
    subplot(4,1,1)
    %plot(fre_w(fa:fb),p_w(fa:fb));
    plot(f(1,(fa(1):fb(1))),p_w(fa(1):fb(1)));
    title(['Wave'])
    xlabel('Frequency [Hz]');
    ylabel('Power');

    subplot(4,1,2)
    %plot(fre_c(fa:fb),p_c(fa:fb));
    plot(f(2,(fa(2):fb(2))),p_c(fa(2):fb(2)));
    title('Carrier');
    xlabel('Frequency [Hz]');
    ylabel('Power');

    subplot(4,1,3)
    %plot(fre_xsc(fa:fb),p_xsc(fa:fb));
    plot(f(3,(fa(3):fb(3))),p_xsc(fa(3):fb(3)));
    title('Suppresed Carrier');
    xlabel('Frequency [Hz]');
    ylabel('Power');

    subplot(4,1,4)
    %plot(fre_w(fa:fb),p_w(fa:fb));
    plot(f(4,(fa(4):fb(4))),p_xgp(fa(4):fb(4)));
    title('Gran Portadora');
    xlabel('Frequency [Hz]');
    ylabel('Power');
    sgtitle(['Power/Frequency Behaviour of the Modulation for ' signal_title]);
end

if (char == 'a') %plot amplitude
figure()
subplot(4,1,1)
%plot(fre_w(fa:fb),p_w(fa:fb));
plot(f(1,(fa(1):fb(1))),a_w(fa(1):fb(1)));
title(['Wave'])
xlabel('Frequency [Hz]');
ylabel('Amplitude');

subplot(4,1,2)
%plot(fre_c(fa:fb),p_c(fa:fb));
plot(f(2,(fa(2):fb(2))),a_c(fa(2):fb(2)));
title('Carrier');
xlabel('Frequency [Hz]');
ylabel('Amplitude');

subplot(4,1,3)
%plot(fre_xsc(fa:fb),p_xsc(fa:fb));
plot(f(3,(fa(3):fb(3))),a_xsc(fa(3):fb(3)));
title('Suppresed Carrier');
xlabel('Frequency [Hz]');
ylabel('Amplitude');

subplot(4,1,4)
%plot(fre_w(fa:fb),p_w(fa:fb));
plot(f(4,(fa(4):fb(4))),a_xgp(fa(4):fb(4)));
title('Gran Portadora');
xlabel('Frequency [Hz]');
ylabel('Amplitude');
sgtitle(['Amplitude/Frequency Behaviour of the Modulation for ' signal_title]);
end
end

