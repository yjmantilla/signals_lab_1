clear all
close all

fs_factor = 10;
number_of_periods = 1000; % to generate data
graph_periods = 3; % to actually see in the graphs

%% Sinusoid
fo = 200;
To = 1/fo;

fc = 10 *fo;
Tc = 1/fc;

t_a = 0;
t_b = number_of_periods*To;
fs = fs_factor*fc;
t = t_a: 1/fs:t_b;

wave1 = sin(2*pi*fo*t);
carrier1 = sin(2*pi*fc*t);
fa = [0;1500;1500;1500];
fb = [1000;2500;2500;2500];

%% Puntos 1 al 6 resumidos en la funcion modul
[wave1_x_sc,wave1_x_gp]=modul(t,fs,To,graph_periods,wave1,carrier1,fa,fb,'a','Sinusoid');

%% Rectangular Pulse
fo = 200;
To = 1/fo;

fc = 10 *fo;
Tc = 1/fc;

t_a = 0;
t_b = number_of_periods*To;
fs = fs_factor*fc;
t = t_a: 1/fs:t_b;

duty = 0.5;
w = duty/fo; % 0.1s pulse width
repfreq = fo;
d = t_a:1/repfreq:t_b;
x = @rectpuls;
wave2 = pulstran(t,d,x,w);

fc = 10 *fo;
Tc = 1/fc;
fa = [0;1000;1000;1000];
fb = [1000;3000;3000;3000];
carrier2 = sin(2*pi*fc*t);

%% Punto 7 resumido en la funcion modul
[wave2_x_sc,wave2_x_gp]=modul(t,fs,To,graph_periods,wave2,carrier2,fa,fb,'a','Rect Pulse');

%% Punto 8 y 9, modulacion y demodulacion usando funciones de matlab
% Wave 1 (Sinusoid)
[mod_wave1_mat,demod_wave1_mat] = matlabMod(wave1,fs,fo,'Sinusoid',1);

% Wave 2 (Rectangular Pulse)
[mod_wave2_mat,demod_wave2_mat] = matlabMod(wave2,fs,fo,'Rect Pulse',1);

%% Bonificacion ( Demodulacion sin usar la funcion de matlab)
% El proceso de demodulacion queda resumido en la funcion ourDemod

% Wave 1 (Sinusoid)
[demod_wave1,demod_wave1_filtered]= ourDemod(wave1_x_sc,carrier1,t,fs,To,'Sinusoid',300,1);
% Wave 2 (Rectangular Pulse)
[demod_wave2,demod_wave2_filtered]= ourDemod(wave2_x_sc,carrier1,t,fs,To,'Rect Pulse',1500,1);
