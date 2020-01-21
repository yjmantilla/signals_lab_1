function [f,amp,power] = freq_analysis(signal,fs,signal_title,fa,fb, pl,k)
%k is how many seconds, pl is the plot boolean
if (fa == 0)
    fa = 1;
end

% mientras mas datos de la señal se tengan mejor es la estimacion de fft
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
power = amp.^2;
%power = (1/(fs*L)) * abs(y(1:L/2+1)).^2;
power = 10*log10(power);
if (fb == 0)
    fb = length(f);
else
    fb = interp1(f,1:length(f),fb,'nearest');
    fa = interp1(f,1:length(f),fa,'nearest');
end

if (pl == 1)
figure()
subplot(3,1,1)
plot(t(1:round(k*fs)),signal(1:round(k*fs)));
title([signal_title ' over time'])
xlabel('Time [s]');
ylabel('Amplitude');

subplot(3,1,2)
plot(f(fa:fb),amp(fa:fb));
%plot(f,amp);
title('Amplitude Spectrum');
xlabel('Frequency [Hz]');
ylabel('Amplitude');

subplot(3,1,3)
plot(f(fa:fb),power(fa:fb));
%plot(f,power);
title('Power Spectrum');
xlabel('Frequency [Hz]');
ylabel('Power [dB]');
sgtitle(signal_title);
end

end