function [b,c,f,f2,p,p2,pdb,pdb2] = fourierFun_PulseTrain(App,Fo,f_factor,N,N_show)

syms w n t
signal_name = 'Pulse Train';
To = 1/Fo ;
fs = f_factor*Fo; % basically sets the sampling frequency (2.2 wont give good results) 

% Tren de pulsos
tvec = 0:1/fs:3*To;

wo = 2*pi*Fo;

bn = '2/To * ( int(-App/2 * sin(wo*n*t),t,[-To/2 0])+ int(App/2 * sin(wo*n*t),t,[0 To/2]))';

coeff = [];
fHarm = [];
pow = [];
signal = 0;
 for i = 1:N
     n = i; % for eval
     coeff(i) = eval(bn);
     pow(i) = (coeff(i))^2;
     fHarm(i) = i*wo/(2*pi);
     signal = signal +  coeff(i)*sin(i*wo*tvec);
 end 

b = coeff;
c = [0.5 .* abs(b)];
c = [fliplr(c),0,c];
f = fHarm;
f2 = [-1.*fliplr(fHarm) 0 fHarm]; 
k = f/Fo;
k2 = f2/Fo;
p = pow;
p2 = c.*c;

pdb = 10*log10(p./(1E-3));
pdb2 = 10*log10(p2./(1E-3));
figure()
plot(tvec,signal)
title([signal_name,' of ', num2str(Fo), 'Hz'])
xlabel(['time [sec]'])

figure()
stem(k(1:N_show),p(1:N_show))
title(['Amplitude Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
xlabel(['Harmonics'])
ylabel(['Amplitude Spectrum'])

figure()
stem(k2(N+1-N_show:N+1+N_show),p2(N+1-N_show:N+1+N_show))
title(['Amplitude Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
xlabel(['Harmonics'])
ylabel(['Amplitude Spectrum'])

figure()
stem(k(1:N_show),p(1:N_show))
title(['Power Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
xlabel(['Harmonics'])
ylabel(['Power Spectrum'])

figure()
stem(k2(N+1-N_show:N+1+N_show),p2(N+1-N_show:N+1+N_show))
title(['Power Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
xlabel(['Harmonics'])
ylabel(['Power Spectrum'])

figure()
stem(k(1:N_show),pdb(1:N_show))
title(['Power Spectrum [dBm] of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
xlabel(['Harmonics'])
ylabel(['Power Spectrum [dBm]'])

figure()
stem(k2(N+1-N_show:N+1+N_show),pdb2(N+1-N_show:N+1+N_show))
title(['Power Spectrum [dBm] of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
xlabel(['Harmonics'])
ylabel(['Power Spectrum [dBm]'])
end