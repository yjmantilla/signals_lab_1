function [demod_wave,demod_wave_filtered] = ourDemod(signal,carrier,t,fs,To,signal_title,cutoff,doPlot)
%Realice la demodulación del formato doble banda lateral con supresión de
%portadora sin usar la función amdemod().

% Para ellos multiplique la señal modulada por la portadora. Observe el resultado en el dominio
% de la frecuencia. Para filtrar la componente de alta frecuencia que se ve en espectro, y que
% no es parte de la señal de información, use un filtro pasa bajas. Para esta labor puede realizar
% la función de transferencia de un circuito RC con una frecuencia de corte menor a la
% frecuencia de componente que quiere filtrar. Luego realice la convolución entre el filtro y señal
% que quiere filtrar. ¿El resultado es la señal de información que se tenía inicialmente?

time_offset = 0.5;
num_periods = 5;
demod_wave = signal .* carrier;

freq_analysis(demod_wave,fs,[signal_title ' demodulated (unfiltered) ' 'Freq Behaviour'],0,0,doPlot,0.01);

%fc = 300; % Cut off frequency
%fs = 1000; % Sampling rate
[b,a] = butter(6,cutoff/(fs/2)); % Butterworth filter of order 6
demod_wave_filtered = filter(b,a,demod_wave); % Will be the filtered signal

if (doPlot ==1)
figure()
subplot(2,1,1)
plot(t(1:round((time_offset+num_periods)*To*fs)),demod_wave(1:round((time_offset+num_periods)*To*fs)))
title([signal_title ' demodulated (unfiltered)'])
subplot(2,1,2)
plot(t(1:round((time_offset+num_periods)*To*fs)),demod_wave_filtered(1:round((time_offset+num_periods)*To*fs)))
title([signal_title ' demodulated (filtered)'])
sgtitle(['Demodulation of ' signal_title ' with our function']);
end
end