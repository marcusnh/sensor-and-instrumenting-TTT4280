close all
channels=5;
c=3*10^(8);
f0=24.13*10^(9);
fs=31250;


for i=1:10
   path = ['radar',int2str(i),'.bin'];
   [rawData, nomTp] = raspiImport(path,channels);
   %inter_rawData = interp1((0:Fs - 1),rawData,(0:1/5:Fs - 1));
   Ii=rawData(10000:end,4:4);
   Iq=rawData(10000:end,5:5);
   
%    figure(1)
%    plot(Ii,'b')
%    hold on
%    plot(Iq,'r')
%remove DC-component 
    %Ii=Ii-mean(Ii);
    %plot(Ii(10000:end));
    %Iq=Iq-mean(Iq);
%complex version:
    IQ=Ii+1i*Iq;
    IQ=IQ-mean(IQ);
    
    figure(1)
    plot(real(IQ),'b') 
    hold on
    plot(imag(IQ),'r')
    hold off
    
    Nfft=1024*2^6;
    IQ_fft=fftshift(fft(IQ,Nfft));
    IQ_fft_h=fftshift(fft(IQ.*hanning(length(IQ)),Nfft));
    [maxY,maxX]=max(abs(IQ_fft_h));
    %IQ_fft=20*log10(abs(IQ_fft));
    n=length(IQ);

    f= fs/(Nfft)*[-Nfft/2:1:Nfft/2-1];

    %f = (-length(IQ)/2:length(IQ)/2-1);
    IQ_fft_h = IQ_fft_h/max(IQ_fft_h);
    IQ_fft = IQ_fft/max(IQ_fft);
    
    %sides = 40;
    %newimg_fft(maxX-sides:maxX+sides) = 0;
    %[newmaxY,newmaxX]=max(abs(newimg_fft));
    %fd = abs(newmaxX - maxX);
    fd=f(maxX);
    
    %make plot:
   
    figure(2)
    plot(f/1e3,20*log10(abs(IQ_fft_h)));
    axis([-1 1 -80 10])
    xlabel("Frequency, kHz")
    ylabel("Amplitude, dB")
    grid
    figure(3)
    plot(f/1e3,20*log10(abs(IQ_fft_h)));
    %plot(abs(img_fft));
    axis([-1 1 -80 10]) %Fjerner det vi ikke vil se på og får et finere plot
    title(" Med Hanning filter")
    xlabel("Frequency, kHz")
    ylabel("Amplitude, dB")
    grid
    speed= (fd*c)/(2*f0);
    fprintf("The speed of car %i is: %.2f m/s\n",i,speed);

end













