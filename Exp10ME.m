
clc;
clear;
close all;

% Antenna parameters
c = 3e8;
f0 = 2.4e9;
er = 4.4;
h = 1.6e-3;
W = 37.2e-3;

% Effective dielectric constant
eeff = (er+1)/2 + (er-1)/2*(1+12*h/W)^(-0.5);

% Fringing length
dL = 0.412*h*((eeff+0.3)*(W/h+0.264))/...
    ((eeff-0.258)*(W/h+0.8));

% Theoretical patch length
Leff = c/(2*f0*sqrt(eeff));
Ltheory = Leff-2*dL;

fprintf('THEORETICAL ANTENNA DESIGN\n');
fprintf('Effective dielectric constant = %.3f\n',eeff);
fprintf('Theoretical patch length = %.2f mm\n',Ltheory*1000);

% Frequency sweep
f = linspace(2.0e9,2.8e9,801);
lengths = [27.8 28.8 29.8];

figure;
hold on;
colors = {'r','b','g'};

for k = 1:length(lengths)

    L = lengths(k)*1e-3;

    % Approximate resonant frequency
    fr = c/(2*(L+2*dL)*sqrt(eeff));

    % Approximate S11 response
    Q = 30;
    x = 2*Q*(f-fr)/fr;
    S11 = abs(x)./sqrt(4+x.^2);

    S11dB = 20*log10(max(S11,1e-6));

    % Find resonance
    [~,idx] = min(S11dB);
    fres = f(idx);

    % Bandwidth for S11 <= -10 dB
    indices = find(S11dB <= -10);

    if ~isempty(indices)
        BW = (f(indices(end))-f(indices(1)))/1e6;
    else
        BW = 0;
    end

    Gamma = 10^(S11dB(idx)/20);
    VSWR = (1+Gamma)/(1-Gamma);

    deviation = abs(fres-f0)/f0*100;

    fprintf('\nPatch length = %.1f mm\n',lengths(k));
    fprintf('Resonant frequency = %.3f GHz\n',fres/1e9);
    fprintf('Minimum S11 = %.2f dB\n',S11dB(idx));
    fprintf('VSWR = %.2f\n',VSWR);
    fprintf('Bandwidth = %.2f MHz\n',BW);
    fprintf('Frequency deviation = %.2f %%\n',deviation);

    plot(f/1e9,S11dB,colors{k},'LineWidth',1.5);
end

grid on;
xlabel('Frequency (GHz)');
ylabel('S11 (dB)');
title('Microstrip Patch Antenna Optimization');
legend('L = 27.8 mm','L = 28.8 mm','L = 29.8 mm');
ylim([-40 0]);

% Approximate radiation performance
gain = 6;          % Assumed gain in dBi
efficiency = 70;   % Assumed efficiency in percent

fprintf('\nASSUMED RADIATION PERFORMANCE\n');
fprintf('Gain = %.1f dBi\n',gain);
fprintf('Radiation efficiency = %.1f %%\n',efficiency);
