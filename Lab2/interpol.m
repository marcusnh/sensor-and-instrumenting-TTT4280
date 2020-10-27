function [interpolated_signal] = interpol(input_signal, Fs)

% This function utilises linear interpolation on an input_signal.
interpolated_signal = interp1((0:Fs - 1),input_signal,(0:1/10:Fs - 1));