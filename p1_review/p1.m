A = 1:0.1:2;
B = sin(1:0.2:3);

%[k,l,m] = foo(A,B);

X = rand(3,3);

[g,h,i] = foo2(X);


% e3


[x,y] = meshgrid(-4:0.1:4);
z = exp(x).*cos(y)+exp(y).*sin(x);
figure(1)

subplot(4,1,1)
mesh(x,y,z);
subplot(4,1,2)
surf(x,y,z);
subplot(4,1,3)
contour(x,y,z);
subplot(4,1,4)
%contour3(x,y,z);
contour3(z,50);
%e4
fs=100;
period=3;
inicio =0;
final = 30;
pulse = foo6(period,inicio,final,fs);
figure(2)
plot (pulse)
xp = linspace(inicio,final,length(pulse));
plot(xp,pulse)

n= 10000;
figure(3)
bins=100;
RB = randi([0 1], 1,n)
NOISE = 0.1*randn(1,n);
ALL= RB+NOISE;
hist(ALL,bins)