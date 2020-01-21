function [mod_mat,demod_mat] = matlabMod(signal,fs,fo,signal_title,doPlot)

% 8. Consulte sobre la funci�n ammod(). Use dicha funci�n para modular una se�al de
% informaci�n con los mismos par�metros del literal 1 y 2. Observe la se�al en el dominio
% del tiempo y de la frecuencia. �El resultado concuerda con lo obtenido en alguno de
% los literales anteriores? �con cu�l?
mod_mat = ammod(signal, 10*fo, fs);

% 9. Use la funci�n amdemod () para demodular el resultado del numeral 8. Observe de
% nuevo la se�al tanto en el dominio del tiempo como en frecuencia. �El resultado es el
% esperado?
demod_mat = amdemod (mod_mat , 10*fo, fs);
if (doPlot==1)
%freq_analysis(signal,fs,signal_title,fa,fb, pl,k)
num_per = 5;
k = num_per*(1/fo);
freq_analysis(signal,fs,[signal_title ' wave'],0,round(5*fo),1,k);
freq_analysis(mod_mat,fs,[signal_title ' AM modulated wave with ammod()'],0,round(5*10*fo),1,k);
freq_analysis(demod_mat,fs,[signal_title ' Demodulated wave with amdemod()'],0,round(5*fo),1,k);
end
end