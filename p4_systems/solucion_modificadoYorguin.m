clear all
close all
clc;

%punto3
r=50;
l=1E-3;
c=0.1E-6;
[wn,q,al]=ecuacion(r,l,c)

%punto4
syms w s t
%funcion de transferencia en terminos de laplace
funtL(s)=((1/(l*c))/(s^2+r*s/l+1/(l*c)));

%funcion de transferencia en terminos de fourier
funtF(w)=funtL(i*w);
sysfuntF=tf([-1/(l*c)],[1,r/l,1/(l*c)]);

%transformada inversa de fourier
funtiF(t)=ifourier(funtF(w),w,t);
fs=1e6;
t1=0:1/fs:500e-6;
y1=eval(funtiF(t1));
figure(1);

%Grafica de la respuesta al impulso
plot(t1,y1/fs);
title('Respuesta al Impulso');
xlabel('Tiempo');
ylabel('Amplitud');
axis([min(t1) max(t1) min(y1/fs) max(y1/fs)]);
grid on;


%punto5: Respuesta al escalon unitario escalon unitario
xt=heaviside(t1);
yt=conv(xt,y1);
t2=0:1/fs:1e-3;
figure(2)
plot(t2,yt/fs);
title('Convolucion entre la Funcion y un escalon');
xlabel('Tiempo');
ylabel('Amplitud');
axis([min(t2) 5e-4 min(yt/fs) max(yt/fs)]);
grid on

%punto 6: respuesta ante una sinusoide con w0
xt2=sin(wn*t1);
yt2=conv(xt2,y1);
figure(3)
plot(t1,xt2);
hold on
plot(t2,yt2/fs);
hold off
legend('Entrada','Salida')
title('Convolucion entre la Funcion de Transferencia y Senoidal')
xlabel('Tiempo');
ylabel('Amplitud');
axis([min(t2) 5e-4 min(yt2/fs) max(yt2/fs)]);
grid on;

%punto 7 diagrama de bode:
figure(4)
bode(sysfuntF);
grid on;

%punto 8: (Convolucion entre un tren de pulsos y h(t))

wnn=0.1e-3;
t1=0:1/fs:1500e-6;
pt=square(wn/10*t1);

figure(6)
subplot(2,1,1);
plot(t1,pt);
axis([min(t1) 15e-4 min(pt) max(pt)]);
grid on;
xlabel('Tiempo');
ylabel('Amplitud');
title('Tren de pulsos')

yt3=conv(y1,pt);
t3=linspace(0,2*t1(end),size(yt3,2));
subplot(2,1,2)
plot(t3,yt3/fs,'r-');
axis([min(t3) max(t3) min(yt3/fs) max(yt3/fs)]);
xlabel('Tiempo');
ylabel('Amplitud');
title('Convolucion entre Tren de Pulsos y Circuito RLC')
grid on;

%punto 9
t1=0:1/fs:500e-6; %ya que fue modificado en el punto 8 

