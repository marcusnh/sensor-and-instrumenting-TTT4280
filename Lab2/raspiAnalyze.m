% This script will import the binary data from files written by the C
% program on Raspberry Pi.
%
% The script uses the function raspiImport to do the actual import and
% conversion from binary data to numerical values. Make sure you have
% downloaded it as well.
%
% After the import function is finished, the data are written to the
% variable rawData. The number of samples is returned in a variable samples

% Definitions
channels = 5;   % Number of ADC channels used

% Open, import and close binary data file produced by Raspberry Pi
%% FIXME: Change this.
path = 'k3.bin';

% Run function to import all data from the binary file. If you change the
% name or want to read more files, you must change the function
% accordingly.
[rawData, nomTp] = raspiImport(path,channels);

% Plot all raw data and corresponding amplitude response
fh_raw = figure;    % fig handle
subplot(1, 2, 1);
plot(rawData(:,1:3),'-o');
ylim([0, 4095]) % 12 bit ADC gives values in range [0, 4095]
xlabel('sample');
ylabel('conversion value');
legendStr = cell(1,channels);
for i = 1:channels
    legendStr{1,i} = ['ch. ' num2str(i)];
end
legend(legendStr,'location','best');
title('Raw ADC data');

% Compute FFT and plot frequency spectrum of signal
% Sampling frequency is 31250 Hz
Fs = 31250;

rawData = rawData - mean(rawData); % fjerner DC component
%inter_rawData = interp1((0:Fs - 1),rawData,(0:1/5:Fs - 1)); % interpolasjon
%bandpass_data = bandpass(rawData(:,1:3), [1960, 2040], Fs); % båndpassfiltrerer
freq_data = fftshift(fft(rawData(:,1:3), Fs)); % fft
f = (-Fs/2:Fs/2-1);
disp(length(freq_data))
disp(length(f))
subplot(1,2,2);
plot(f,abs(log(freq_data)));
xlabel("Frequency")
ylabel("Amplitude")


