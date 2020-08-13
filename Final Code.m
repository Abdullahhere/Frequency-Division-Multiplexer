%******************TASK1:Loading 4 Audio Signals******************
[a,Fs]=audioread('Abdullah_audio.wav');
[b,Fs]=audioread('Ayesha_audio.wav');
[c,Fs]=audioread('Saad_audio.wav');
[d,Fs]=audioread('Zainab_audio.wav');

%------------Extra audio signals for better presentation----------
[e,Fs]=audioread('starting_audio.wav');
[f,Fs]=audioread('ending_audio.wav');

%------------Equalizing lengths of all audio signals--------------
max_length=max([length(a),length(b),length(c),length(d)]);%max command selects the largest length  
a(length(a)+1:max_length)=0;%padding of zeros in Abdullah_audio up to largest length
b(length(b)+1:max_length)=0;%padding of zeros in Ayesha_audio up to largest length
c(length(c)+1:max_length)=0;%padding of zeros in Saad_audio up to largest length
d(length(d)+1:max_length)=0;%padding of zeros in Zainab_audio up to largest length

%---------------Time Indexing for all audio signals----------------
t=linspace(0,length(a)/Fs,length(a));

%***********TASK2:Designing LPF of 3kHz cut-off frequency************
lpf_design=LPF_FINAL;%function call 
w=filter(lpf_design,a);%Passing Abdullah_audio through lpf
x=filter(lpf_design,b);%Passing Ayesha_audio through lpf
y=filter(lpf_design,c);%Passing Saad_audio through lpf
z=filter(lpf_design,d);%Passing Zainab_audio through lpf

%************TASK3:Generating four Cosine Carrier Signals************
cos3k=cos(2*pi*3000*t);%Cosine Signal of frequency 3kHz
cos9k=cos(2*pi*9000*t);%Cosine Signal of frequency 9kHz
cos15k=cos(2*pi*15000*t);%Cosine Signal of frequency 15kHz
cos21k=cos(2*pi*21000*t);%Cosine Signal of frequency 21kHz

%**************TASK5:Modulation of Transmitted Signals****************
mod_1=cos3k'.* w;%Modulation of Abdullah_audio with cos3k
mod_2=cos9k'.* x;%Modulation of Ayesha_audio with cos9k
mod_3=cos15k'.* y;%Modulation of Saad_audio with cos15k
mod_4=cos21k'.* z;%Modulation of Zainab_audio with cos21k

%*************TASK6:Adding all Transmitted Modulated Signals***********
addition=mod_1+mod_2+mod_3+mod_4;

%*****TASK7:Designing Bpf and Recovering 4 signals at receiver end******
%---------Recovering Abdullah_audio signal at receiver end--------------
b1 = bandpass3k;%functioncall for bpf of range 1-3kHz
bpass_a=filter(b1,addition);%Passing Abdullah_audio through bpf
mod_bpass_a=cos3k'.*bpass_a;%Modulation of received audio signal with cos3k
recovered_a=4.2*filter(lpf_design,mod_bpass_a);%Passing received signal throuh lpf and recovering by doing scaling by factor of 4.2

%-----------Recovering Ayesha_audio signal at receiver end---------------
b2 = bandpass9k;%functioncall for bpf of range 6k-9kHz
bpass_b=filter(b2,addition);%Passing Ayesha_audio through bpf
mod_bpass_b=cos9k'.*bpass_b;%Modulation of received audio signal with cos9k
recovered_b=4.6*filter(lpf_design,mod_bpass_b);%Passing received signal throuh lpf and recovering by doing scaling by factor of 4.6

%-------------Recovering Saad_audio signal at receiver end----------------
b3 = bandpass15k;%functioncall for bpf of range 12k-15kHz
bpass_c=filter(b3,addition);%Passing Saad_audio through bpf
mod_bpass_c=cos15k'.*bpass_c;%Modulation of received audio signal with cos15k
recovered_c=4.5*filter(lpf_design,mod_bpass_c);%Passing received signal throuh lpf and recovering by doing scaling by factor of 4.5

%-------------Recovering Zainab_audio signal at receiver end---------------
b4 = bandpass21k;%functioncall for bpf of range 18k-21kHz
bpass_d=filter(b4,addition);%Passing Zainab_audio through bpf
mod_bpass_d=cos21k'.*bpass_d;%Modulation of received audio signal with cos21k
recovered_d=4.6*filter(lpf_design,mod_bpass_d);%Passing received signal throuh lpf and recovering by doing scaling by factor of 4.6

%**************PLaying Original and Recovered Audio Signals*****************
recovered=[recovered_a(:);recovered_b(:);recovered_c(:);recovered_d(:)];
original=[a(:);b(:);c(:);d(:)];
final_audios=[e(:);original(:);f(:);recovered(:)];%playing audios in concatenation(in chain)
sound(final_audios,Fs);

%********************Function Calls for Plotter Function*********************
Plotter(Fs,a,b,c,d,'ORIGINAL AUDIO SIGNALS IN TIME DOMAIN','ORIGINAL AUDIO SIGNALS IN FREQUENCY DOMAIN',0)
Plotter(Fs,w,x,y,z,'LPF AUDIO SIGNALS IN TIME DOMAIN','LPF AUDIO SIGNALS IN FREQUENCY DOMAIN',0)
Plotter(Fs,cos3k,cos9k,cos15k,cos21k,'COSINE SIGNALS IN TIME DOMAIN','COSINE SIGNALS IN FREQUENCY DOMAIN',0)
Plotter(Fs,mod_1,mod_2,mod_3,mod_4,'MODULATED AUDIO SIGNALS IN TIME DOMAIN','MODULATED AUDIO SIGNALS IN FREQUENCY DOMAIN',0)
Plotter(Fs,addition,0,0,0,'ADDED AUDIO SIGNALS IN TIME DOMAIN','ADDED AUDIO SIGNALS IN FREQUENCY DOMAIN',1)
Plotter(Fs,bpass_a,bpass_b,bpass_c,bpass_d,'BANDPASSED AUDIO SIGNALS IN TIME DOMAIN','BANDPASSED AUDIO SIGNALS IN FREQUENCY DOMAIN',0)  
Plotter(Fs,mod_bpass_a,mod_bpass_b,mod_bpass_c,mod_bpass_d,'MODULATED BANDPASSED AUDIO SIGNALS IN TIME DOMAIN','MODULATED BANDPASSED AUDIO SIGNALS IN FREQUENCY DOMAIN',0)
Plotter(Fs,recovered_a,recovered_b,recovered_c,recovered_d,'RECOVERED AUDIO SIGNALS IN TIME DOMAIN','RECOVERED AUDIO SIGNALS IN FREQUENCY DOMAIN',0)