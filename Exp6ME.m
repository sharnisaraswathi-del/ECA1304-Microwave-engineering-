
clc;
clear;
close all;

% Input parameters
fRF = 10;          % RF frequency in GHz
fLO = 9.5;         % LO frequency in GHz
PRF = -10;         % RF power in dBm
PLO = 7;           % LO power in dBm
CL_expected = 8;   % Assumed conversion loss in dB

% Frequency conversion
fIF = abs(fRF - fLO);
fSUM = fRF + fLO;

% Simple assumed mixer model
PIF = PRF - CL_expected;
CL = PRF - PIF;

% Theoretical frequencies
fIF_theory = 0.5;
fSUM_theory = 19.5;

% Percentage deviation
devIF = abs(fIF - fIF_theory)/fIF_theory * 100;
devSUM = abs(fSUM - fSUM_theory)/fSUM_theory * 100;

% Display results
disp('MICROWAVE MIXER SIMULATION');
fprintf('IF Frequency = %.2f GHz\n', fIF);
fprintf('Sum Frequency = %.2f GHz\n', fSUM);
fprintf('RF Input Power = %.2f dBm\n', PRF);
fprintf('LO Power = %.2f dBm\n', PLO);
fprintf('IF Output Power = %.2f dBm\n', PIF);
fprintf('Conversion Loss = %.2f dB\n', CL);
fprintf('IF Frequency Deviation = %.2f %%\n', devIF);
fprintf('Sum Frequency Deviation = %.2f %%\n', devSUM);

% Simulated output spectrum
freq = [fIF fRF fLO fSUM];
power = [PIF PRF PLO PIF-10];

figure;
stem(freq, power, 'filled');
grid on;
xlabel('Frequency (GHz)');
ylabel('Power (dBm)');
title('Microwave Mixer Output Spectrum');
legend('Frequency Components');
