function [dphase1]=pair2(Y1,Y2,lin,f,time,band)
%lin=r21;
yt=[];
dphase=[];
cw=1490;

for ia=1:181;
    Lg=cosd(ia-1)*lin;
    yt(:,ia)=(360*Lg*f)/cw-360*(floor(Lg*f/cw));
end
A=mod(mod(angle(Y1(1:size(f,2),:)),2*pi)-mod(angle(Y2(1:size(f,2),:)),2*pi),2*pi)*180/pi;

for ki=1:size(time,2)
for fi=1:size(yt,2)
    sovpad1=find(abs(yt(band(1):band(2),fi)-A(band(1):band(2),ki))<15 |...
        abs(yt(band(1):band(2),fi)-A(band(1):band(2),ki))>345);
    dphase(fi,ki)=size(sovpad1,1);
end
end

dphase1=256*dphase/max(max(dphase));
