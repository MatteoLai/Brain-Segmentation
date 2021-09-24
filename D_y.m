function f = D_y(A, varargin)
% Derivative along y (ordinates)
% 
% f = D_y(A,'c') return the centered derivative (default)
% f = D_y(A,'+') return the forward derivative
% f = D_y(A,'-') return the backward derivative


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
    error('The input number is not correct')
end


switch method
    case '+' % Forward derivative
        f = A([2:m m], 1:n) - A;
    case '-' % Backward derivative
        f = A - A([1 1:m-1],1:n);
    case 'c' % Centered derivative
        f = (A([2:m m], 1:n) - A([1 1:m-1], 1:n))./2;
end
end