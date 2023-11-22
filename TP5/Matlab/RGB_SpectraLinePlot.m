close all; clc
%% =====================================================================================================
% Parameters to be modified

% Read image
Im = imread('picture 1.jpg');

% Define a region of interest (ROI) over which the data will be averaged
% vertically
y_start = 340; 
y_end   = 380;

% Show ROI (1 = show ROI, 0 = hide ROI)
show_ROI = 1;




% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


%% =====================================================================================================
% Process data

% camera parameters 
PixNrx = 1280;
PixNry = 720;

% convert to RGB signals
I_B = Im(:,:,3);
I_G = Im(:,:,2);
I_R = Im(:,:,1);

% normalization of the intensities by division of their maximum
ROI_Line_B  = I_B(y_start:y_end,1:PixNrx);
N_Avg_Line_B = mean(ROI_Line_B)/max(mean(ROI_Line_B));

ROI_Line_G  = I_G(y_start:y_end,1:PixNrx);
N_Avg_Line_G = mean(ROI_Line_G)/max(mean(ROI_Line_G));

ROI_Line_R  = I_R(y_start:y_end,1:PixNrx);
N_Avg_Line_R = mean(ROI_Line_R)/max(mean(ROI_Line_R));

%% =====================================================================================================
% Plot data

figure('Color','w','Position', [250 250 1051 425])

% plot original image
subplot(1,2,1)
imagesc(Im)
hold on
if show_ROI
    rectangle('Position',[1 y_start PixNrx-1 y_end-y_start],'EdgeColor','r','linewidth',2)
end
xlabel('Position x (pixels)')
ylabel('Position y (pixels)')
title('Image')

%plot the averaged lines all at once 
subplot(1,2,2) 
hold on
plot(N_Avg_Line_B,'b','LineWidth',2);
plot(N_Avg_Line_G,'g','LineWidth',2);
plot(N_Avg_Line_R,'r','LineWidth',2);
xlabel('Position x (pixel)')
ylabel('Signal (counts)')
title('Averaged RGB signals')
xlim([1 PixNrx])
ylim([0 1])


