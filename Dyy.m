function f = Dyy(Mat)

% f = Dyy(Mat)
%
% Compute the decond derivative along y (ordinates)
%
% Input:
% Mat : The array to derive
 
[m n] = size(Mat);

if nargin == 1
    f = (Mat([2:m m],1:n) - 2.* Mat + Mat([1 1:m-1],1:n));
else error('Usage: f = Dyy(Mat');
end