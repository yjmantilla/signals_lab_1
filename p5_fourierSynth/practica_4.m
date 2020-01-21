%% Punto 4
clear all
[x,fs]=audioread('audio4.wav');
subplot(2,1,1)
plot(x); title('Clip de voz')
n=pow2(nextpow2(length(x))); %% se redondea la cantidad de datos a una potencia de 2
y = fft(x,n);
f = (0:n-1)*(fs/n)/10; 
power = abs(y).^2/n;
subplot(2,1,2);
plot(f(1:floor(n/2)),power(1:floor(n/2))); title('Espectro del clip de voz')
xlim([0 100])
xlabel('Frequency');
ylabel('Power');

%% Punto 5
vin=2*fs;
vfin=2.07*fs;
xaux=x(vin:vfin);
taux=(0: length(xaux)-1)/fs;
figure;
subplot(2,1,1)
plot(taux,xaux); title('Segmento 70 ms')
n=pow2(nextpow2(length(xaux))); %% se redondea la cantidad de datos a una potencia de 2
y = fft(xaux,n);
f = (0:n-1)*(fs/n)/10; 
power = abs(y).^2/n;
subplot(2,1,2);
plot(f(1:floor(n/2)),power(1:floor(n/2))); title('Espectro del segmento 70 ms')
xlim([5 65])
xlabel('Frequency');
ylabel('Power');
