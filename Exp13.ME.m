
clc;
clear;
close all;

% Input parameters
fstart = 8;       % GHz
fstop = 12;       % GHz
df = 0.01;        % GHz
Z0 = 50;          % Reference impedance in ohms

f = fstart:df:fstop;

% Simulated two-port network response (example model)
f0 = 10;          % Center frequency in GHz
BW = 1;           % Bandwidth in GHz

S11 = 0.3*(f-f0)./sqrt((f-f0).^2 + BW^2);
S21 = 0.95./sqrt(1 + ((f-f0)/BW).^2);

% Convert to dB
S11dB = 20*log10(max(abs(S11),1e-6));
S21dB = 20*log10(abs(S21));

% Return loss and insertion loss
RL = -S11dB;
IL = -S21dB;

% Find optimum frequency (minimum S11)
[~,idx] = min(abs(S11));
fopt = f(idx);

fprintf('MICROWAVE TWO-PORT NETWORK RESULTS\n');
fprintf('Optimum frequency = %.2f GHz\n',fopt);
fprintf('S11 at optimum frequency = %.2f dB\n',S11dB(idx));
fprintf('S21 at optimum frequency = %.2f dB\n',S21dB(idx));
fprintf('Return loss = %.2f dB\n',RL(idx));
fprintf('Insertion loss = %.2f dB\n',IL(idx));

% Plot S-parameters
figure;
plot(f,S11dB,'r','LineWidth',1.5);
hold on;
plot(f,S21dB,'b','LineWidth',1.5);
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Microwave Two-Port Network S-Parameters');
legend('S11','S21');

% Plot return loss and insertion loss
figure;
plot(f,RL,'r','LineWidth',1.5);
hold on;
plot(f,IL,'b','LineWidth',1.5);
grid on;
xlabel('Frequency (GHz)');
ylabel('Loss (dB)');
title('Return Loss and Insertion Loss');
legend('Return Loss','Insertion Loss');
