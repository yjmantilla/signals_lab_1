    function [total_power,neededHarmonics,bandwidth] = pow290(pow_coeffs,freqs)
    N = round(length(pow_coeffs)/2);
    total_power = sum(pow_coeffs); % no need to double because the sum is bilateral
    partial_pow = 0;
    i = 1;
    neededHarmonics = 0;
    while partial_pow < 0.9*total_power
        
        neededHarmonics = i;
        partial_pow = partial_pow + 2*pow_coeffs(N+i); %NO DC so we can double it without worry
        % cn is double sided spectrum so we have to double the
        % contributions
        i = i+1;
    end
    
     bandwidth = freqs(N+neededHarmonics);
     total_power = 10 * log10(total_power/(1E-3));
end