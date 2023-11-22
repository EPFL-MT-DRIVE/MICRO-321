close all; clc
%% =====================================================================================================
% Parameters to be modified

% Read image 
Im = imread('Picture 28.jpg');

% Define a region of interest (ROI) over which the data will be averaged vertically
y_start = 300; 
y_end   = 420;

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

% select a channel 
Red_1 = Im(:,:,1);

% format conversion
Red_1 = double(Red_1);

% define ROI parameters
size_ave = y_end - y_start;
CL = y_start+floor(size_ave/2);

% select a line of interest ROI (1 x PixNrx), here center line
CenterLine_Red = Red_1(CL,:);  

% average over several lines (vertical)
ROI_Red_1  = Red_1(y_start:y_end,:);

%caculate the mean of the RIO obver several rows
N_Avg_Red_1 = mean (ROI_Red_1);

%% =====================================================================================================
% Plot data

figure('color','w','Position', [160 65 1000 680])

% plot the channel
subplot(2,2,1)
imagesc(Im)
hold on
if show_ROI
    rectangle('Position',[1 y_start PixNrx-1 size_ave],'EdgeColor','b','linewidth',2)
end
title('Original image')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')

% plot a single line
subplot(2,2,2)
plot(CenterLine_Red,'k','LineWidth',2)
title(['Raw signal at y = ' num2str(CL) ' (middle of ROI)'])
xlabel('Position x (pixel)')
ylabel('Signal (counts)')
axis([1 PixNrx 0 255])

% Surface plot
subplot(2,2,3)
Red_1_smooth = conv2(Red_1, ones(50)/50.^2, 'same');
surf(Red_1_smooth, 'EdgeColor', 'none')
title('Averaged surface plot')
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
zlabel('Signal (counts)')
xlim([1 PixNrx])
ylim([1 PixNry])

% plot the averaged line
subplot(2,2,4)
plot(N_Avg_Red_1,'k','LineWidth',2);
title('Averaged signal');
xlabel('Position x (pixel)')
ylabel('signal (counts)')
axis([1 PixNrx 0 255])
