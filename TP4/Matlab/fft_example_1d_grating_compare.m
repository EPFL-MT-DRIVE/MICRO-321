close all; clc
%% =====================================================================================================
% Parameters to be modified


% input image
I_1 = imread('4.5 Grating diffraction_L20um_w10um_01.jpg');

% definition of center position
x_center = 640;
y_center = 360;

% simulation of the diffraction pattern 
w  = 10e-6;     % rectangle width (m)
p  = 40e-6;     % grating_period (m)


% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



%% =====================================================================================================

%Parameters camera
PixNrx          =   1280;
PixNry          =   720;
L  = 3.888e-3;    % Camera sensor side length (m)

%preparation of Fourier transform
M  = 50001;     % number of samples
dx = L/M;       % sample interval (m)
x  = -L/2:dx:L/2-dx; % coordinate vector

lambda        = 0.635e-6;%wavelength
focal_lengths = 3.6e-3; %focal lengths

dutycyle = w/p*100; %grating width translated in dutycicle 0..100

f  = rect(x/(w)); %original signal vector of the rectangle
F = fftshift(fft(f))*dx;          % FFT and scale
fx = -1/(2*dx):1/L:1/(2*dx)-(1/L);  % freq cords

%preparation of the measured data
Red_1        = I_1(:,:,1);
Red_1        = double(Red_1);
CenterLine_1 = Red_1(y_center,:);
position     = ((1:PixNrx) - x_center)*3e-6;

% get peak position
Fx = lambda/p*focal_lengths;
Npeaks = floor(position(end)/(focal_lengths/p*lambda));
if mod(Npeaks,2)
    Npeaks = (Npeaks - 1)/2;
end
Fx = (-Npeaks : Npeaks)*Fx;


position_sim  = fx*focal_lengths*lambda;


figure('Color','w','Position', [119 514 1760 440])
subplot(1,3,1)
hold on
plot(position_sim, (abs(F)/max(abs(F))).^2,'b-','linewidth',1.5)
for k = 1 : Npeaks*2+1
A = interp1(position_sim,(abs(F)/max(abs(F))).^2,Fx(k));
plot([1 1]*Fx(k), [0 1]*A,'r','linewidth',1.5)
end
title('Grating simulation')
ylabel('Magnitude');
xlabel('position (m)');
axis([-L/4 L/4 0 1])

%visiualize the image to define region of interest
subplot(1,3,2)
hold on
imagesc(flipud(Red_1))
colormap hot
title('Image data')
plot([1 PixNrx],[1 1]*y_center,'r','LineWidth',1.5)
plot([1 1]*x_center,[1 PixNry],'r','LineWidth',1.5)
xlabel('Position x (pixel)')
ylabel('Position y (pixel)')
axis tight

%plot measurement and simulation together
subplot(1,3,3)
hold on
plot(position,CenterLine_1/max(CenterLine_1),'b-','linewidth',2)
for k = 1 : Npeaks*2+1
A = interp1(position_sim,(abs(F)/max(abs(F))).^2,Fx(k));
plot([1 1]*Fx(k), [0 1]*A,'r','linewidth',2)
end
title('Comparison between simulation and data')
xlabel('position (m)')
ylabel('normalized intensity')
axis([-L/4 L/4 0 1])

function[out]=rect(x)
% rectangle function

out=abs(x)<=1/2;
end
