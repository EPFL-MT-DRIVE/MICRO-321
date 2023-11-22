close all; clc
%% =====================================================================================================
% Parameters to be modified


% input image
I_1 = imread('4.4 Fraunhofer diffraction_01.jpg');

% measurement parameters
w = 100e-6;    % slit width (m) 
z = 0.093;     % propagation distance (m)

% define a region of interest (ROI)
y_center = 360; % center of the ROI along y
ROI_y = 50;     % dimension of the ROI

% shifts the position of the blue curve to align it with the red curve in
% the second plot
x_shift = 0; 




% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



%% =====================================================================================================

%Parameters camera
PixNrx          =   1280;
PixNry          =   720;

L = 3888e-6; % Camera sensor side length (m)
M   = 200;       % number of samples used for calculation 

lam = 0.635e-6;%wavelength 

dx = L/M;       % sample interval (m), corresponding sampling in space 
x  = -L/2:dx:L/2-dx; % coordinate vector, corresponding x 

%%  Compute diffraction pattern
f = rect(x/(2*w)); %signal vector, amplitude vector at the entrance 

% calculat FFT, shift the result to the center of the axis and scale it
F0 = fftshift(fft(f))*dx; %FFT and scale 

% All calculations were done on a sampled signal, one needs to find the 
% correct axis in space, the frequecy coordinates will be established now 
fx = -1/(2*dx):1/L:1/(2*dx)-(1/L); %freq cords 

% compute position
position_sim = fx*lam*z;

%% Process iamge data
% select a channel (here red)
Red_1 = I_1(:,:,1);
 
% format conversion
Red_1 = double(Red_1);
 
% average over several lines  
ROI_Red_1  = Red_1((y_center-ROI_y):(y_center+ROI_y),:);
N_Avg_Red_1 = mean(ROI_Red_1);
position = (-PixNrx/2:PixNrx/2-1)*3e-6;
 
%visiualize the image to define region of interest
figure('Color','w','Position', [680 468 1084 410])
subplot(1,2,1)
hold on
imagesc(Red_1)
rectangle('Position',[1 y_center-ROI_y PixNrx 2*ROI_y],'EdgeColor','b','LineWidth',2)
colormap hot
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
title('Image data')
axis tight

%plot the averaged line
subplot(1,2,2)
hold on
plot(position+x_shift,N_Avg_Red_1/max(N_Avg_Red_1),'b-','LineWidth',3)
plot(position_sim,(abs(F0)/max(abs(F0))).^2,'r-','LineWidth',3);
xlabel('position (m)')
ylabel('normalized intensity')
title('Comparison between data and simulation')


function[out]=rect(x)
% rectangle function

out=abs(x)<=1/2;
end

