function [time_delay,r_xy, l] = time_delay(signal_1, signal_2, fs)

% This function computes the cross_correlation of two signals
% given sampling frequency fs as input.
% The cross correlation is plotted for verification.
% Time delay is then computed.

[r_xy, l] = xcorr(signal_1, signal_2);

[max_rxy, max_ind] = max(abs(r_xy));
l_corr = l(max_ind);
time_delay = l_corr / fs;
% fprintf("Time shift (lag) at fs = %i is %i s.", fs, abs(time_delay));
% disp(time_delay)