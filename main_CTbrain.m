close all
clear
clc
%%
Image = dicomread('CT_brain.dcm');
ImageInfo = dicominfo('CT_brain.dcm');

Image = double(Image);
Image = Image./max(Image(:));

figure
imagesc(Image), colormap gray, axis image
title 'Original image'

[m,n] = size(Image);

%% Initial surface
radius = 280;
xoff = round(n/2);
yoff = round(m/2);
[phi0] = initialization(Image, radius, 'custom', xoff, yoff);

%% Chan-Vese
Iter = 20;
dt = 1;
eps = 0.1;
lambda1 = 120;
lambda2 = 180;

phi = Chan_Vese(phi0, Image, Image, eps, lambda1, lambda2, Iter, dt);

segmented = phi>0;

% I apply Chan-Vese algorithm to segment the brighter areas.
% This is useful to:
% a) segment the glioblastoma
% b) mask the image and apply again Chan-Vese to segment the gray matter

%% a)
figure
imagesc(Image), colormap gray, axis image
title 'Select the glioblastoma'
[x,y] = ginput(1);

L = bwlabel(segmented);
region = L(round(x),round(y));
glioblastoma = (L == region);

% Compute the area of the glioblastoma:
spacing = ImageInfo.PixelSpacing;
area_glioblastoma = sum(sum(glioblastoma))*spacing(1)*spacing(2);
disp(['Area of glioblastoma = ', num2str(area_glioblastoma), ' mm2'])

% Extract the edge of the glioblastoma:
SE = strel('square', 3); % Structural element
ImageD = imdilate(glioblastoma,SE);
glioblastoma_c = ImageD - glioblastoma ;
% glioblastoma_c = edge(glioblastoma, 'Roberts'); % alternative

hold on
contour(glioblastoma_c,'r')
title(['Segmented glioblastoma, area = ', num2str(area_glioblastoma), ' mm^2'])

%% b)
ImageF = Image.*imcomplement(segmented);

figure
imagesc(ImageF), colormap gray, axis image
title 'Masked image'

%% Chan-Vese
Iter = 20;
dt = 1;
eps = 0.3;
lambda1 = 10;
lambda2 = 650;
phi = Chan_Vese(phi0, ImageF, ImageF, eps, lambda1, lambda2, Iter, dt);

gray = phi>0;

gray_O = bwmorph(gray,'open', 10);


L = bwlabel(gray_O);
stats = regionprops(gray_O,'Area');
stats = [stats.Area];
[B,IDX] = sort(stats,'descend'); 
gray_matter = (L == IDX(2)); % the mayor area is the backgroung, the gray matter is the second one

% Compute the area of the gray matter:
area_gray = sum(sum(gray_matter))*spacing(1)*spacing(2);
disp(['Area of gray matter = ', num2str(area_gray), ' mm2'])

% Extract the edge of the gray matter:
gray_c = edge(gray_matter, 'Sobel');

figure
imagesc(Image), colormap gray, axis image
hold on
contour(gray_c,'r')
title(['Segmented gray matter, area = ', num2str(area_gray), ' mm^2'])