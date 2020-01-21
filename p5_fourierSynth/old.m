%Diente de sierra
syms t n
bn_sawtooth = (2/To)*(int(App*t*sin(wo*n*t)/To,t,[-To/2 To/2]));

sawtooth = 0;
coeff_sawtooth = [];
fHarm_sawtooth = [];
pow_sawtooth = [];
 for i = 1:N
     n = i; % for eval
     coeff_sawtooth(i) = eval(bn_sawtooth);
     pow_sawtooth(i) = (coeff_sawtooth(i))^2;
     fHarm_sawtooth(i) = i*wo/(2*pi);
     sawtooth = sawtooth + coeff_sawtooth(i)*sin(i*wo*tvec);   
 end
 
c_saw = coeff_sawtooth;
f_saw = fHarm_sawtooth;
p_saw = pow_sawtooth;

figure()
plot(tvec,sawtooth)
title(['Sawtooth of ', num2str(Fo), 'Hz'])
xlabel(['time [sec]'])

figure()
stem(f_saw(1:10),p_saw(1:10))
title(['Power of Sawtooth of ', num2str(Fo), 'Hz'])
xlabel(['frequency [Hz]'])

% Triangular

syms t n
bn_triangle = (2/To)*(int((0 + 2*App*t/To)*sin(wo*n*t),t,[-To/4 To/4])+ int((App - 2*App*t/To)*sin(wo*n*t),t,[To/4 3*To/4]));
coeff_triangle = [];
fHarm_triangle = [];
pow_triangle = [];
triangle = 0;
 for i = 1:N
     n = i; % for eval
     coeff_triangle(i) = eval(bn_triangle);
     pow_triangle(i) = (coeff_triangle(i))^2;
     fHarm_triangle(i) = i*wo/(2*pi);
     triangle = triangle + coeff_triangle(i)*sin(i*wo*tvec);   
 end 

c_tri = coeff_triangle;
f_tri = fHarm_triangle;
p_tri = pow_triangle;

figure()
plot(tvec,triangle)
title(['Triangle of ', num2str(Fo), 'Hz'])
xlabel(['time [sec]'])

figure()
stem(f_tri(1:10),p_tri(1:10))
title(['Power of Triangle of ', num2str(Fo), 'Hz'])
xlabel(['frequency [Hz]'])