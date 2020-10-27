% Demonstrating how cross-correlation can be used to find lag:
% % f_s (sampling freq.) = 4kHz
fs = 4000;

% Generating two input signals, y is delayed (shifted by 2)
n = 0:15;
x = 0.8.^n;
y = circshift(x,2);

% Plotting input signals
subplot(2,1,1);
stem(n,x);
hold on;
stem(n,y);
hold off;
title("Input signals")
xlabel("Time [n]")
ylabel("Amplitude")

% Plotting cross-correlation
subplot(2,1,2);
[r_xy, l] = xcorr(x,y);
stem(l, r_xy);
title("Cross-correlation")
xlabel("l")
ylabel("r_{xy}")

% Finding maximum r_xy and corresponding l
max_rxy = max(abs(r_xy));
lag_find = find(r_xy == max_rxy);
l_corr = l(lag_find);
time_shift = 1000*l_corr / fs;
fprintf("Time shift (lag) at fs = %i is %i ms.", fs, abs(time_shift));
