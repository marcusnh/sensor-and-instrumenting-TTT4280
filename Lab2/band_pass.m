function [filtered_signal] = band_pass(input_signal, Fs)

% This function uses a bandpass to filter the signals before
% crosscorrelation
filtered_signal = bandpass(input_signal, [1900, 2100], Fs);