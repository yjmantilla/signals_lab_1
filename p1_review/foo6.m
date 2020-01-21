function [pulse] = foo6(period,a,b,fs)
    y1 = linspace(1,1,fs*period/(2));
    y0 = linspace(0,0,fs*period/(2));
    %x = linspace(0,period/fs,period/fs);
    %pulse1 = [y1,y0];
    pulse1 = horzcat(y1,y0);
    pulse = [];
    for i = a:period:b-1
        pulse = horzcat(pulse,pulse1);
    end
end

%only works with period and 