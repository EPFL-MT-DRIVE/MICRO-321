close all; clc
%% =====================================================================================================
% Parameters to be modified


L      = 0.2;       % lateral size of detector (m)
z      = 50;        % propagation distance to detector (m)
w      = 1e-3;      % diameter of the circular aperture (m)
lambda = 635e-9;    % wavelength (m)





% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%                             DO NOT MODIFY THE SCRIPT BEYOND THIS POINT
%
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



%% =====================================================================================================
% Process data

M  = 250;   % # samples
dx = L/M;   % sample interval
w = w/2;    % transform into hafl-width

% generate grid of points
x     = -L/2:dx:L/2-dx; 
y     = x; 
[X,Y] = meshgrid(x,y);

% define parameters 
lz = lambda*z;

% irradiance
I2 = (w^2/lz)^2.*(jinc(w/lz*sqrt(X.^2+Y.^2))).^2;

%% =====================================================================================================
% Plot data

figure('Color','w','Position',[250 250 750 350])

% irradiance image
subplot(1,2,1)
imagesc(x,y,nthroot(I2,2)/max(max(nthroot(I2,2))))
title('Diffraction pattern')
xlabel('x (m)')
ylabel('y (m)')
colormap gray
axis square
axis xy

% x-axis profile
subplot(1,2,2)
plot(x,I2(M/2+1,:)/max(I2(M/2+1,:)),'k','LineWidth',2)
title('Data at y = 0')
xlabel('x(m)')
ylabel('Irradiance')
axis square
axis xy


function[out]=jinc(x)

% jinc function
%
% J1(2*pi*x)/x
% divide by zero fix
%
% locate non-zero elements of x
mask=(x~=0);
% initialize output with pi (value for x=0)
out=pi*ones(size(x));
% compute output values for all other x
out(mask)=besselj(1,2*pi*x(mask))./(x(mask));
end

