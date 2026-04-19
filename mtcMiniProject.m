clc;
clear;
close all;

%% PARAMETERS
fs = 1000;              % Sampling frequency
t = 0:1/fs:1;          % Time vector
f = 5;                  % Signal frequency

%% ORIGINAL SIGNAL
signal = sin(2*pi*f*t);

%% GAUSSIAN NOISE (Normal Distribution)
mu = 0;                 % Mean
sigma = 0.5;            % Standard deviation

gaussian_noise = sigma * randn(size(signal)) + mu;
signal_gaussian = signal + gaussian_noise;

%% POISSON NOISE
lambda = 5;             % Rate parameter

poisson_noise = poissrnd(lambda, size(signal));
poisson_noise = poisson_noise - mean(poisson_noise); % center it
signal_poisson = signal + poisson_noise;

%% SNR CALCULATION
snr_gaussian = snr(signal, gaussian_noise);
snr_poisson = snr(signal, poisson_noise);

fprintf('SNR (Gaussian Noise): %.2f dB\n', snr_gaussian);
fprintf('SNR (Poisson Noise): %.2f dB\n', snr_poisson);

%% PLOTS

figure;

% Original Signal
subplot(4,1,1);
plot(t, signal);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');

% Gaussian Noise Signal
subplot(4,1,2);
plot(t, signal_gaussian);
title('Signal with Gaussian Noise');
xlabel('Time');
ylabel('Amplitude');

% Poisson Noise Signal
subplot(4,1,3);
plot(t, signal_poisson);
title('Signal with Poisson Noise');
xlabel('Time');
ylabel('Amplitude');

% Histogram Comparison
subplot(4,1,4);
histogram(gaussian_noise, 'Normalization', 'pdf');
hold on;
histogram(poisson_noise, 'Normalization', 'pdf');
legend('Gaussian Noise', 'Poisson Noise');
title('Noise Distribution Comparison');