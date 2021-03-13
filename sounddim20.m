

filename1 = 'exemple_KW.WAV';           %file name of sound

infoF1 = audioinfo(filename1);

Fs=infoF1.SampleRate;
Ee=infoF1.TotalSamples;
nch=infoF1.NumChannels;

yn=[];
Y1=[];
Y2=[];
Y3=[];
Y4=[];

ttt=0;                                     %sart time of fragment
t1=(0*60+ttt)*Fs+1;
dt=5*Fs;                                   %longth of fragment
[yn(:,1:4)]=audioread(filename1,[t1 t1+dt]);

e=size(yn);                             % e(1) - length of signal e(2)- number of channel 
t=(0:(e(1)-1))*(1/Fs);

NT=2048;                                % window FFT 
f = (Fs/2)*linspace(0,1,NT/2);          % frequency direction
band=[find(f<100,1) find(f>=48000,1)];  % frequency band for analisis
w=NT/2;                                 % width analyse window at time
time=0; i=0; co=0; j=0;

x1=[-0.174 -0.3 0];
x2=[-0.174 0.3 0];
x3=[0.35 0 0];
x4=[0 0 -0.5];
x21=[x1(1)-x2(1) x1(2)-x2(2) x1(3)-x2(3)];
x41=[x1(1)-x4(1) x1(2)-x4(2) x1(3)-x4(3)];
x13=[x3(1)-x1(1) x3(2)-x1(2) x3(3)-x1(3)];
x23=[x3(1)-x2(1) x3(2)-x2(2) x3(3)-x2(3)];
x43=[x3(1)-x4(1) x3(2)-x4(2) x3(3)-x4(3)];
x42=[x2(1)-x4(1) x2(2)-x4(2) x2(3)-x4(3)];
r21=sqrt(x21(1)^2+x21(2)^2+x21(3)^2);
t21=acosd(x21(3)/r21);
j21=atan2(x21(2),x21(1))*180/pi;
r41=sqrt(x41(1)^2+x41(2)^2+x41(3)^2);
t41=acosd(x41(3)/r41);
j41=atan2(x41(2),x41(1))*180/pi;
r13=sqrt(x13(1)^2+x13(2)^2+x13(3)^2);
t13=acosd(x13(3)/r13);
j13=atan2(x13(2),x13(1))*180/pi;
r23=sqrt(x23(1)^2+x23(2)^2+x23(3)^2);
t23=acosd(x23(3)/r23);
j23=atan2(x23(2),x23(1))*180/pi;
r43=sqrt(x43(1)^2+x43(2)^2+x43(3)^2);
t43=acosd(x43(3)/r43);
j43=atan2(x43(2),x43(1))*180/pi;
r42=sqrt(x42(1)^2+x42(2)^2+x42(3)^2);
t42=acosd(x42(3)/r42);
j42=atan2(x42(2),x42(1))*180/pi;

 for st=1:w:e(1)-NT
    i=i+1;                              % counter of analyse step at time
    Y1(:,i) = fft(yn(st:st+NT,1),NT);   % spectrum of first channel
    Y2(:,i) = fft(yn(st:st+NT,2),NT);   % spectrum of second channel
    Y3(:,i) = fft(yn(st:st+NT,3),NT);   % spectrum of first channel
    Y4(:,i) = fft(yn(st:st+NT,4),NT);   % spectrum of second channel
    time(i)=t(st);                      % time direction

 end
 PPP=abs(Y1(1:NT/2,:))+abs(Y2(1:NT/2,:))+abs(Y3(1:NT/2,:))+abs(Y4(1:NT/2,:));
 minP=min(min(PPP));
 lPP=log(PPP/min(min(PPP)));
 
%43
dphase43=pair2(Y3,Y4,r43,f,time,band);
%23
dphase23=pair2(Y3,Y2,r23,f,time,band);
%13
dphase13=pair2(Y3,Y1,r13,f,time,band);
%42
dphase42=pair2(Y2,Y4,r42,f,time,band);
%41
dphase41=pair2(Y1,Y4,r41,f,time,band);
%21
dphase21=pair2(Y1,Y2,r21,f,time,band);


 subplot(1,1,1);
        hl1=image(time,f/1000,256*(lPP./max(max(lPP))));
        newplot(hl1);
        colormap(jet)
        set(gca,'XTick',0:0.5:time(size(time,2)),'YTick',0:2:f(size(f,2))/1000,...
                'XLim',[0 time(size(time,2))],'YLim',[0 f(size(f,2))/1000])
            
 figure
 subplot(1,1,1);
        hl2=image(time,1:181,dphase21);
        newplot(hl2);
        colormap(jet)
        set(gca,'XTick',0:0.5:time(size(time,2)),'YTick',0:5:181,...
                'XLim',[0 time(size(time,2))],'YLim',[0 181])
            
 figure
 subplot(1,1,1);
        hl3=image(time,1:181,dphase23);
        newplot(hl3);
        colormap(jet)
        set(gca,'XTick',0:0.5:time(size(time,2)),'YTick',0:5:181,...
                'XLim',[0 time(size(time,2))],'YLim',[0 181])
 figure
 subplot(1,1,1);
        hl3=image(time,1:181,dphase13);
        newplot(hl3);
        colormap(jet)
        set(gca,'XTick',0:0.5:time(size(time,2)),'YTick',0:5:181,...
                'XLim',[0 time(size(time,2))],'YLim',[0 181])

            
            
 %}
            
