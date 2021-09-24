function [phi, xoff, yoff] = initialization(Image, radius, mode, varargin)
% [phi, xoff, yoff] = initialization(Image, radius, mode)
%
% This function generate the surface phi=phi(x,y), as start condition for
% Malladi_Sethian and Chan_Vese algorithms.
%
% Input:
% - Image: the original image
% - mode: 'custom' generate a surface with a single circumference at zero level
%         'multi' generate a surface with multiple circumferences at zero level
% - radius: the radius of phi(0,0)
% - [xoff, yoff]: coordinates of the center of phi(x,y), useful if mode='custom'
% Output:
% - phi = phi(x,y)
% - [xoff, yoff]: coordinates of the center of phi(x,y), if mode='custom'

[nx, ny] = size(Image);

figure
imagesc(Image)
title 'Initialize the surface:'
axis image; colormap gray;
hold on

if strcmp(mode,'custom')
    [X,Y] = meshgrid(0:ny-1,0:nx-1);
    if nargin <4
        [xoff, yoff] = ginput(1);
    else
        xoff = varargin{1};
        yoff = varargin{2};
    end
    phi = sqrt((X-xoff).^2+(Y-yoff).^2);
    phi = phi - radius;
    contour(phi,[0,0],'r');
    
elseif strcmp(mode,'multi')
    xoff = [];
    yoff = [];
    [X, Y]=meshgrid(0:ny-1,0:nx-1);
    phi=ones(nx,ny)*10000000;
    for  x=1:50:ny-1
        for y=1:50:nx-1
            Itemp=sqrt((X-x).*(X-x)+(Y-y).*(Y-y));
            phi=(phi>=Itemp).*Itemp+(phi<Itemp).*phi;
        end
    end
    phi = phi-radius;
    contour(phi,[0,0],'r');
    
else
    error('Select a correct initialization modality')
end
end

