function [b,c,f,f2,p,p2,pdb,pdb2] = fourierFun(signal_name,App_val,Fo,f_factor,N,N_show,intExp,plt)

syms w n t
To = 1/Fo ;
fs = f_factor*Fo; % basically sets the sampling frequency (2.2 wont give good results) 
App = App_val;
% Tren de pulsos
tvec = 0:1/fs:3*To;

wo = 2*pi*Fo;

bn = intExp;

coeff = [];
fHarm = [];
pow = [];
signal = 0;
 for i = 1:N
     n = i; % for eval
     coeff(i) = eval(bn);
     pow(i) = 0.5*(coeff(i))^2; %check parseval for trigonometric series 
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

if (plt)   
    j = 1;
    %figure('units','normalized','outerposition',[0 0 1 1])
    figure()
    plot(tvec,signal)
    title([signal_name,' of ', num2str(Fo), 'Hz ,reconstructed with ', num2str(N),' harmonics'])
    xlabel(['time [sec]'])
    fig = gcf;
    %fig.PaperPositionMode = 'auto';
    saveas(fig,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    
    j = j+1;

    %figure('units','normalized','outerposition',[0 0 1 1])
    figure()
    %subplot(1,2,1)
    stem(k(1:N_show),p(1:N_show))
    title(['Amplitude Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
    xlabel(['Harmonics'])
    ylabel(['Amplitude Spectrum'])
    saveas(gcf,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;

    figure()
    %subplot(1,2,2)
    stem(k2(N+1-N_show:N+1+N_show),p2(N+1-N_show:N+1+N_show))
    title(['Amplitude Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
    xlabel(['Harmonics'])
    ylabel(['Amplitude Spectrum'])
    fig = gcf;
    %fig.PaperPositionMode = 'auto';
    saveas(fig,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;

    %figure('units','normalized','outerposition',[0 0 1 1])
    figure()
    %subplot(1,2,1)
    stem(k(1:N_show),p(1:N_show))
    title(['Power Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
    xlabel(['Harmonics'])
    ylabel(['Power Spectrum'])
    saveas(gcf,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;

    figure()
    %subplot(1,2,2)
    stem(k2(N+1-N_show:N+1+N_show),p2(N+1-N_show:N+1+N_show))
    title(['Power Spectrum of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
    xlabel(['Harmonics'])
    ylabel(['Power Spectrum'])
    fig = gcf;
    %fig.PaperPositionMode = 'auto';
    saveas(fig,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;

    %figure('units','normalized','outerposition',[0 0 1 1])
    figure()
    %subplot(1,2,1)
    stem(k(1:N_show),pdb(1:N_show))
    title(['Power Spectrum [dBm] of ',signal_name,' of ', num2str(Fo), 'Hz',' Single-sided'])
    xlabel(['Harmonics'])
    ylabel(['Power Spectrum [dBm]'])
    saveas(gcf,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;


    figure()
    %subplot(1,2,2)
    stem(k2(N+1-N_show:N+1+N_show),pdb2(N+1-N_show:N+1+N_show))
    title(['Power Spectrum [dBm] of ',signal_name,' of ', num2str(Fo), 'Hz',' Double-sided'])
    xlabel(['Harmonics'])
    ylabel(['Power Spectrum [dBm]'])
    fig = gcf;
    %fig.PaperPositionMode = 'auto';
    saveas(fig,[signal_name '_' num2str(Fo) '_' num2str(j) '.png']);
    j = j+1;
end
end