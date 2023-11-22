close all; clc
%% =====================================================================================================
% Parameters to be modified

% Read image 
Im = imread('picture 1.jpg'); 

% Define a square region of interest (ROI) with the center of distortion in the middle
center_point_x = 640; % x-coordinate of the image center
center_point_y = 360; % y-coordinate of the image center
image_size = 500;     % number of pixels in the ROI

% Try varying the amplitude of the cubic term. This "a" value has to be
% noted in the report. Please give a two number precission. The sign is
% important.
a = -1e-7; 

% Show ROI (1 = show ROI, 0 = hide ROI)
show_ROI = 1;




% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX




%% =====================================================================================================
% Process images

% Note: Maximum "image_size" is given by distance center to border 

I  = Im(floor(center_point_y-(image_size/2)):floor(center_point_y+(image_size/2)),floor(center_point_x-(image_size/2)):floor(center_point_x+(image_size/2)));

% In what follows the radial distortion is corrected via transformation in
% radial coordinates - multiplication - back transformation

imid= round(size(I,2)/2); % Find index of middle element
[nrows,ncols] = size(I);
[xi,yi] = meshgrid(1:ncols,1:nrows);

xt = xi(:) - imid;
yt = yi(:) - imid;
%transformation in polar coordinates
[theta,r] = cart2pol(xt,yt);

%Transformation (stretching) of the polar coordinate image - quadratic coorection 
s = r + a*r.^3;

% back transformation polar - cartesian, resampling
[ut,vt] = pol2cart(theta,s);
u = reshape(ut,size(xi)) + imid;
v = reshape(vt,size(yi)) + imid;

tmap_B = cat(3,u,v);
resamp = makeresampler('linear','fill');

I_distortion_corrected = tformarray(I,[],resamp,[2 1],[1 2],[],tmap_B,.3);

%% Plot data

figure('color','w','Position',[100 250 1330 350])

% Plot of original image
subplot(1,3,1)
imagesc(Im)
hold on
if show_ROI
    rectangle('Position',[floor(center_point_x-(image_size/2)) floor(center_point_y-(image_size/2)) image_size image_size],'EdgeColor','r','linewidth',2)
end
title('Original image with distortion')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
axis image

% Plot the region of interest
subplot(1,3,2)
imshow(I)
title('Region of interest with distorsion')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
axis square

% Plot of corrected image
subplot(1,3,3)
imshow(I_distortion_corrected)
title('Region of interest with corrected distortion')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
axis square
