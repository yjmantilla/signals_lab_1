%% Punto 4
close all
clear all
[x,fs]=audioread('audio4.wav');
xavg = sum(x,2)'; % avg L R channels and transpose to make it row vector

[f,amp,pow]=freq_analysis(xavg,fs,'Audio Signal',0,1000);
% se observa bw entre 80 y 650 Hz
fa = 80;
fb = 650;
%% Punto 5

ti=round(2*fs);
tf=round(2.07*fs);
xaux=xavg(ti:tf);
[f5,amp5,pow5]=freq_analysis(xaux,fs,'70 ms of Audio Signal',0,fb);

% visually
numH = 5; % num of harmonics to look for
h = [105.5 210.9 316.4 421.9 539.1];
k = [1 2 3 4 5];
%width = 9;
% find harmonics

%obtain exact harmonics
harmonics = [];
for i = 1:numH
    h_ind = interp1(f5,1:length(f5),h(i),'nearest');
    %[maxVal(i), harmonics_indexes(i)] = max(pow5(h_ind-width:h_ind+width));
    %harmonics(i) = f5(harmonics_indexes(i));
    harmonics(i) = f5(h_ind);
end

% find the fundamental frequency that best adjust to harmonics
f1 = polyfitZero(k,h,1);

