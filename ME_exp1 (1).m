clc;
clear;
close all;

% Create rectangular waveguide grid
x = linspace(0,1,50);
y = linspace(0,1,50);
[X,Y] = meshgrid(x,y);

% TEM mode
TEM = ones(50,50);

% TE10 mode
TE = cos(pi*X);

% TM11 mode
TM = sin(pi*X).*sin(pi*Y);

% Plot all modes
figure;

subplot(1,3,1);
imagesc(x,y,TEM);
title('TEM Mode');
xlabel('x');
ylabel('y');
colorbar;

subplot(1,3,2);
imagesc(x,y,TE);
title('TE10 Mode');
xlabel('x');
ylabel('y');
colorbar;

subplot(1,3,3);
imagesc(x,y,TM);
title('TM11 Mode');
xlabel('x');
ylabel('y');
colorbar;

sgtitle('Electromagnetic Propagation Modes');