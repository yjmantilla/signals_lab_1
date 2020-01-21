function [f,amp,power] = freq_analysis(signal,fs,signal_title,fa,fb)
if (fa == 0)
    fa = 1;
end

L = pow2(nextpow2(length(signal))); %% se redondea la cantidad de datos a una potencia de 2
y = fft(signal,L);

amp2 = abs(y/L); % obtain double sided spectrum
amp = amp2(1:L/2+1); % obtain single sided spectrum (first half of spec2)
% double the amplitudes (because spec2 has half the amplitude but bilateral)
amp(2:end-1) = 2*amp(2:end-1);
% no need to shift to zero, or to shiftlr the negative side because of how
% fft computes the result, in the first half part of the vector is already
% the correct fourier transform
% see fftshift for more detailed info

t = linspace(0,length(signal)/fs,length(signal));
f = fs*(0:(L/2))/L;
power = amp.^2/L;

if (fb == 0)
    fb = length(f);
else
    fb = interp1(f,1:length(f),fb,'nearest'); %way to find closest value to something
    fa = interp1(f,1:length(f),fa,'nearest');
end

figure()
subplot(3,1,1)
plot(t,signal);
title([signal_title ' over time'])
xlabel('Time [s]');
ylabel('Amplitude');

subplot(3,1,2)
plot(f(fa:fb),amp(fa:fb));

title('Amplitude Spectrum');
xlabel('Frequency [Hz]');
ylabel('Amplitude');

subplot(3,1,3)
plot(f(fa:fb),power(fa:fb));
title('Power Spectrum');
xlabel('Frequency [Hz]');
ylabel('Power');

sgtitle(signal_title);
end