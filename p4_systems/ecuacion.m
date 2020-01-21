function[wn,Q,alfa]=ecuacion(r,l,c)
    wn=1/sqrt(l*c); %frecuencia de resonancia
    alfa=r/(2*l);   %factor de amortiguamiento
    Q=wn/(2*alfa);  %factor de calidad
end



