
clc;
clear;
close all;

% Input parameters
fc = 10e9;       % Carrier frequency = 10 GHz
A = 1;           % Carrier amplitude = 1 V
fm = 0.1e9;      % Modulating frequency = 0.1 GHz
mu = 0.5;        % Modulation index
fs = 50e9;       % Sampling frequency = 50 GHz

% Generate signal
T = 20e-9;
t = 0:1/fs:T-1/fs;
x = A*(1 + mu*cos(2*pi*fm*t)).*cos(2*pi*fc*t);

% FFT spectrum
N = length(x);
X = abs(fft(x))/N;
X = X(1:N/2+1);
X(2:end-1) = 2*X(2:end-1);
f = (0:N/2)*fs/N;

% Convert amplitude spectrum to dBm (50 ohm)
Vpeak = max(X,1e-12);
P = (Vpeak/sqrt(2)).^2/50;
PdBm = 10*log10(P/1e-3);

% Find carrier and sidebands
[~,ic] = min(abs(f-fc));
[~,il] = min(abs(f-(fc-fm)));
[~,iu] = min(abs(f-(fc+fm)));

Pc = PdBm(ic);
PL = PdBm(il);
PU = PdBm(iu);

% Spurious level relative to carrier
mask = true(size(PdBm));
mask([ic il iu]) = false;
mask(f < 8e9 | f > 12e9) = false;
Pspur = max(PdBm(mask));
spur_dBc = Pspur-Pc;

% Display results
fprintf('MICROWAVE SPECTRUM ANALYSIS\n');
fprintf('Carrier frequency = %.2f GHz\n',f(ic)/1e9);
fprintf('Lower sideband = %.2f GHz\n',f(il)/1e9);
fprintf('Upper sideband = %.2f GHz\n',f(iu)/1e9);
fprintf('Carrier power = %.2f dBm\n',Pc);
fprintf('Lower sideband power = %.2f dBm\n',PL);
fprintf('Upper sideband power = %.2f dBm\n',PU);
fprintf('Spurious level = %.2f dBc\n',spur_dBc);

% Plot spectrum
figure;
plot(f/1e9,PdBm,'b');
grid on;
xlim([8 12]);
ylim([-120 30]);
xlabel('Frequency (GHz)');
ylabel('Power (dBm)');
title('Microwave Signal Spectrum');
hold on;
plot(f(ic)/1e9,Pc,'ro');
plot(f(il)/1e9,PL,'ko');
plot(f(iu)/1e9,PU,'mo');
legend('Spectrum','Carrier','Lower Sideband','Upper Sideband');
