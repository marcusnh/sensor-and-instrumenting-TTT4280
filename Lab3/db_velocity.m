path = 'k3.bin';
[rawData, nomTp] = raspiImport(path,channels);

c=3*10^(8);
Fs=31250;

Ii=rawData(:,4:4);
Iq=rawData(:,5:5);

%remove DC-component

Ii=Ii-mean(Ii);
Iq=Iq-mean(Iq);

%complex version:

img=Ii+1i*Iq;
img_fft=fftshift(fft(img));

% make plot:
f = (-Fs/2:Fs/2-1);
plot(f,abs(log(img_fft)));
xlabel("Frequency")
ylabel("Amplitude")





