%{
=================================
The function calculates the exact direction (depth from 0 to 180 degrees 
and bearing from -180 to +180 degrees) to the source for the specified
sound fragment for all 6 pairs of hydrophones.
=================================
%}
to=4.995; % total time of calculated sound
t1i=4.43; % start time of fragment
t2i=4.944; % end time of fragment

d=1.8;
fii=-179:180;
thi=0:179;

t1=round(size(dphase21,2)*(t1i/to));
t2=round(size(dphase21,2)*(t2i/to));

A1=mean(dphase43(:,t1:t2),2);
A2=mean(dphase21(:,t1:t2),2);
A3=mean(dphase41(:,t1:t2),2);
A4=mean(dphase42(:,t1:t2),2);
A5=mean(dphase23(:,t1:t2),2);
A6=mean(dphase13(:,t1:t2),2);

A=[A1,A2,A3,A4,A5,A6];
t=[t43,t21,t41,t42,t23,t13];
j=[j43,j21,j41,j42,j23,j13];

[R Th Fi nv]=scancrosNout(A,'array4-06-tetr',d,2);

figure
image(fii,thi,flipdim(rot90(180*(R-mean(mean(R)))./(max(Th)-mean(mean(R)))),1));
set(gca,'YTick',0:15:180,'XTick',-180:15:180,...
                'YLim',[0 180],'XLim',[-180 180])
colormap jet(180)

[Tha Thi]=max(Th);
[Fia Fii]=max(Fi);
depth=thi(Thi)
bearing=fii(Fii)