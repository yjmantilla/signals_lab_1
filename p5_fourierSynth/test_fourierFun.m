clear all

%test fourierFun

f_factor = 3000; % obtained heuristically
N = 10; % # of harmonics,  nothing at 0 because they are all odd
App_val = 1;
N_show = 10;

%Notation [signal]_property_frequency
%signals : pulse - pulseTrain, saw - sawtooth , tri -  triangle
%properties : b,c,f,f2,p,p2,pdb,pdb2
%frequency: 100k , 1M, 100M 
%For 90% of signal power: total power, num of harmonics needed, bandwidth

% Integrals expressions
syms App To wo w n t pulse_exp saw_exp tri_exp;
pulse_exp = 2/To * ( int(-App/2 * sin(wo*n*t),t,[-To/2 0])+ int(App/2 * sin(wo*n*t),t,[0 To/2]));
saw_exp = (2/To)*(int(App*t*sin(wo*n*t)/To,t,[-To/2 To/2]));
tri_exp = (2/To)*(int((0 + 2*App*t/To)*sin(wo*n*t),t,[-To/4 To/4])+ int((App - 2*App*t/To)*sin(wo*n*t),t,[To/4 3*To/4]));

% Do note that each frequency produces 21 graphs, better to only evaluate
% one frequency at a time

% % a) 100k
% Fa = 100E3;
% 
% [pulse_b_100k,pulse_c_100k,pulse_f_100k,pulse_f2_100k,pulse_p_100k,pulse_p2_100k,pulse_pdb_100k,pulse_pdb2_100k] = fourierFun('Pulse Train',App_val,Fa,f_factor,N,N_show,pulse_exp);
% [pulse_tot_pow_100k, pulse_numH_100k, pulse_bw_100k]= pow90(pulse_p_100k,pulse_f_100k);
% 
% [saw_b_100k,saw_c_100k,saw_f_100k,saw_f2_100k,saw_p_100k,saw_p2_100k,saw_pdb_100k,saw_pdb2_100k] = fourierFun('Sawtooth',App_val,Fa,f_factor,N,N_show,saw_exp);
% [saw_tot_pow_100k, saw_numH_100k, saw_bw_100k]= pow90(saw_p_100k,saw_f_100k);
% 
% [tri_b_100k,tri_c_100k,tri_f_100k,tri_f2_100k,tri_p_100k,tri_p2_100k,tri_pdb_100k,tri_pdb2_100k] = fourierFun('Triangle',App_val,Fa,f_factor,N,N_show,tri_exp);
% [tri_tot_pow_100k, tri_numH_100k, tri_bw_100k]= pow90(tri_p_100k,tri_f_100k);
% 
% % b) 1M
% 
% Fb = 1E6;
% 
% [pulse_b_1M,pulse_c_1M,pulse_f_1M,pulse_f2_1M,pulse_p_1M,pulse_p2_1M,pulse_pdb_1M,pulse_pdb2_1M] = fourierFun('Pulse Train',App_val,Fb,f_factor,N,N_show,pulse_exp);
% [pulse_tot_pow_1M, pulse_numH_1M, pulse_bw_1M]= pow90(pulse_p_1M,pulse_f_1M);
% 
% [saw_b_1M,saw_c_1M,saw_f_1M,saw_f2_1M,saw_p_1M,saw_p2_1M,saw_pdb_1M,saw_pdb2_1M] = fourierFun('Sawtooth',App_val,Fb,f_factor,N,N_show,saw_exp);
% [saw_tot_pow_1M, saw_numH_1M, saw_bw_1M]= pow90(saw_p_1M,saw_f_1M);
% 
% [tri_b_1M,tri_c_1M,tri_f_1M,tri_f2_1M,tri_p_1M,tri_p2_1M,tri_pdb_1M,tri_pdb2_1M] = fourierFun('Triangle',App_val,Fb,f_factor,N,N_show,tri_exp);
% [tri_tot_pow_1M, tri_numH_1M, tri_bw_1M]= pow90(tri_p_1M,tri_f_1M);

% c) 100M

Fc = 100E6;

[pulse_b_100M,pulse_c_100M,pulse_f_100M,pulse_f2_100M,pulse_p_100M,pulse_p2_100M,pulse_pdb_100M,pulse_pdb2_100M] = fourierFun('Pulse Train',App_val,Fc,f_factor,N,N_show,pulse_exp);
[pulse_tot_pow_100M, pulse_numH_100M, pulse_bw_100M]= pow90(pulse_p_100M,pulse_f_100M);

[saw_b_100M,saw_c_100M,saw_f_100M,saw_f2_100M,saw_p_100M,saw_p2_100M,saw_pdb_100M,saw_pdb2_100M] = fourierFun('Sawtooth',App_val,Fc,f_factor,N,N_show,saw_exp);
[saw_tot_pow_100M, saw_numH_100M, saw_bw_100M]= pow90(saw_p_100M,saw_f_100M);

[tri_b_100M,tri_c_100M,tri_f_100M,tri_f2_100M,tri_p_100M,tri_p2_100M,tri_pdb_100M,tri_pdb2_100M] = fourierFun('Triangle',App_val,Fc,f_factor,N,N_show,tri_exp);
[tri_tot_pow_100M, tri_numH_100M, tri_bw_100M]= pow90(tri_p_100M,tri_f_100M);