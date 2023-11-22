close all; clc
%% =====================================================================================================
% Parameters to be modified


% input image
I_1 = imread('4.4 Fraunhofer diffraction_01.jpg');

% define a region of interest (ROI)
y_center = 360; % center of the ROI along y
ROI_y = 50;     % dimension of the ROI



% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



%% =====================================================================================================

%Parameters camera
PixNrx          =   1280;
PixNry          =   720;

 % select a channel (here red)
Red_1 = I_1(:,:,1);
 
% format conversion
Red_1 = double(Red_1);
  
% select a line of interest 
CenterLine = Red_1(y_center:y_center,1:PixNrx);
 
%average over several lines 
ROI_Red_1  = Red_1((y_center-ROI_y):(y_center+ROI_y),1:PixNrx);
 
%caculate the mean of the RIO over several rows
N_Avg_Red_1 = mean(ROI_Red_1);
position = (1:PixNrx)*3e-6;
 
%plot the averaged line
figure('Color','w','Position', [114 509 1687 429])
subplot(1,3,1)
imagesc(Red_1)
rectangle('Position',[1 y_center-ROI_y PixNrx 2*ROI_y],'EdgeColor','b','LineWidth',2)
colormap hot
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
title('Image data')
axis tight

subplot(1,3,2)
plot(CenterLine,'b','LineWidth',1.5)
xlabel('Position (m)')
ylabel('Intensity')
title(['Data at y = ' num2str(y_center)])
axis tight
ylim([0 255])
 
subplot(1,3,3)
plot(position,N_Avg_Red_1,'b','LineWidth',1.5)
xlabel('Position (m)')
ylabel('Intensity')
title('Averaged data over the ROI')
axis tight
ylim([0 255])


 
