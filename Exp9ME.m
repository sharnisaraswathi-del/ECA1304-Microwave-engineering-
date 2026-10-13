
clc;
clear;
close all;

% Input parameters
Z0 = 50;
ZL = 75 + 1i*25;
f0 = 10e9;
f = linspace(8e9,12e9,501);

% Impedance matching calculations before matching
GammaL = (ZL-Z0)/(ZL+Z0);
Gmag = abs(GammaL);
RL_before = -20*log10(Gmag);
VSWR = (1+Gmag)/(1-Gmag);

% Ideal matching at 10 GHz
RL_after = 30;
Gamma_after = 10^(-RL_after/20);

% Simple first-order low-pass filter response
fc = 10e9;
S21 = 1./sqrt(1 + (f/fc).^2);
S11 = sqrt(1 - abs(S21).^2);

IL = -20*log10(abs(S21));
RL_filter = -20*log10(abs(S11));

% Display results
fprintf('IMPEDANCE MATCHING RESULTS\n');
fprintf('Reflection coefficient = %.4f\n',Gmag);
fprintf('Return loss before matching = %.2f dB\n',RL_before);
fprintf('VSWR before matching = %.2f\n',VSWR);
fprintf('Ideal return loss after matching = %.2f dB\n',RL_after);
fprintf('Ideal reflection coefficient after matching = %.4f\n',Gamma_after);

fprintf('\nFILTER RESULTS\n');
fprintf('Designed cutoff frequency = %.2f GHz\n',fc/1e9);

% Impedance matching graph
figure;
plot(f/1e9, Gmag*ones(size(f)),'r','LineWidth',2);
hold on;
plot(f/1e9, Gamma_after*ones(size(f)),'b--','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('|S11|');
title('Impedance Matching Response');
legend('Before Matching','Ideal Matched Response');

% Filter S-parameter graph
figure;
plot(f/1e9,20*log10(abs(S11)),'r','LineWidth',2);
hold on;
plot(f/1e9,20*log10(abs(S21)),'b','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Microwave Filter Response');
legend('S11','S21');

% Insertion loss graph
figure;
plot(f/1e9,IL,'k','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('Insertion Loss (dB)');
title('Filter Insertion Loss');
