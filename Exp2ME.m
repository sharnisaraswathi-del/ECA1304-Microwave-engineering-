
clc;
clear;
close all;

f = linspace(1e9, 10e9, 100);
c = 3e8;
Z0 = 50;
ZL = 40;
alpha = 0.02;
L = 0.05;

beta = 2*pi*f/c;
gamma = alpha + 1i*beta;

Zin = ZL .* cosh(gamma*L) + Z0 .* sinh(gamma*L);
Zin = Zin ./ (cosh(gamma*L) + (ZL/Z0).*sinh(gamma*L));

S11 = (Zin - Z0) ./ (Zin + Z0);
S21 = exp(-gamma*L) .* (1 + S11);
S12 = S21;
S22 = S11;

RL = -20*log10(abs(S11));
IL = -20*log10(abs(S21));
Eff = abs(S21).^2 * 100;

figure;
plot(f/1e9, 20*log10(abs(S11)), 'r');
hold on;
plot(f/1e9, 20*log10(abs(S21)), 'b');
plot(f/1e9, 20*log10(abs(S12)), 'g');
plot(f/1e9, 20*log10(abs(S22)), 'k');
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
legend('S11','S21','S12','S22');
title('S-Parameter Analysis');

figure;
plot(f/1e9, RL, 'r', f/1e9, IL, 'b');
grid on;
xlabel('Frequency (GHz)');
ylabel('Loss (dB)');
legend('Return Loss','Insertion Loss');
title('Transmission Line Performance');

figure;
plot(f/1e9, Eff);
grid on;
xlabel('Frequency (GHz)');
ylabel('Efficiency (%)');
title('Transmission Efficiency');

disp('Simulation completed');
disp(['Return Loss at 1 GHz = ', num2str(RL(1)), ' dB']);
disp(['Insertion Loss at 1 GHz = ', num2str(IL(1)), ' dB']);
disp(['Efficiency at 1 GHz = ', num2str(Eff(1)), ' %']);
