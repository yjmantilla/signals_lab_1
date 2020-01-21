a = -10;
b = 10;
nPoints=1000;
fs = b-a/1000;
t = linspace(a,b,nPoints);
pulse = zeros(1,length(t));
on_a = 500;
on_b = 550;
pulse(on_a:on_b) = 1;
figure(1)
plot(t,pulse);

echo = 0.5 * pulse;
displacement = 200;
echo = circshift(echo,displacement);
figure(2)
plot(t,echo);

%out = awgn(echo,15,'measured');
randn(
plot(t,out);
