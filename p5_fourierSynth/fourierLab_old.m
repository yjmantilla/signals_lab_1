clear all;
clc;
syms w n t
Fo = 1 * 10^(3); % 10^(6)

To = 1/Fo ;
k = 3000; % k obtained heuristically, 2.2Fo wont work.
fs = k*Fo; 

% Tren de pulsos
App = 1;

tvec = 0:1/fs:3*To;

wo = 2*pi / To;


N = 1000;


bn_pulseTrain = 2/To * ( int(-App/2 * sin(wo*n*t),t,[-To/2 0])+ int(App/2 * sin(wo*n*t),t,[0 To/2]));
coeff_pulseTrain = [];
pulseTrain = 0;
 for i = 1:N
     n = i;
     coeff_pulseTrain(i) = eval(bn_pulseTrain);
     pulseTrain = pulseTrain +  coeff_pulseTrain(i)*sin(n*wo*tvec);
 end 

figure(1)
plot(tvec,pulseTrain)
%Diente de sierra
syms t n
bn_sawtooth = (2/To)*(int(App*t*sin(wo*n*t)/To,t,[-To/2 To/2]));


figure(2)

sawtooth = 0;
coeff_sawtooth = [];
 for i = 1:N
     n = i;
     coeff_sawtooth(i) = eval(bn_sawtooth);
     sawtooth = sawtooth + coeff_sawtooth(i)*sin(n*wo*tvec);   
 end 

plot(tvec,sawtooth)

% Triangular

syms t n
bn_triangle = (2/To)*(int((0 + 2*App*t/To)*sin(wo*n*t),t,[-To/4 To/4])+ int((App - 2*App*t/To)*sin(wo*n*t),t,[To/4 3*To/4]));
coeff_triangle = [];
figure(3)

triangle = 0;
 for i = 1:N
     n = i;
     coeff_triangle(i) = eval(bn_triangle);
     triangle = triangle + coeff_triangle(i)*sin(n*wo*tvec);   
 end 

plot(tvec,triangle)


