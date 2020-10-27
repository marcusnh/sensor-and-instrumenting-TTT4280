path = '1.bin';
channels = 5;
[rawData, nomTp] = raspiImport(path,channels);

fs=31250;
fBP=[1700,2300];
int_factor=16;
 
sound1=bandpass(rawData(:,1),fBP,fs);
sound2=bandpass(rawData(:,2),fBP,fs);
sound3=bandpass(rawData(:,3),fBP,fs);

n=numel(sound3);
n1 = ceil(n*(1/10));
n2 = ceil(n*(9/10));
sound1= sound1(n1:n2);
sound2= sound2(n1:n2);
sound3= sound3(n1:n2);

int_sound1 = bandpass(interp(sound1, int_factor),fpass,fs*int_factor);
int_sound2 = bandpass(interp(sound2, int_factor),fpass,fs*int_factor);
int_sound3 = bandpass(interp(sound3, int_factor),fpass,fs*int_factor);

[r21,lags21] = xcorr(int_sound2, int_sound1);
[r31,lags31] = xcorr(int_sound3, int_sound1);
[r32,lags32] = xcorr(int_sound3, int_sound2);
