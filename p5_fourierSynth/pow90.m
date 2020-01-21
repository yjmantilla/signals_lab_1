    function [total_power,neededHarmonics,bandwidth] = pow90(pow_coeffs,freqs)
    total_power = sum(pow_coeffs); % pow coefficients are already halved
    partial_pow = 0;
    i = 1;
    neededHarmonics = 0;
    while partial_pow < 0.9*total_power
        
        neededHarmonics = i;
        partial_pow = partial_pow + pow_coeffs(i); %NO DC so we can double it without worry
        % bn is single sided spectrum so we dont have to double the
        % contributions, rather we have to halve them
        % but that is already implemented in fourierFun so no need.
        % check parseval for trigonometric series
        i = i+1;
    end
    
     bandwidth = freqs(neededHarmonics);
     total_power = 10 * log10(total_power/(1E-3));
end