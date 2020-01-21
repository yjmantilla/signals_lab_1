function [T,SQ,S] = foo2(X)
    T = X'*inv(X);
    SQ = sqrt(det(X));
    S = sum(X);
end