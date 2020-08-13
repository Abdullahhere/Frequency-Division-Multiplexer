function[]=Plotter(Fs,a,b,c,d,v,m,k)
%a,b,c,d are the four signals as arguments
%v variable defined for title string for time domain
%m variable defined for title string for freq domain
%k variable differentiate between addition plot and other plots.It is 1 only in case of plot of addition of modulated signals

t=linspace(0,length(a)/Fs,length(a));%time indexing

if(k==1 )%check if k==1 otherwise jump to else
figure; subplot(2,1,1); plot(t,a,'m');title(v);xlabel('Added Audio signal');ylabel('MagVsTime');grid on;
fft_added = fftshift(fft(a));%Fourier Transform of signal
freq_added = (Fs/length(t))*(-length(t)/2:length(t)/2-1);%freq axix indexing
subplot(2,1,2);plot(freq_added,abs(fft_added),'c');title(m);xlabel('Added Audio signal');ylabel('MagVsFreq');grid on;
else 
%--------------------------------TIME DOMAIN PLOTS----------------------------------
figure;subplot(4,1,1),plot(t,a,'m');title(v);xlabel('Abdullah Audio');ylabel('MagVsTime');grid on;
subplot(4,1,2),plot(t,b,'m');xlabel('Ayesha Audio');ylabel('MagVsTime');grid on;
subplot(4,1,3),plot(t,c,'m');xlabel('Saad Audio');ylabel('MagVsTime');grid on;
subplot(4,1,4),plot(t,d,'m');xlabel('Zainab Audio');ylabel('MagVsTime');grid on;
%---------------------------FREQUENCY DOMAIN PLOTS-----------------------------------
fft1 = fftshift(fft(a));%Fourier transform of first signal
fft2 = fftshift(fft(b));%Fourier transform of second signal
fft3 = fftshift(fft(c));%Fourier transform of third signal
fft4 = fftshift(fft(d));%Fourier transform of four signal
freq1 = (Fs/length(t))*(-length(t)/2:length(t)/2-1);%Freq axis indexing
figure;subplot(4,1,1),plot(freq1,abs(fft1),'c');title(m);xlabel('Abdullah Audio');ylabel('MagVsFreq');grid on;
subplot(4,1,2),plot(freq1,abs(fft2),'c');xlabel('Ayesha Audio');ylabel('MagVsFreq');grid on;
subplot(4,1,3),plot(freq1,abs(fft3),'c');xlabel('Saad Audio');ylabel('MagVsFreq');grid on;
subplot(4,1,4),plot(freq1,abs(fft4),'c');xlabel('Zainab Audio');ylabel('MagVsFreq');grid on;
end
end
