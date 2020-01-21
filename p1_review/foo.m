function [k,l,m] = foo(a,b)
    k = a./b;
    l = a.*a + b.*b; % no puede ser la otra ya que no es cuadrada
    m = dot(a,b).*dot(a,b);
end