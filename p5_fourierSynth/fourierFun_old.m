function [b_pul,c_pul,f_pul,f2_pul,p_pul,p2_pul] = fourierFun_old(Fo,k,N,N_show)

syms w n t

To = 1/Fo ;
fs = k*Fo; 

% Tren de pulsos
App = 1;

tvec = 0:1/fs:3*To;

wo = 2*pi*Fo;

bn_pulseTrain = 2/To * ( int(-App/2 * sin(wo*n*t),t,[-To/2 0])+ int(App/2 * sin(wo*n*t),t,[0 To/2]));
coeff_pulseTrain = [];
fHarm_pulseTrain = [];
pow_pulseTrain = [];
pulseTrain = 0;
 for i = 1:N %1:N --> 2N + 1 values
     n = i; % for eval
     coeff_pulseTrain(i) = eval(bn_pulseTrain);
     pow_pulseTrain(i) = (coeff_pulseTrain(i))^2;
     fHarm_pulseTrain(i) = i*wo/(2*pi);
     pulseTrain = pulseTrain +  coeff_pulseTrain(i)*sin(i*wo*tvec);
 end 

b_pul = coeff_pulseTrain;
c_pul = [0.5 .* abs(b_pul)];
c_pul = [fliplr(c_pul),0,c_pul];
f_pul = fHarm_pulseTrain;
f2_pul = [-1.*fliplr(fHarm_pulseTrain) 0 fHarm_pulseTrain]; 
p_pul = pow_pulseTrain;
p2_pul = c_pul.*c_pul;

figure()
plot(tvec,pulseTrain)
title(['Pulse Train of ', num2str(Fo), 'Hz'])
xlabel(['time [sec]'])

figure()
stem(f_pul(1:10),p_pul(1:10))
title(['Power of Pulse Train of ', num2str(Fo), 'Hz'])
xlabel(['frequency [Hz]'])

figure()
stem(f2_pul(N+1-N_show:N+1+N_show),p2_pul(N+1-N_show:N+1+N_show))
title(['Power of Pulse Train of ', num2str(Fo), 'Hz',' Double-sided'])
xlabel(['frequency [Hz]'])

end