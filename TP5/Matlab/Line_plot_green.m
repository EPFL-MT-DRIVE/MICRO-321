close all; clc
%% =====================================================================================================
% Parameters to be modified

% Read image 
Im = imread('picture 1.jpg');

% Define the y-coordinate of a line of interest (LOI)
line_y = 360;

% Show LOI (1 = show LOI, 0 = hide LOI)
show_LOI = 1;




% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


%% =====================================================================================================
% process data

% camera parameters 
PixNrx = 1280;
PixNry = 720;

% select the green channel
Green_1 = Im(:,:,2);

% format conversion
Green_1 = double(Green_1);

% select a line of interest ROI (1 x PixNrx), center of peak, 
Line = Green_1(line_y,1:PixNrx);

%% =====================================================================================================
% Plot data

figure('Color','w','Position', [250 250 1051 425])

% visiualize the image 
subplot(1,2,1)
imagesc(Green_1) 
hold on
if show_LOI
    plot([1 PixNrx],[line_y line_y],'r','LineWidth',2)
end
colormap gray
title('Image')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
 
% plot a single line
subplot(1,2,2)
plot(Line,'k','LineWidth',2)
xlabel('Position x (pixel)')
ylabel('Signal (counts)')
title(['Raw signal at y = ' num2str(line_y)])
xlim([1 PixNrx])
ylim([0 255])
 




