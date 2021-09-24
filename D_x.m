function f = D_x(A, varargin)
% Derivative along x (abscissae)
% 
% f = D_x(A,'c') return the centered derivative (default)
% f = D_x(A,'+') return the forward derivative
% f = D_x(A,'-') return the backward derivative


if length(size(A)) == 3
    A = rgb2gray(A);
end

[m,n] = size(A);

if nargin < 2
    method = 'c';
elseif nargin == 2
    method = varargin{1};
    if method ~= '+' && method ~= '-' && method ~= 'c'
        error('Inputs are not correct')
    end
else
    error('The number of input is not correct')
end


switch method
    case '+' % Forward derivative
        f = A(1:m,[2:n n]) - A;
    case '-' % Backward derivative
        f = A - A(1:m,[1 1:n-1]);
    case 'c' % Centered derivative
        f = (A(1:m,[2:n n]) - A(1:m,[1 1:n-1]))./2; 
end
end

