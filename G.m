function f = G(M, ch)
% Gradient module
% f = G(M, ch)
% -> ch = 'c' : centered derivative (default)
% -> ch = '+' : forward derivative
% -> ch = '-' : backward derivative


if nargin<2
    ch = 'c';
end

if ch == '+' || ch == 'c' || ch =='-'
    f = sqrt((D_x(M,ch).^2 + D_y(M,ch).^2));
else
    error('Inputs are not correct.')
end

end