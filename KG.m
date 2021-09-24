function f = KG(M, ch)
% Gradient module- curvature product
%
% f = KG(M, ch)
% -> ch = 'c' : centered derivative (default)
% -> ch = '+' : forward derivative
% -> ch = '-' : backward derivative


if nargin<2
    ch = 'c';
end

if ch == '+' || ch == 'c' || ch =='-'
    f = (Dxx(M).*(D_y(M, ch).^2) - 2.*D_y(M,ch).*D_x(M, ch).*D_x(D_y(M, ch),ch)...
        + Dyy(M).*(D_x(M,ch).^2))./((D_x(M,ch).^2 + D_y(M,ch).^2) + 1e-6);
else
    error('Inputs are not correct.')
end
end

