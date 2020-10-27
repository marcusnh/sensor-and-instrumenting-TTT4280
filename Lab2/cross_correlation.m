function [time_delay] = time_delay(signal_1, signal_2)

% This function computes the cross_correlation of two signals.
% The cross correlation is plotted for verification.

[r_xy, l] = xcorr(signal_1, signal_2);
