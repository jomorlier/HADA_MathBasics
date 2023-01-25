clear all ;close all;
%Q1
dt = .01; 
maxt = 1;
t = 0:dt:(maxt-dt);
nt = length(t);  %length of t

nCycles = 5;
amp = 1; 
phase = 0;
y5 = amp*cos(2*pi*t*nCycles-pi*phase/180); 
figure(1) 
plot(t,y5); xlabel('Time (s)'); set(gca,'XTick',0:.2:maxt); set(gca,'YTick',-1:1); ylabel('Amplitude'); set(gca,'YLim',amp*1.1*[-1,1]);  %'grid' draws dotted lines at the x and y-tick values 
grid

%Q2
Y5 = fft(y5); 
%Taille de y5 et Y5 ?
whos y5 Y5 
%Classe de Y ?
Y5(1:10)'

%Q3
nCycles = 7; 
amp = 2;  %around 1.15 
phase = 30;  %degrees  
y7 = amp*cos(2*pi*t*nCycles-pi*phase/180); 
figure(1)
hold on
plot(t,y7,'r-'); xlabel('Time (s)'); 
set(gca,'XTick',0:.2:maxt); 
set(gca,'YTick',-1:1); 
ylabel('Amplitude'); 
set(gca,'YLim',amp*1.1*[-1,1]);
axis square 
grid off  
Y7 = fft(y7);



%Q4
figure
plot([0,2*Y5(6)/nt],'b-'); hold on
h5=plot(2*Y5(6)/nt,'bo','MarkerFaceColor','b');
axis equal  
xlabel('Real component')
ylabel('Imaginary component');
hold on
plot([0,2*Y7(8)/nt],'r-');
h7= plot(2*Y7(8)/nt,'ro','MarkerFaceColor','r');
set(gca,'XLim',1.1*amp*[-1,1]); 
set(gca,'YLim',1.1*amp*[-1,1]);


amp5 = 2*abs(Y5(6))/nt; 
phase5 = -180*angle(Y5(6))/pi;
amp7 = 2*abs(Y7(8))/nt; 
phase7 = -180*angle(Y7(8))/pi;


%Q5
y57 = y5+y7;  
figure 
plot(t,y57); xlabel('Time (s)');
set(gca,'XTick',0:.2:2); 
set(gca,'YTick',-1:1); ylabel('Amplitude');


%Tracer son spectre en utilisant ?fft?

Y57 = fft(y57);  
% We'll plot the amplitudes of the first 10 sinusoids as a 'stem' plot 
id = 2:11;  %sinusoids of periods 1 through 10  
figure
stem(2*abs(Y57(id))/nt,'fill')  
xlabel('Number of cycles') 
ylabel('Amplitude');

%Q6
Fs=1/dt;
F=(0:nt-1)*Fs/nt;
figure
stem(F,2*abs(Y57)/nt,'fill') 
xlabel('Hz');
ylabel('Amplitude');

%Q7
figure;
y = zeros(size(t)); y(20) = 1;  plotFFT(t,y);
figure;
y = randn(size(t)); plotFFT(t,y);
figure;
nCycles = 12; y = y+sin(2*pi*nCycles*t); plotFFT(t,y);

%Q8
load handel 
%The file contains two variables, the time-course of the sound, y and the sampling rate, Fs (in Hz). We can create our own time vector from this information:
maxt = length(y)/Fs;
t = linspace(0,maxt,length(y));  
% Here's a plot of the time-course of the sound hander
% 
% figure
% plot(t,y);
% xlabel('Time (sec)');

%L?Žcouter maintenant?en appuyant sur une touche
%pause;
%ylim = get(gca,'YLim');
%timeH = plot([0,0],ylim','r-','LineWidth',2);  
sound(y,Fs);  tic 
% while toc<maxt     
% set(timeH,'XData',toc*[1,1])     
% drawnow 
% end  
% delete(timeH);

%Visualier le spectre (amplitude) et le signal temporel
figure;
plotFFT(t,y);

%Q9
tLo = .7; tHi = .9;  
y1 = y(t>tLo & t<tHi); 
maxt = length(y1)/Fs; 
t1 = t(t>tLo & t<tHi);  %linspace(0,maxt,length(y1));
figure;
%sound(y1,Fs);
plotFFT(t1,y1) ;

%Q10
figure
spectrogram(y,256,120,256,Fs); % Display the spectrogram

%Q11
Ts=0.05;
Fs=1/Ts;
load data;
u=data(:,1);
ys=data(:,2);
t=0:Ts:(length(u)-1)*Ts;
figure; subplot(211);plot(t,u);subplot(212);plot(t,ys);
[txy,f]=tfestimate(u,ys,[],[],[],Fs);
figure
semilogx(f,(abs(txy)))



