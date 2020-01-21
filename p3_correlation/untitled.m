[y,fs]=audioread('sound.wav');
t = (0: length(y)-1)/fs;

figure
plot(y);
title('audio signal')
xlabel('time')
ylabel('Amplitude')
a=34000;
b=35000;
cut = y(a:b);
tcut = t(a:b);

figure
plot(tcut,cut)
title('cutted audio signal')
xlabel('time')
ylabel('Amplitude')

rcc = xcorr(cut,cut);
plot(rcc)

rcy = xcorr(cut,y);
plot(rcy);
